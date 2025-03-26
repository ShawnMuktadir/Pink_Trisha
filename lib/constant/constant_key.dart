enum AppConstant {
  USER_ID,
  googleClientDevKey,
  TOKEN,
  REMEMBER_ME,
  LANGUAGE,
  YYYY_MM_DD,
  DD_MM_YYYY,
  DD_MM_YYYY_SLASH,
  D_MMM_Y_HM,
  D_MMM_Y,
  D_MM_Y,
  YYYY_MM,
  MMM,
  MMMM,
  MMMM_Y,
  APPLICATION_JSON,
  BEARER,
  MULTIPART_FORM_DATA,
  IS_SWITCHED,
  DEVICE_ID,
  DEVICE_OS,
  USER_AGENT,
  APP_VERSION,
  BUILD_NUMBER,
  ANDROID,
  IOS,
  IPN_URL,
  STORE_ID,
  STORE_PASSWORD,
  SSL_STORE_ID_LIVE,
  SSL_STORE_PASSWORD_LIVE,
  MOBILE,
  EMAIL,
  PUSH_ID,
  EN,
  BN,
  FONTFAMILY,
}

extension AppConstantExtention on AppConstant {
  String get key {
    switch (this) {
      case AppConstant.USER_ID:
        return "USER_ID";
      case AppConstant.TOKEN:
        return "PINK_TOKEN";
      case AppConstant.REMEMBER_ME:
        return "rememberMe";
      case AppConstant.LANGUAGE:
        return "language";
      case AppConstant.DD_MM_YYYY:
        return "dd-MM-yyyy";
      case AppConstant.DD_MM_YYYY_SLASH:
        return "dd/MM/yyyy hh:mm a";
      case AppConstant.D_MMM_Y_HM:
        return "d MMMM y hh:mm a";
      case AppConstant.D_MM_Y:
        return "d MMM y";
      case AppConstant.D_MMM_Y:
        return "d MMMM y";
      case AppConstant.MMMM_Y:
        return "MMMM y";
      case AppConstant.MMM:
        return "MMM";
      case AppConstant.googleClientDevKey:
        return "451418365198-f5m73kls5n8huphhhfs58jtjjlu0ee7g.apps.googleusercontent.com";
        //return "103872284767-he3d71v1e1o1ouiv0g1h295rrv3emb9b.apps.googleusercontent.com";
      case AppConstant.YYYY_MM:
        return 'yyyy-MM';
      case AppConstant.YYYY_MM_DD:
        return "yyyy-MM-dd";
      case AppConstant.APPLICATION_JSON:
        return "application/json";
      case AppConstant.BEARER:
        return "Bearer";
      case AppConstant.MULTIPART_FORM_DATA:
        return "multipart/form-data";
      case AppConstant.IS_SWITCHED:
        return "IS_SWITCHED";
      case AppConstant.USER_AGENT:
        return "user-agent";
      case AppConstant.BUILD_NUMBER:
        return "build";
      case AppConstant.DEVICE_ID:
        return "device-id";
      case AppConstant.APP_VERSION:
        return "app-version";
      case AppConstant.DEVICE_OS:
        return "device-os";
      case AppConstant.PUSH_ID:
        return "push-id";
      case AppConstant.ANDROID:
        return "android";
      case AppConstant.IOS:
        return "ios";
      case AppConstant.IPN_URL:
        return "ipn_url";
      case AppConstant.STORE_ID:
        return "pinkb65b9d3b67e2ee";
      case AppConstant.STORE_PASSWORD:
        return "pinkb65b9d3b67e2ee@ssl";
      case AppConstant.SSL_STORE_ID_LIVE:
        return "pinktrisha0live";
      case AppConstant.SSL_STORE_PASSWORD_LIVE:
        return "65B87A32F21C031052";
      case AppConstant.MOBILE:
        return "mobile";
      case AppConstant.EMAIL:
        return "email";
      case AppConstant.EN:
        return 'en';
      case AppConstant.BN:
        return 'bn';
      case AppConstant.FONTFAMILY:
        return 'Poppins';

      default:
        return "";
    }
  }
}
