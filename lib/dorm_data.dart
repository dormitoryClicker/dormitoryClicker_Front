import 'package:flutter/material.dart';

class DormData extends ChangeNotifier{
  Map<dynamic, List<Map>> machines = {
    '오름관 1동' : [
      {
        'machineNum': "W1",
        'startTime': ['2022-11-16 18:00:00', '2022-11-16 19:40:00', '2022-11-16 22:00:00', '2022-11-17 12:00:00', "2022-11-18 10:00:00", "2022-11-18 18:30:00"],
        'endTime': ['2022-11-16 19:20:00', '2022-11-16 21:00:00', '2022-11-16 24:00:00', '2022-11-17 13:40:00', "2022-11-18 12:10:00", "2022-11-18 19:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ['2022-11-16 19:00:00', '2022-11-16 20:40:00', '2022-11-16 22:10:00', '2022-11-17 13:00:00', "2022-11-18 11:00:00", "2022-11-18 19:30:00"],
        'endTime': ['2022-11-16 20:20:00', '2022-11-16 22:00:00', '2022-11-16 23:40:00', '2022-11-17 14:40:00', "2022-11-18 13:10:00", "2022-11-18 20:30:00"],
      },
      {
        'machineNum': "W3",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "W4",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "D1",
        'startTime': ['2022-11-16 20:20:00', '2022-11-17 14:40:00'],
        'endTime': ['2022-11-16 22:00:00', '2022-11-17 16:20:00'],
      },
      {
        'machineNum': "D2",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
    ],
    '오름관 2동' : [
      {
        'machineNum': "W1",
        'startTime': ['2022-11-16 18:00:00', '2022-11-16 19:40:00', '2022-11-16 22:00:00', '2022-11-17 12:00:00', "2022-11-18 10:00:00", "2022-11-18 18:30:00"],
        'endTime': ['2022-11-16 19:20:00', '2022-11-16 21:00:00', '2022-11-16 24:00:00', '2022-11-17 13:40:00', "2022-11-18 12:10:00", "2022-11-18 19:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ['2022-11-16 19:00:00', '2022-11-16 20:40:00', '2022-11-16 22:10:00', '2022-11-17 13:00:00', "2022-11-18 11:00:00", "2022-11-18 19:30:00"],
        'endTime': ['2022-11-16 20:20:00', '2022-11-16 22:00:00', '2022-11-16 23:40:00', '2022-11-17 14:40:00', "2022-11-18 13:10:00", "2022-11-18 20:30:00"],
      },
      {
        'machineNum': "W3",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "W4",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "D1",
        'startTime': ['2022-11-16 20:20:00', '2022-11-17 14:40:00'],
        'endTime': ['2022-11-16 22:00:00', '2022-11-17 16:20:00'],
      },
      {
        'machineNum': "D2",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
    ],
    '오름관 3동' : [
      {
        'machineNum': "W1",
        'startTime': ['2022-11-16 18:00:00', '2022-11-16 19:40:00', '2022-11-16 22:00:00', '2022-11-17 12:00:00', "2022-11-18 10:00:00", "2022-11-18 18:30:00"],
        'endTime': ['2022-11-16 19:20:00', '2022-11-16 21:00:00', '2022-11-16 24:00:00', '2022-11-17 13:40:00', "2022-11-18 12:10:00", "2022-11-18 19:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ['2022-11-16 19:00:00', '2022-11-16 20:40:00', '2022-11-16 22:10:00', '2022-11-17 13:00:00', "2022-11-18 11:00:00", "2022-11-18 19:30:00"],
        'endTime': ['2022-11-16 20:20:00', '2022-11-16 22:00:00', '2022-11-16 23:40:00', '2022-11-17 14:40:00', "2022-11-18 13:10:00", "2022-11-18 20:30:00"],
      },
      {
        'machineNum': "W3",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "W4",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "D1",
        'startTime': ['2022-11-16 20:20:00', '2022-11-17 14:40:00'],
        'endTime': ['2022-11-16 22:00:00', '2022-11-17 16:20:00'],
      },
      {
        'machineNum': "D2",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
    ],
    '푸름관 1동' : [
      {
        'machineNum': "W1",
        'startTime': ['2022-11-16 18:00:00', '2022-11-16 19:40:00', '2022-11-16 22:00:00', '2022-11-17 12:00:00', "2022-11-18 10:00:00", "2022-11-18 18:30:00"],
        'endTime': ['2022-11-16 19:20:00', '2022-11-16 21:00:00', '2022-11-16 24:00:00', '2022-11-17 13:40:00', "2022-11-18 12:10:00", "2022-11-18 19:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ['2022-11-16 19:00:00', '2022-11-16 20:40:00', '2022-11-16 22:10:00', '2022-11-17 13:00:00', "2022-11-18 11:00:00", "2022-11-18 19:30:00"],
        'endTime': ['2022-11-16 20:20:00', '2022-11-16 22:00:00', '2022-11-16 23:40:00', '2022-11-17 14:40:00', "2022-11-18 13:10:00", "2022-11-18 20:30:00"],
      },
      {
        'machineNum': "W3",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "W4",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "D1",
        'startTime': ['2022-11-16 20:20:00', '2022-11-17 14:40:00'],
        'endTime': ['2022-11-16 22:00:00', '2022-11-17 16:20:00'],
      },
      {
        'machineNum': "D2",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
    ],
    '푸름관 2동' : [
      {
        'machineNum': "W1",
        'startTime': ['2022-11-16 18:00:00', '2022-11-16 19:40:00', '2022-11-16 22:00:00', '2022-11-17 12:00:00', "2022-11-18 10:00:00", "2022-11-18 18:30:00"],
        'endTime': ['2022-11-16 19:20:00', '2022-11-16 21:00:00', '2022-11-16 24:00:00', '2022-11-17 13:40:00', "2022-11-18 12:10:00", "2022-11-18 19:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ['2022-11-16 19:00:00', '2022-11-16 20:40:00', '2022-11-16 22:10:00', '2022-11-17 13:00:00', "2022-11-18 11:00:00", "2022-11-18 19:30:00"],
        'endTime': ['2022-11-16 20:20:00', '2022-11-16 22:00:00', '2022-11-16 23:40:00', '2022-11-17 14:40:00', "2022-11-18 13:10:00", "2022-11-18 20:30:00"],
      },
      {
        'machineNum': "W3",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "W4",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "D1",
        'startTime': ['2022-11-16 20:20:00', '2022-11-17 14:40:00'],
        'endTime': ['2022-11-16 22:00:00', '2022-11-17 16:20:00'],
      },
      {
        'machineNum': "D2",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
    ],
    '푸름관 3동' : [
      {
        'machineNum': "W1",
        'startTime': ['2022-11-16 18:00:00', '2022-11-16 19:40:00', '2022-11-16 22:00:00', '2022-11-17 12:00:00', "2022-11-18 10:00:00", "2022-11-18 18:30:00"],
        'endTime': ['2022-11-16 19:20:00', '2022-11-16 21:00:00', '2022-11-16 24:00:00', '2022-11-17 13:40:00', "2022-11-18 12:10:00", "2022-11-18 19:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ['2022-11-16 19:00:00', '2022-11-16 20:40:00', '2022-11-16 22:10:00', '2022-11-17 13:00:00', "2022-11-18 11:00:00", "2022-11-18 19:30:00"],
        'endTime': ['2022-11-16 20:20:00', '2022-11-16 22:00:00', '2022-11-16 23:40:00', '2022-11-17 14:40:00', "2022-11-18 13:10:00", "2022-11-18 20:30:00"],
      },
      {
        'machineNum': "W3",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "W4",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "D1",
        'startTime': ['2022-11-16 20:20:00', '2022-11-17 14:40:00'],
        'endTime': ['2022-11-16 22:00:00', '2022-11-17 16:20:00'],
      },
      {
        'machineNum': "D2",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
    ],
    '푸름관 4동' : [
      {
        'machineNum': "W1",
        'startTime': ['2022-11-16 18:00:00', '2022-11-16 19:40:00', '2022-11-16 22:00:00', '2022-11-17 12:00:00', "2022-11-18 10:00:00", "2022-11-18 18:30:00"],
        'endTime': ['2022-11-16 19:20:00', '2022-11-16 21:00:00', '2022-11-16 24:00:00', '2022-11-17 13:40:00', "2022-11-18 12:10:00", "2022-11-18 19:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ['2022-11-16 19:00:00', '2022-11-16 20:40:00', '2022-11-16 22:10:00', '2022-11-17 13:00:00', "2022-11-18 11:00:00", "2022-11-18 19:30:00"],
        'endTime': ['2022-11-16 20:20:00', '2022-11-16 22:00:00', '2022-11-16 23:40:00', '2022-11-17 14:40:00', "2022-11-18 13:10:00", "2022-11-18 20:30:00"],
      },
      {
        'machineNum': "W3",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "W4",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
      {
        'machineNum': "D1",
        'startTime': ['2022-11-16 20:20:00', '2022-11-17 14:40:00'],
        'endTime': ['2022-11-16 22:00:00', '2022-11-17 16:20:00'],
      },
      {
        'machineNum': "D2",
        'startTime': List<String>.empty(growable: true),
        'endTime': List<String>.empty(growable: true),
      },
    ],
  };

  Map? findMachine(String dormitory, String machineNum){
    late Map machine;
    if(machines[dormitory] != null){
      for(int i = 0; i < machines[dormitory]!.length; i++) {
        if (machines[dormitory]![i]['machineNum'] == machineNum) {
          machine = machines[dormitory]![i];
          return machine;
        }
      }
      return null;
    }
    return null;
  }

  void addReservation(String dormitory, String machineNum, String startTime, String endTime){
    if(machines[dormitory] != null){
      for(int i = 0; i < machines[dormitory]!.length; i++) {
        if (machines[dormitory]![i]['machineNum'] == machineNum) {
          List<String> tempStartTime = machines[dormitory]![i]['startTime'];
          tempStartTime.add(startTime);
          machines[dormitory]![i]['startTime'] = tempStartTime;
          List<String> tempEndTime = machines[dormitory]![i]['endTime'];
          tempEndTime.add(endTime);
          machines[dormitory]![i]['endTime'] = tempEndTime;
          break;
        }
      }
    }
    notifyListeners();
  }

  void deleteReservation(String dormitory, String machineNum, String startTime, String endTime){
    for(int i = 0; i < machines[dormitory]!.length; i++) {
      if (machines[dormitory]![i]['machineNum'] == machineNum) {
        List<String> tempStartTime = machines[dormitory]![i]['startTime'];
        tempStartTime.remove(startTime);
        machines[dormitory]![i]['startTime'] = tempStartTime;
        List<String> tempEndTime = machines[dormitory]![i]['endTime'];
        tempEndTime.remove(endTime);
        machines[dormitory]![i]['endTime'] = tempEndTime;
        break;
      }
    }
    notifyListeners();
  }
}