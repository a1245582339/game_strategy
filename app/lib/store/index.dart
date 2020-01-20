import 'package:flutter/material.dart';
class Store with ChangeNotifier {
  Map _userInfo = {};
  Store ();
  void setUserInfo (Map userInfo) {
      this._userInfo = userInfo;
      notifyListeners();
  }
  void clearUserInfo () {
      this._userInfo = {};
      notifyListeners();
  }
  get getUserInfo => this._userInfo;
}