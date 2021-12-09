import 'package:shared_preferences/shared_preferences.dart';

saveUserPref(String token) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.getString(
    "token",
  );
}
