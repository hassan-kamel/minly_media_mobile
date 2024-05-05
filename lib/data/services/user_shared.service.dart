import 'package:shared_preferences/shared_preferences.dart';

class UserShared {
  SharedPreferences? pref;

  Future<void> getInstance() async {
    pref = await SharedPreferences.getInstance();
  }

  // set user token
  void setToken(String token) async {
    if (pref == null) await getInstance();
    pref?.setString('token', token);
  }

  // get user token
  Future<String?> getToken() async {
    if (pref == null) await getInstance();
    return pref?.getString('token');
  }
}
