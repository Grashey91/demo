import 'package:flutter/material.dart';
import 'package:flutter_application_1/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  String mobileKey = 'Mobile No.';
  String tokenKey = 'Token';
  String passwordKey = 'Password';

  String _mobile = "";
  String _token = "";
  String _password = "";

  get mobile => _mobile;
  get password => _password;
  get token => _token;

  set mobile(value) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setString(mobileKey, value);
      _mobile = value;
    });
  }

  set token(value) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setString(tokenKey, value);
      _token = value;
    });
  }

  set password(value) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setString(passwordKey, value);
      _password = value;
    });
  }

  Future<String> getMobile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _password = sharedPreferences.getString(mobileKey).toString();

    return _password;
  }

  Future<String> getPassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _password = sharedPreferences.getString(passwordKey).toString();
    return _password;
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _token = sharedPreferences.getString(tokenKey).toString();
    return _token;
  }

  void clearSharedPref(context) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.clear();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ));
    });
  }
}
