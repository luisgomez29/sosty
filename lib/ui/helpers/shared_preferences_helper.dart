import 'package:sosty/ui/common/enums/shared_preferences_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  /// Save value to not show on boarding screens again
  static Future<void> saveSeenOnboard() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferencesEnum.seenOnboard.value, true);
  }

  static Future<void> saveUserSessionData(accessToken, userId, userType, balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      SharedPreferencesEnum.accessToken.value,
      accessToken,
    );
    await prefs.setString(
      SharedPreferencesEnum.userId.value,
      userId,
    );
    await prefs.setString(
      SharedPreferencesEnum.userType.value,
      userType,
    );
    await prefs.setInt(
      SharedPreferencesEnum.balance.value,
      balance,
    );
  }

  static Future<void> deleteUserSessionData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesEnum.accessToken.value);
    await prefs.remove(SharedPreferencesEnum.userId.value);
    await prefs.remove(SharedPreferencesEnum.userType.value);
    await prefs.remove(SharedPreferencesEnum.balance.value);
  }
}
