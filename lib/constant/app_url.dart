import '../utils/enum.dart';

enum AppUrl {
  base,
  baseImage,
  signInUrl,
  googleLogin,
  fbLogin,
  signUpUrl,
  updateProfileUrl,
  updateProfilePicture,
  profileUrl,
  home,
  featureProduct,
  homeCountry,
  homeCountryProductType,
  homePriceCalculation,
  homeReviewPrice,
  homeReviewPriceConfirmation,
  getHomeReviewPrice,
  productDetails,
  productList,
  brandProducts,
  categoryProducts,
  relatedProducts,
  productSearchUrl,
  productFilterUrl,
  updateAddress,
  addAddressUrl,
  allAddressUrl,
  category,
  topBrandsSeeAll,
  orderCreate,
  paymentSuccess,
  paymentFailed,
  wishList,
  createWish,
  deleteWish,
  myOrders,
  signInSocial,
  orderDetails,
  resetPasswordInit,
  resetPasswordSubmit,
  deleteAccountUrl,
}

extension AppUrlExtention on AppUrl {
  static String _baseUrl = "";
  static String _baseImageUrl = "";

  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = "https://core.pinktrisha.com/";
        _baseImageUrl = "";

        break;

      case UrlLink.isDev:
        _baseUrl = "https://core.pinktrisha.com/";
        _baseImageUrl = "";

        break;
      case UrlLink.isLocalServer:
        // set up your local server ip address.
        _baseUrl = "";
        break;
    }
  }

  String get url {
    switch (this) {
      case AppUrl.base:
        return _baseUrl;
      case AppUrl.baseImage:
        return _baseImageUrl;
      case AppUrl.signUpUrl:
        return 'public/api/v1/auth/sign-up';
      case AppUrl.signInUrl:
        return 'public/api/v1/auth/sign-in';
      case AppUrl.signInSocial:
        return 'public/api/v1/auth/customers-sign-in-with-social';
      case AppUrl.googleLogin:
        return 'public/api/v1/customers-sign-in-with-google';
      case AppUrl.fbLogin:
        return 'public/api/v1/customers-sign-in-with-facebook';
      case AppUrl.updateProfileUrl:
        return 'customer/api/v1/update/profile';
      case AppUrl.home:
        return 'public/api/v1/fetch-home?categoryId={categoryId}&skip={skip}&take={take}';
      case AppUrl.featureProduct:
        return '${_baseUrl}public/api/v1/featured-products';
      case AppUrl.homeCountry:
        return 'public/api/v1/on-demand-countries';
      case AppUrl.homeCountryProductType:
        return 'public/api/v1/on-demand-countries/{onDemandCountryId}/on-demand-product-types';
      case AppUrl.homePriceCalculation:
        return 'public/api/v1/on-demand-price-calculation';
      case AppUrl.homeReviewPrice:
        return 'public/api/v1/on-demand-price';
      case AppUrl.getHomeReviewPrice:
        return 'public/api/v1/on-demand-price/{id}';
      case AppUrl.homeReviewPriceConfirmation:
        return 'customer/api/v1/on-demand-orders?priceId={priceId}';
      case AppUrl.productDetails:
        return 'public/api/v1/products/{slug}';
      case AppUrl.productList:
        return 'public/api/v1/products?take={take}&skip={skip}';
      case AppUrl.relatedProducts:
        return 'public/api/v1/products/{slug}/related-products?search={search}&categoryId={categoryId}';
      case AppUrl.productSearchUrl:
        return 'public/api/v1/products?search={search}&take={take}&skip={skip}';
      case AppUrl.productFilterUrl:
        return 'public/api/v1/products?categoryId={categoryId}&subcategoryId={subcategoryId}&brandIds={brandIds}&typeId={typeId}&minPrice={minPrice}&maxPrice={maxPrice}&sortBy={sortBy}&take={take}&skip={skip}';
      case AppUrl.brandProducts:
        return 'public/api/v1/products?brandIds={brandId}&take={take}&skip={skip}';
      case AppUrl.categoryProducts:
        return 'public/api/v1/products?categoryId={categoryId}&take={take}&skip={skip}';
      case AppUrl.profileUrl:
        return 'customer/api/v1/profile/get/{email}';
      case AppUrl.updateProfilePicture:
        return 'customer/api/v1/update-image';
      case AppUrl.allAddressUrl:
        return 'customer/api/v1/addresses';
      case AppUrl.addAddressUrl:
        return 'customer/api/v1/addresses';
      case AppUrl.updateAddress:
        return 'customer/api/v1/addresses/{id}';
      case AppUrl.orderCreate:
        return 'customer/api/v1/orders';
      case AppUrl.paymentSuccess:
        return 'public/app/api/v1/payment-success/{orderId}';
      case AppUrl.paymentFailed:
        return 'public/app/api/v1/payment-fail/{orderId}';
      case AppUrl.category:
        return 'public/api/v1/hamburger-categories';
      case AppUrl.topBrandsSeeAll:
        return 'public/api/v1/featured-brands';
      case AppUrl.wishList:
        return 'customer/api/v1/wish-list/{customerId}';
      case AppUrl.createWish:
        return 'customer/api/v1/wish-list';
      case AppUrl.deleteWish:
        return 'customer/api/v1/wish-list/{wishId}';
      case AppUrl.myOrders:
        return 'customer/api/v1/orders/{userId}';
      case AppUrl.orderDetails:
        return 'customer/api/v1/orders-status/{orderId}';
      case AppUrl.resetPasswordInit:
        return 'public/api/v1/auth/reset-password-init';
      case AppUrl.resetPasswordSubmit:
        return 'public/api/v1/auth/reset-password-submit';
      case AppUrl.deleteAccountUrl:
        return 'customer/api/v1/customer-account-deletion';
      default:
    }
    return "";
  }
}
