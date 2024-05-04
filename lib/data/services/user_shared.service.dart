import 'package:shared_preferences/shared_preferences.dart';

class UserShared {
  late SharedPreferences pref;

  UserShared() {
    getInstance();
  }

  void getInstance() async {
    pref = await SharedPreferences.getInstance();
  }

  // set user token
  void setToken(String token) {
    pref.setString('token', token);
  }

  // get user token
  String? getToken() {
    return pref.getString('token');
  }
}
