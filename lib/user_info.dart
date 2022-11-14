import 'package:flutter/material.dart';

class UserInfo extends ChangeNotifier{
  String _userName = "", _userId = "", _password = "", _dormitory = "";
  int _macNumber = 0;
  int _reservedNow = 0;

  String getUserName() { return _userName; }
  String getUserId(){ return _userId; }
  String getPassword(){ return _password; }
  String getDormitory(){ return _dormitory; }
  int getMacNumber() { return _macNumber; }
  int getReserved() {return _reservedNow;}

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
  void putMacNumber(int number){
    _macNumber = number;
    notifyListeners();
  }
  void putReserved(int reserve){
    _reservedNow = reserve;
    notifyListeners();
  }

  bool isEmpty(String str){
    return (str == "") ? true : false;
  }
}