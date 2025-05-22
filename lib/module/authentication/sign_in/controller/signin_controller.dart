import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/views/components/auth_textformfield.dart';
import '../../../../utils/enum.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pink_by_trisha_app/constant/app_url.dart';
import 'package:pink_by_trisha_app/constant/constant_key.dart';
import 'package:pink_by_trisha_app/data_provider/api_client.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/controller/signin_state.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/model/signin_model.dart';
import 'package:pink_by_trisha_app/module/authentication/sign_in/model/signin_response.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';
import '../../../../data_provider/storage_controller.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/navigation.dart';
import '../../forgot_password/model/reset_password_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../forgot_password/model/otp_response.dart';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';

final signInController =
    StateNotifierProvider.autoDispose<SignInController, SignInState>(
        (ref) => SignInController());

class SignInController extends StateNotifier<SignInState> {
  SignInController()
      : super(SignInState(
          emailCon: TextEditingController(text: ''),
          passwordCon: TextEditingController(text: ''),
          isButtonEnabled: false,
          isLoginLoading: false,
          isGoogleBtnLoading: false,
          forgotPasswordEmailCon: TextEditingController(text: ''),
          otpEmailCon: TextEditingController(text: ''),
          otpCon: TextEditingController(text: ''),
          isForgotPasswordLoading: false,
          isOtpLoading: false,
        )) {
    state.emailCon.addListener(() {
      checkButtonStatus();
    });
    state.passwordCon.addListener(() {
      checkButtonStatus();
    });
  }

  final formKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  checkButtonStatus() {
    final String email = state.emailCon.text.trim();
    final String password = state.passwordCon.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      state = state.copyWith(isButtonEnabled: true);
    } else {
      state = state.copyWith(isButtonEnabled: false);
    }
  }

  bool isSelect = true;

  Map<String, dynamic>? parseJwt(String? token) {
    // validate token
    if (token == null) return null;
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    // retrieve token payload
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    // convert to Map
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    print(payloadMap);
    return payloadMap;
  }

  /// ==@ Function
  final ApiClient _apiClient = ApiClient();

  Future<void> reqSignInWithGoogle() async {
    try {
      print("Step 1: Function started");
      state = state.copyWith(isGoogleBtnLoading: true);

      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      // Check if user is already signed in
      final bool isGoogleLoggedIn = await googleSignIn.isSignedIn();
      print("Step 2: Already signed in? $isGoogleLoggedIn");

      if (isGoogleLoggedIn) {
        await googleSignIn.signOut();
        print("Step 3: Signed out existing session");
      }

      // Attempt to sign in
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print("Step 4: Google sign-in was canceled by the user.");
        state = state.copyWith(isGoogleBtnLoading: false);
        return;
      }

      print("Step 5: User signed in -> ${googleUser.email}");

      // Get authentication credentials
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      print("Step 6: Received authentication token");
      print("ID Token: ${googleAuth.idToken}");
      print("Access Token: ${googleAuth.accessToken}");

      if (googleAuth.idToken == null) {
        print("Step 7: ID Token is null. Authentication failed.");
        state = state.copyWith(isGoogleBtnLoading: false);
        return;
      }

      // Sign in to Firebase with Google credentials
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      print("Step 8: Firebase Authentication successful -> ${userCredential.user?.displayName}");

      // Parse JWT token
      final Map<String, dynamic>? idMap = parseJwt(googleAuth.idToken!);
      if (idMap == null) {
        print("Step 9: Failed to parse JWT.");
        state = state.copyWith(isGoogleBtnLoading: false);
        return;
      }

      print("Step 10: Parsed JWT -> $idMap");

      // Extract user details
      final String firstName = idMap["given_name"] ?? "Unknown";
      final String lastName = idMap["family_name"] ?? "Unknown";

      print("Step 11: Extracted user info -> First Name: $firstName, Last Name: $lastName");

      // Create API request body
      final Map<String, dynamic> apiRequestBody = {
        "email": googleUser.email,
        "firstName": firstName,
        "lastName": lastName,
        "secretKey": "\$\$\$asdfgh123456\$\$\$",
      };

      print("Step 12: API request body -> $apiRequestBody");

      // Call API
      await _apiClient.request(
        url: AppUrl.signInSocial.url,
        method: MethodType.POST,
        data: apiRequestBody,
        hasHeader: false,
        onSuccessFunction: (response) async {
          print("Step 13: API Response -> ${jsonEncode(response.data)}");

          if (response.data != null) {
            final SignInModel signInModel = SignInModel.fromJson(response.data);

            if (signInModel.statusCode == 200) {
              print("Step 14: Login successful! Saving user data.");
              await PrefHelper.setString(AppConstant.TOKEN.key, signInModel.data?.accessToken ?? "");
              await PrefHelper.setString(AppConstant.USER_ID.key, signInModel.data?.customer?.id.toString() ?? "");
              await PrefHelper.setString(AppConstant.EMAIL.key, signInModel.data?.customer?.email.toString() ?? "");
              await PrefHelper.setBool(AppConstant.REMEMBER_ME.key, true);

              await StorageController.setLoggedIn();
              Future(() => Navigation.pushAndRemoveUntil(
                  Navigation.key.currentContext,
                  appRoutes: AppRoutes.dashboard));

              print("Step 15: Navigation to Dashboard successful!");
            } else {
              print("Step 16: API Error -> ${signInModel.message}");
            }
          } else {
            print("Step 17: API response data is null.");
          }
        },
      );
    } catch (e) {
      print("Step 18: Exception occurred -> $e");
      ViewUtil.SSLSnackbar("Something went wrong");
    }

    state = state.copyWith(isGoogleBtnLoading: false);
    print("Step 19: Function completed.");
  }

  /*Future<void> reqSignInWithGoogle() async {
    try {
      print("Step 1: Function started");

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      // Check if user is already signed in
      final bool isGoogleLoggedIn = await googleSignIn.isSignedIn();
      print("Step 2: Already signed in? $isGoogleLoggedIn");

      if (isGoogleLoggedIn) {
        await googleSignIn.signOut();
        print("Step 3: Signed out existing session");
      }

      // Attempt to sign in
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print("Step 4: Google sign-in was canceled by the user.");
        return;
      }

      print("Step 5: Google Sign-In successful");
      print("User Name: ${googleUser.displayName}");
      print("User Email: ${googleUser.email}");
      print("Profile Picture: ${googleUser.photoUrl}");

      // Stop loading state
    } catch (e) {
      print("Step 6: Exception occurred -> $e");
    }
    print("Step 7: Function completed.");
  }*/

  /*Future<void> reqSignInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print("User canceled the sign-in");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      print("User signed in: ${userCredential.user?.displayName}");
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }*/


  //
  // Future<void> reqSignInWithFB() async {
  //   print("1");
  //   // state = state.copyWith(isGoogleBtnLoading: true);
  //
  //   try {
  //     print("2");
  //     // Create an instance of FacebookLogin
  //     final fb = FacebookLogin();
  //     print("3");
  //     // Log in
  //     final isFBLoggedIn = await fb.isLoggedIn;
  //     print("4 $isFBLoggedIn");
  //     if (isFBLoggedIn) await fb.logOut();
  //     final isFBLoggedIn2 = await fb.isLoggedIn;
  //     print("4 $isFBLoggedIn2");
  //     print("5");
  //     final res = await fb.logIn(permissions: [
  //       FacebookPermission.publicProfile, // permission to get public profile
  //       FacebookPermission.email, // permission to get email address
  //     ]);
  //     print("6 ${res.status}");
  //     // Check result status
  //     switch (res.status) {
  //       case FacebookLoginStatus.success:
  //         final FacebookAccessToken? accessToken =
  //             res.accessToken; // get accessToken for auth login
  //         final profile = await fb.getUserProfile(); // get profile of user
  //         final imageUrl =
  //             await fb.getProfileImageUrl(width: 100); // get user profile image
  //         final email = await fb.getUserEmail(); // get user's email address
  //
  //         print("6");
  //         print('Access token: ${accessToken?.token}');
  //         print('Hello, ${profile!.name}! You ID: ${profile.userId}');
  //         print('Your profile image: $imageUrl');
  //         if (email != null) print('And your email is $email');
  //         print("6 id token is ${accessToken?.token}");
  //
  //         // Here you can send the necessary data to your API
  //
  //         final Map<String, dynamic> apiRequestBody = {
  //           "email": email,
  //           "firstName":
  //               profile.firstName, // Use the given name provided by Google
  //           "lastName":
  //               profile.lastName, // Use the family name provided by Google
  //           "secretKey": "\$\$\$asdfgh123456\$\$\$",
  //         };
  //         log("apiRequestBody $apiRequestBody");
  //         //"clientId": AppConstant.googleClientDevKey.key,
  //         log('token is : ${jsonEncode(accessToken?.token)}');
  //         print("7");
  //
  //         await _apiClint
  //             .request(
  //           url: AppUrl.signInSocial.url,
  //           method: Method.POST,
  //           data: apiRequestBody,
  //           onSuccessFunction: (response) async {
  //             log('Response${jsonEncode(response.data)}');
  //
  //             if (response.data != null) {
  //               'response is: ${jsonEncode(response.data)}'.log();
  //               final SignInModel signInModel =
  //                   SignInModel.fromJson(response.data);
  //               log('Response${signInModel.statusCode}');
  //               if (signInModel.statusCode == 200) {
  //                 final String accessToken =
  //                     signInModel.data?.accessToken ?? "";
  //                 final String userId =
  //                     signInModel.data?.customer?.id.toString() ?? "";
  //                 final String email =
  //                     signInModel.data?.customer?.email.toString() ?? "";
  //                 // await PrefHelper.setString(
  //                 //     AppConstant.TOKEN.key, accessToken);
  //                 // await PrefHelper.setString(AppConstant.USER_ID.key, userId);
  //                 // await PrefHelper.setString(AppConstant.EMAIL.key, email);
  //                 // await PrefHelper.setBool(AppConstant.REMEMBER_ME.key, true);
  //                 // // After successful login
  //                 // await StorageController.setLoggedIn();
  //                 // Future(() => Navigation.pushAndRemoveUntil(
  //                 //     Navigation.key.currentContext,
  //                 //     appRoutes: AppRoutes.dashboard));
  //
  //                 log("Success Message: ${signInModel.message}");
  //               } else if (signInModel.statusCode == 401) {
  //                 log("Handle Error: ${signInModel.message}");
  //               } else {
  //                 // ==? Handle Error
  //               }
  //             } else {
  //               // Handle the case when the response data is null
  //               log('Response data is null');
  //             }
  //           },
  //         )
  //             .catchError((e) {
  //           ViewUtil.SSLSnackbar("Something went wrong");
  //           log('Exception in reqSignInWithFB: $e');
  //         });
  //         //push to success page after successfully signed in
  //         // Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //         builder: ((context) => SuccessLoginPage(
  //         //               fbAccessToken: accessToken!.token,
  //         //               profileImage: imageUrl!,
  //         //               fbName: profile.name!,
  //         //               fbId: profile.userId,
  //         //               fbEmail: email!,
  //         //             ))));
  //
  //         break;
  //       case FacebookLoginStatus.cancel:
  //         // User cancel log in
  //         break;
  //       case FacebookLoginStatus.error:
  //         // Log in failed
  //         print('Error while log in: ${res.error}');
  //         break;
  //     }
  //   } on Exception catch (e) {
  //     ViewUtil.SSLSnackbar("Something went wrong");
  //
  //     log('Exception in reqSignInWithFB: $e');
  //   }
  //
  //   //  state = state.copyWith(isGoogleBtnLoading: false);
  // }

  Future<void> reqSignIn(BuildContext context) async {
    try {
      state = state.copyWith(isLoginLoading: true);
      SignInResponse? signInResponse;
      if (formKey.currentState!.validate()) {
        signInResponse = SignInResponse(
          email: state.emailCon.text.trim(),
          password: state.passwordCon.text.trim(),
        );

        log('Email: ${state.emailCon.text.trim()}');
        log('Pass: ${state.passwordCon.text.trim()}');
        log('Pass: ${signInResponse.toJson()}');

        if (isSelect == true) {
          await PrefHelper.setBool(AppConstant.REMEMBER_ME.key, true);
          // await SharedPreferences.getInstance().then((prefs) {
          //   prefs.setBool(AppConstant.REMEMBER_ME.key, true);
          // });
        } else {
          await PrefHelper.remove(AppConstant.REMEMBER_ME.key);
          // await SharedPreferences.getInstance().then((prefs) {
          //   prefs.remove(AppConstant.REMEMBER_ME.key);
          // });
        }
      }

      SignInData signInData = SignInData();
      await _apiClient.request(
          url: AppUrl.signInUrl.url,
          method: MethodType.POST,
          token: signInData.accessToken,
          data: signInResponse!.toJson(),
          onSuccessFunction: (response) async {
            log('Response${jsonEncode(response.data)}');

            if (response.data != null) {
              'response is: ${jsonEncode(response.data)}'.log();
              final SignInModel signInModel =
                  SignInModel.fromJson(response.data);
              log('Response${signInModel.statusCode}');
              if (signInModel.statusCode == 200) {
                final String accessToken = signInModel.data?.accessToken ?? "";
                final String userId =
                    signInModel.data?.customer?.id.toString() ?? "";
                final String email =
                    signInModel.data?.customer?.email.toString() ?? "";
                await PrefHelper.setString(AppConstant.TOKEN.key, accessToken);
                await PrefHelper.setString(AppConstant.USER_ID.key, userId);
                await PrefHelper.setString(AppConstant.EMAIL.key, email);

                // After successful login
                await StorageController.setLoggedIn();
                Future(() => Navigation.pushAndRemoveUntil(context,
                    appRoutes: AppRoutes.dashboard));

                log("Success Message: ${signInModel.message}");
              } else if (signInModel.statusCode == 401) {
                log("Handle Error: ${signInModel.message}");
              } else {
                // ==? Handle Error
              }
            } else {
              // Handle the case when the response data is null
              log('Response data is null');
            }
          });
      // if(isSelect == true){
      //
      // } else{
      //   ViewUtil.SSLSnackbar("You can't select checkbox");
      // }
    } catch (e) {
      // Handle exceptions
      log('Exception in reqSignIn: $e');
    }
    state = state.copyWith(isLoginLoading: false);
  }

  Future<void> reqForgotPassword(BuildContext context) async {
    try {
      state = state.copyWith(isForgotPasswordLoading: true);
      if (forgotPasswordFormKey.currentState!.validate()) {
        log('forgotPasswordEmailCon: ${state.forgotPasswordEmailCon.text.trim()}');
      }
      await _apiClient.request(
          url: AppUrl.resetPasswordInit.url,
          method: MethodType.POST,
          // token: signInData.accessToken,
          data: {"email": state.forgotPasswordEmailCon.text},
          onSuccessFunction: (response) async {
            log('Response${jsonEncode(response.data)}');

            if (response.data != null) {
              'response is: ${jsonEncode(response.data)}'.log();
              final ResetPasswordResponse resetPasswordResponse =
                  ResetPasswordResponse.fromJson(response.data);
              log('Response${resetPasswordResponse.statusCode}');
              if (resetPasswordResponse.statusCode == 200) {
                state.forgotPasswordEmailCon.clear();
                Future(() => Navigation.pushReplacement(context,
                    appRoutes: AppRoutes.otp));

                EasyLoading.showSuccess(resetPasswordResponse.message);
                log("Success Message: ${resetPasswordResponse.message}");
              } else if (resetPasswordResponse.statusCode == 401) {
                EasyLoading.showError(resetPasswordResponse.message);
                log("Handle Error: ${resetPasswordResponse.message}");
              } else {
                EasyLoading.showError("Something went wrong!");
                // ==? Handle Error
              }
            } else {
              EasyLoading.showError("Something went wrong!");
              // Handle the case when the response data is null
              log('Response data is null');
            }
          });
    } catch (e) {
      // Handle exceptions
      //  EasyLoading.showError("Something went wrong!");
      log('Exception in reqSignIn: $e');
    }
    state = state.copyWith(isForgotPasswordLoading: false);
  }

  Future<void> reqOtp(BuildContext context) async {
    try {
      state = state.copyWith(isOtpLoading: true);
      if (otpFormKey.currentState!.validate()) {
        log('otpCon: ${state.otpCon.text.trim()}');
        log('otpEmailCon: ${state.otpEmailCon.text.trim()}');
      }
      await _apiClient.request(
          url: AppUrl.resetPasswordSubmit.url,
          method: MethodType.POST,
          // token: signInData.accessToken,
          data: {"email": state.otpEmailCon.text, "otp": state.otpCon.text},
          onSuccessFunction: (response) async {
            log('Response${jsonEncode(response.data)}');

            if (response.data != null) {
              'response is: ${jsonEncode(response.data)}'.log();
              final ResetPasswordResponse resetPasswordResponse =
                  ResetPasswordResponse.fromJson(response.data);
              log('Response${resetPasswordResponse.statusCode}');
              if (resetPasswordResponse.statusCode == 200) {
                state.otpEmailCon.clear();
                state.otpCon.clear();

                Future(() => Navigation.pop(context));

                EasyLoading.showSuccess(resetPasswordResponse.message);
                log("Success Message: ${resetPasswordResponse.message}");
              } else if (resetPasswordResponse.statusCode == 401) {
                EasyLoading.showError(resetPasswordResponse.message);
                log("Handle Error: ${resetPasswordResponse.message}");
              } else {
                EasyLoading.showError("Something went wrong!");
                // ==? Handle Error
              }
            } else {
              EasyLoading.showError("Something went wrong!");
              // Handle the case when the response data is null
              log('Response data is null');
            }
          });
    } catch (e) {
      // Handle exceptions
      //EasyLoading.showError("Something went wrong!");
      log('Exception in reqSignIn: $e');
    }
    state = state.copyWith(isOtpLoading: false);
  }
}
