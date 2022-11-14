import 'package:flutter/material.dart';

class UsersData extends ChangeNotifier{
  List<Map> users = [
    {
      'userName' : "금오공",
      'userId' : "20221111",
      'password' : "1234",
      'dormitory' : "오름관 1동",
      'canReservation' : false,
      'machineNum' : "W1",
      'startTime' : "2022-11-14 03:22:00",
      'endTime' : "2022-11-14 03:58:00"
    },
    {
      'userName' : "김남수",
      'userId' : "20180100",
      'password' : "1234",
      'dormitory' : "오름관 3동",
      'canReservation' : true,
      'machineNum' : "",
      'startTime' : "",
      'endTime' : ""
    },
  ];

  void addUser(String userName, String userId, String password, String dormitory){
    users.add({
      'userName' : userName,
      'userId' : userId,
      'password' : password,
      'dormitory' : dormitory,
      'canReservation' : true,
      'machineNum' : "",
      'startTime' : "",
      'endTime' : ""
    });
    notifyListeners();
  }

  Map? findUser(String userId){
    late Map user;
    for(int i = 0; i < users.length; i++) {
      if (users[i]['userId'] == userId) {
        user = users[i];
        return user;
      }
    }
    return null;
  }

  void deleteReservation(String userId){
    Map? user;
    if ((user = findUser(userId)) != null) {
      user!['canReservation'] = true;
      user['machineNum'] = "";
      user['startTime'] = "";
      user['endTime'] = "";
    }
    notifyListeners();
  }

  void changeDormitory(String userId, String dormitory){
    Map? user;
    if ((user = findUser(userId)) != null) {
      user!['dormitory'] = dormitory;
    }
    notifyListeners();
  }
}