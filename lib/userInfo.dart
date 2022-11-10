import 'package:flutter/material.dart';

class UserInfo extends ChangeNotifier{
  String _userName = "", _userId = "", _password = "", _dormitory = "";

  String getUserName() { return _userName; }
  String getUserId(){ return _userId; }
  String getPassword(){ return _password; }
  String getDormitory(){ return _dormitory; }

  void putUserName(String name){
    _userName = name;
    notifyListeners();
  }
  void putUserId(String id){
    _userId = id;
    notifyListeners();
  }
  void putPassword(String password){
    _password = password;
    notifyListeners();
  }
  void putDormitory(String dormitory){
    _dormitory = dormitory;
    notifyListeners();
  }

  bool isEmpty(String str){
    return (str == "") ? true : false;
  }
}