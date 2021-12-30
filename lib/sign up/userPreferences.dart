import 'package:shared_preferences/shared_preferences.dart';

saveUserPref(String token, String id, String fName, String lName, String phone,
    String email, String ageStatus) async {
  print("ageStatus..." + ageStatus.toString());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("token", token);
  sharedPreferences.setString("id", id);
  sharedPreferences.setString("fName", fName);
  sharedPreferences.setString("lName", lName);
  sharedPreferences.setString("Phone", phone);
  sharedPreferences.setString("Email", email);
  sharedPreferences.setString("ageStatus", ageStatus);
}
