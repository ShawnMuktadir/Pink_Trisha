enum KAssetName {
  icActiveCarouselpng,
  icAliExpresspng,
  icBagpng,
  icBkashpng,
  icNogot,
  icDemoBestDealpng,
  icFilterpng,
  icInactiveCarouselpng,
  icMakeupjpg,
  icProfilejpg,
  icShirtpng,
  icSplashBackgroundpng,
  icWatchpng,
  icWatch2png,
  selectUsapng,
  Aliexpress_logopng,
  Amazon_logopng,
  bannerpng,
  Best_Buy_logo_2018png,
  EBay_logopng,
  image246png,
  image248png,
  manpng,
  wepikexport20230916060006mEdf1png,
  watch_beltpng,
  watch_belt2png,
  icEmptyImagepng,
  icEmptyImage2png,
  icCategoryBackgroundpng,
  icSaveMoneyBadgesvg,
  icAccountSelectedsvg,
  icAccountUnselectedsvg,
  icAppLogosvg,
  icArrowBacksvg,
  icArrowDownsvg,
  icArrowUpsvg,
  icArrowRightsvg,
  icArrowLeftsvg,
  icBackButtonsvg,
  icPreorderLogosvg,
  icCartButtonSelectedsvg,
  icCartButtonUnselectedsvg,
  icCartSelectedsvg,
  icCartUnselectedsvg,
  icCategorySelectedsvg,
  icCategoryUnselectedsvg,
  icDeliveryHandsvg,
  icDeliveryTrucksvg,
  icEditPicturesvg,
  icEditProfilesvg,
  icFacebooksvg,
  icDeleteButtonsvg,
  icGooglesvg,
  icHeartPinksvg,
  icHeartRedsvg,
  icHeartGreysvg,
  icHomeSelectedsvg,
  icHomeUnselectedsvg,
  icMansvg,
  icOnprocesssvg,
  icOrderConfirmsvg,
  icRoundedCheckmarksvg,
  icSearchsvg,
  icSearchSmallsvg,
  icWelcomeLogosvg,
  icWishEmptysvg,
  icWomansvg,
  icCategoryBackgroundsvg,
  icCheckboxUnselectedsvg,
  icCart,
  icConfirmOrder,
  icCheckMarkSelectedsvg,
  icCheckMarkUnselectedsvg,
  icStarYellowsvg,
  icProductMinussvg,
  icProductPlussvg,
  icCheckMarkDeepsvg,
  icCheckMarkPinksvg,
  icClosesvg,
  icPlusWhitesvg,
  icAddresssvg,
  icMyOrder,
  icWishList,
  icPaymentMethod,
  icFaq,
  icTermsCondition,
  icHelpSuppont,
  icLogOut,
  primaryLogopng,
  saveMoneyBadgepng,
}

extension AssetsExtension on KAssetName {
  String get imagePath {
    const String _rootPath = 'assets';
    const String _imagesDir = '$_rootPath/images';
    const String _static_imagesDir = '$_rootPath/static_images';
    const String _svgDir = '$_rootPath/svg';
    switch (this) {
      case KAssetName.primaryLogopng:
        return '$_imagesDir/primaryLogo.png';
      case KAssetName.saveMoneyBadgepng:
        return '$_imagesDir/saveMoneyBadge.png';
      case KAssetName.icActiveCarouselpng:
        return '$_imagesDir/icActiveCarousel.png';
      case KAssetName.icAliExpresspng:
        return '$_imagesDir/icAliExpress.png';
      case KAssetName.icBagpng:
        return '$_imagesDir/icBag.png';
      case KAssetName.icBkashpng:
        return '$_imagesDir/icBkash.png';
      case KAssetName.icNogot:
        return '$_imagesDir/icNogot.png';
      case KAssetName.icDemoBestDealpng:
        return '$_imagesDir/icDemoBestDeal.png';
      case KAssetName.icFilterpng:
        return '$_imagesDir/icFilter.png';
      case KAssetName.icInactiveCarouselpng:
        return '$_imagesDir/icInactiveCarousel.png';
      case KAssetName.icMakeupjpg:
        return '$_imagesDir/icMakeup.jpg';
      case KAssetName.icProfilejpg:
        return '$_imagesDir/icProfile.jpg';
      case KAssetName.icShirtpng:
        return '$_imagesDir/icShirt.png';
      case KAssetName.icSplashBackgroundpng:
        return '$_imagesDir/icSplashBackground.png';
      case KAssetName.icWatchpng:
        return '$_imagesDir/icWatch.png';
      case KAssetName.icWatch2png:
        return '$_imagesDir/icWatch2.png';
      case KAssetName.selectUsapng:
        return '$_imagesDir/selectUsa.png';
      case KAssetName.icCart:
        return '$_imagesDir/icCart.png';
      case KAssetName.icConfirmOrder:
        return '$_imagesDir/icConfirmOrder.png';
      case KAssetName.icEmptyImagepng:
        return '$_imagesDir/icEmptyImage.png';
      case KAssetName.icEmptyImage2png:
        return '$_imagesDir/icEmptyImage2.png';
      case KAssetName.icCategoryBackgroundpng:
        return '$_imagesDir/icCategoryBackground.png';
      case KAssetName.Aliexpress_logopng:
        return '$_static_imagesDir/Aliexpress_logo.png';
      case KAssetName.Amazon_logopng:
        return '$_static_imagesDir/Amazon_logo.png';
      case KAssetName.bannerpng:
        return '$_static_imagesDir/banner.png';
      case KAssetName.Best_Buy_logo_2018png:
        return '$_static_imagesDir/Best_Buy_logo_2018.png';
      case KAssetName.EBay_logopng:
        return '$_static_imagesDir/EBay_logo.png';
      case KAssetName.image246png:
        return '$_static_imagesDir/image246.png';
      case KAssetName.image248png:
        return '$_static_imagesDir/image248.png';
      case KAssetName.manpng:
        return '$_static_imagesDir/man.png';
      case KAssetName.wepikexport20230916060006mEdf1png:
        return '$_static_imagesDir/wepikexport20230916060006mEdf1.png';
      case KAssetName.watch_beltpng:
        return '$_static_imagesDir/watch_belt.png';
      case KAssetName.watch_belt2png:
        return '$_static_imagesDir/watch_belt2.png';

      case KAssetName.icSaveMoneyBadgesvg:
        return '$_svgDir/icSaveMoneyBadge.svg';
      case KAssetName.icDeleteButtonsvg:
        return '$_svgDir/icDeleteButton.svg';
      case KAssetName.icAccountSelectedsvg:
        return '$_svgDir/icAccountSelected.svg';
      case KAssetName.icAccountUnselectedsvg:
        return '$_svgDir/icAccountUnselected.svg';
      case KAssetName.icAppLogosvg:
        return '$_svgDir/icAppLogo.svg';
      case KAssetName.icCategoryBackgroundsvg:
        return '$_svgDir/icCategoryBackground.svg';
      case KAssetName.icPreorderLogosvg:
        return '$_svgDir/icPreorderLogo.svg';
      case KAssetName.icArrowBacksvg:
        return '$_svgDir/icArrowBack.svg';
      case KAssetName.icArrowDownsvg:
        return '$_svgDir/icArrowDown.svg';
      case KAssetName.icArrowUpsvg:
        return '$_svgDir/icArrowUp.svg';
      case KAssetName.icArrowRightsvg:
        return '$_svgDir/icArrowRight.svg';
      case KAssetName.icArrowLeftsvg:
        return '$_svgDir/icArrowLeft.svg';
      case KAssetName.icBackButtonsvg:
        return '$_svgDir/icBackButton.svg';
      case KAssetName.icCartButtonSelectedsvg:
        return '$_svgDir/icCartButtonSelected.svg';
      case KAssetName.icCartButtonUnselectedsvg:
        return '$_svgDir/icCartButtonUnselected.svg';
      case KAssetName.icCartSelectedsvg:
        return '$_svgDir/icCartSelected.svg';
      case KAssetName.icCartUnselectedsvg:
        return '$_svgDir/icCartUnselected.svg';
      case KAssetName.icCategorySelectedsvg:
        return '$_svgDir/icCategorySelected.svg';
      case KAssetName.icCategoryUnselectedsvg:
        return '$_svgDir/icCategoryUnselected.svg';
      case KAssetName.icDeliveryHandsvg:
        return '$_svgDir/icDeliveryHand.svg';
      case KAssetName.icDeliveryTrucksvg:
        return '$_svgDir/icDeliveryTruck.svg';
      case KAssetName.icEditPicturesvg:
        return '$_svgDir/icEditPicture.svg';
      case KAssetName.icEditProfilesvg:
        return '$_svgDir/icEditProfile.svg';
      case KAssetName.icFacebooksvg:
        return '$_svgDir/icFacebook.svg';
      case KAssetName.icGooglesvg:
        return '$_svgDir/icGoogle.svg';
      case KAssetName.icHeartPinksvg:
        return '$_svgDir/icHeartPink.svg';
      case KAssetName.icHeartRedsvg:
        return '$_svgDir/icHeartRed.svg';
      case KAssetName.icHeartGreysvg:
        return '$_svgDir/icHeartGrey.svg';
      case KAssetName.icHomeSelectedsvg:
        return '$_svgDir/icHomeSelected.svg';
      case KAssetName.icHomeUnselectedsvg:
        return '$_svgDir/icHomeUnselected.svg';
      case KAssetName.icMansvg:
        return '$_svgDir/icMan.svg';
      case KAssetName.icOnprocesssvg:
        return '$_svgDir/icOnprocess.svg';
      case KAssetName.icOrderConfirmsvg:
        return '$_svgDir/icOrderConfirm.svg';
      case KAssetName.icRoundedCheckmarksvg:
        return '$_svgDir/icRoundedCheckmark.svg';
      case KAssetName.icSearchsvg:
        return '$_svgDir/icSearch.svg';
      case KAssetName.icSearchSmallsvg:
        return '$_svgDir/icSearchSmall.svg';
      case KAssetName.icWelcomeLogosvg:
        return '$_svgDir/icWelcomeLogo.svg';
      case KAssetName.icWishEmptysvg:
        return '$_svgDir/icWishEmpty.svg';
      case KAssetName.icCheckboxUnselectedsvg:
        return '$_svgDir/icCheckboxUnselected.svg';
      case KAssetName.icWomansvg:
        return '$_svgDir/icWoman.svg';
      case KAssetName.icCheckMarkSelectedsvg:
        return '$_svgDir/icCheckMarkSelected.svg';
      case KAssetName.icCheckMarkUnselectedsvg:
        return '$_svgDir/icCheckMarkUnselected.svg';
      case KAssetName.icStarYellowsvg:
        return '$_svgDir/icStarYellow.svg';
      case KAssetName.icProductMinussvg:
        return '$_svgDir/icProductMinus.svg';
      case KAssetName.icProductPlussvg:
        return '$_svgDir/icProductPlus.svg';
      case KAssetName.icCheckMarkPinksvg:
        return '$_svgDir/icCheckMarkPink.svg';
      case KAssetName.icCheckMarkDeepsvg:
        return '$_svgDir/icCheckMarkDeep.svg';
      case KAssetName.icClosesvg:
        return '$_svgDir/icClose.svg';
      case KAssetName.icPlusWhitesvg:
        return '$_svgDir/icPlusWhite.svg';
      case KAssetName.icAddresssvg:
        return '$_svgDir/icAddressButton.svg';
      case KAssetName.icMyOrder:
        return '$_svgDir/icMyOrder.svg';
      case KAssetName.icWishList:
        return '$_svgDir/icWishlist.svg';
      case KAssetName.icPaymentMethod:
        return '$_svgDir/icPaymentMethods.svg';
      case KAssetName.icFaq:
        return '$_svgDir/icFAQ.svg';
      case KAssetName.icTermsCondition:
        return '$_svgDir/icTerms&Conditions.svg';
      case KAssetName.icHelpSuppont:
        return '$_svgDir/icHelp.svg';
      case KAssetName.icLogOut:
        return '$_svgDir/icLogIn.svg';
    }
    return '';
  }
}
