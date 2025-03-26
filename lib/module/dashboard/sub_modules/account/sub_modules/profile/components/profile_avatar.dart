import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pink_by_trisha_app/global/widget/global_image_loader.dart';
import 'package:pink_by_trisha_app/global/widget/global_svg_loader.dart';
import 'package:pink_by_trisha_app/module/dashboard/sub_modules/account/sub_modules/profile/controller/profile_controller.dart';
import 'package:pink_by_trisha_app/utils/enum.dart';
import 'package:pink_by_trisha_app/utils/navigation.dart';
import 'package:pink_by_trisha_app/utils/styles/k_assets.dart';
import 'package:pink_by_trisha_app/utils/styles/k_colors.dart';
import 'package:pink_by_trisha_app/utils/view_util.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final controller = ref.read(profileController.notifier);
        final state = ref.watch(profileController);

        return Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 16),
          child: SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: state.uploadingImageLink.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              ViewUtil.showAlertDialog(
                                  content: Image.file(
                                File(state.uploadingImageLink),
                                fit: BoxFit.fitWidth,
                                // height: 120,
                                // width: 120,
                              ));
                            },
                            child: Image.file(
                              File(state.uploadingImageLink),
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            ),
                          )
                        : state.fetchProfile?.imageUrl != null
                            ? InkWell(
                                onTap: () {
                                  ViewUtil.showAlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: Stack(
                                      children: [
                                        GlobalImageLoader(
                                          fit: BoxFit.fitWidth,
                                          imageFor: ImageFor.network,
                                          imagePath: state
                                                  .fetchProfile?.imageUrl ??
                                              "", //KAssetName.icProfilejpg.imagePath,
                                        ),
                                        Positioned(
                                            right: 5,
                                            top: 5,
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: Colors.black,
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigation.pop(context);
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  )),
                                            )),
                                      ],
                                    ),
                                  );
                                },
                                child: GlobalImageLoader(
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: 120,
                                  imageFor: ImageFor.network,
                                  imagePath: state.fetchProfile?.imageUrl ??
                                      "", //KAssetName.icProfilejpg.imagePath,
                                ),
                              )
                            : Icon(
                                Icons.person_2,
                                size: 120,
                                color: KColor.primary.color.withOpacity(.6),
                              ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: KColor.background2.color,
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          controller.openGallery(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GlobalSvgLoader(
                                imagePath:
                                    KAssetName.icEditPicturesvg.imagePath)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
