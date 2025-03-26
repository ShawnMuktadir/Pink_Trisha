import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//localization
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pink_by_trisha_app/module/authentication/splash/views/splash.dart';
import 'package:pink_by_trisha_app/utils/app_version.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/network_connection.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'constant/app_url.dart';
import 'data_provider/pref_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  //Set Portrait Mode only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

/// Make sure you always init shared pref first. It has token and token is need
/// to make API call

initServices() async {
  await Firebase.initializeApp();
  AppUrlExtention.setUrl(
    kDebugMode ? UrlLink.isDev : UrlLink.isLive,
  );
  await PrefHelper.init();
  await AppVersion.getVersion();
  await NetworkConnection.instance.InternetAvailable();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return ScreenUtilInit(
        //Change the height and Width based on design
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (ctx, child) {
          return MaterialApp(
            builder: EasyLoading.init(),
            title: 'pink_by_trishaa_app',
            navigatorKey: Navigation.key,
            debugShowCheckedModeBanner: false,
            //localization
            // supportedLocales: AppLocalizations.supportedLocales,
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            // locale: (PrefHelper.getLanguage() == 1)
            //     ? const Locale('en', 'US')
            //     : const Locale('bn', 'BD'),
            theme: ThemeData(
              progressIndicatorTheme: ProgressIndicatorThemeData(
                color: KColor.secondary.color,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              primaryColor: KColor.primary.color,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme: ThemeData().colorScheme.copyWith(
                    secondary: KColor.secondary.color,
                  ),
            ),
            home: child,
          );
        },
        child: const SplashScreen());
  }
}
