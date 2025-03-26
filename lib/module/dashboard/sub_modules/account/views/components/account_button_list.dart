import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/data_provider/storage_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/controller/profile_controller.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/views/components/account_button.dart';
import 'package:pink_by_trisha_app/utils/app_routes.dart';
import 'package:pink_by_trisha_app/utils/extension.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/styles.dart';

class AccountButtonList extends StatefulWidget {
  const AccountButtonList({super.key});

  @override
  State<AccountButtonList> createState() => _AccountButtonListState();
}

class _AccountButtonListState extends State<AccountButtonList> {
  int selectIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final controller = context.read(profileController.notifier);
    Future(() async {
      await controller.getProfile();
    });
  }

  List<AccountMenuModel> accountList = [
    AccountMenuModel(
        text: 'My Profile', img: KAssetName.icAccountUnselectedsvg.imagePath),
    AccountMenuModel(
      text: 'Addresses',
      img: KAssetName.icAddresssvg.imagePath,
    ),
    AccountMenuModel(text: 'My Order', img: KAssetName.icMyOrder.imagePath),
    AccountMenuModel(text: 'Wishlist', img: KAssetName.icWishList.imagePath),
    AccountMenuModel(text: 'FAQ', img: KAssetName.icFaq.imagePath),
    // AccountMenuModel(
    //     text: 'Payment Methods', img: KAssetName.icPaymentMethod.imagePath),
    AccountMenuModel(
        text: 'Terms & Conditions', img: KAssetName.icTermsCondition.imagePath),
    // AccountMenuModel(
    //     text: 'Help & Support', img: KAssetName.icHelpSuppont.imagePath),
    AccountMenuModel(text: 'Logout', img: KAssetName.icLogOut.imagePath),
  ];

  void _handleLogOut(BuildContext context) async {
    await StorageController.setLoggedOut();

    Future(
        () => Navigation.pushReplacement(context, appRoutes: AppRoutes.signIn));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, child) {
      final state = ref.watch(profileController);
      return ListView.builder(
          itemCount: accountList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectIndex = index;
                  print('Index: $selectIndex');
                  print('Index: $index');
                });
                switch (index) {
                  case 0:
                    Navigation.push(context,
                        appRoutes: AppRoutes.profile,
                        arguments: state.fetchProfile);
                    break;
                  case 1:
                    Navigation.push(context, appRoutes: AppRoutes.address);
                    break;
                  case 2:
                    Navigation.push(context, appRoutes: AppRoutes.myOrder);
                    break;
                  case 3:
                    Navigation.push(context, appRoutes: AppRoutes.wishlist);
                    break;
                  case 4:
                    Navigation.push(context, appRoutes: AppRoutes.faq);
                    break;

                  case 5:
                    Navigation.push(context,
                        appRoutes: AppRoutes.termsAndCondition);
                    break;

                  case 6:
                    _handleLogOut(context);
                    // Navigation.push(context, appRoutes: AppRoutes.helpAndSupport);
                    break;
                }
              },
              child: AccountButton(
                isSelected: index,
                selectIndex: selectIndex,
                iconName: accountList[index].img,
                title: accountList[index].text,
                // onTap: () => Navigation.push(context, appRoutes: AppRoutes.profile, arguments: state.fetchProfile),
              ),
            );
          });
    });
  }
}

class AccountMenuModel {
  final String img;
  final String text;

  AccountMenuModel({required this.img, required this.text});
}
