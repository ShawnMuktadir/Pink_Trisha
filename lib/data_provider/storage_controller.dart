import 'package:pink_by_trisha_app/constant/constant_key.dart';
import 'package:pink_by_trisha_app/data_provider/pref_helper.dart';

class StorageController {
  static const String isLoggedInKey = 'isLoggedIn';

  static bool get isLoggedIn {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    return PrefHelper.getBool(isLoggedInKey) ?? false;
  }

  static Future<void> setLoggedIn() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    await PrefHelper.setBool(isLoggedInKey, true);
  }

  static Future<void> setLoggedOut() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    await PrefHelper.setBool(isLoggedInKey, false);
    await PrefHelper.setString(AppConstant.TOKEN.key, "");
    await PrefHelper.setString(AppConstant.USER_ID.key, "");
    await PrefHelper.setString(AppConstant.EMAIL.key, "");
  }
}
