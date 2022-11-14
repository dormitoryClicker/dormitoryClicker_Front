import 'package:flutter/material.dart';

class DormData extends ChangeNotifier{
  Map<dynamic, List<Map>> machines = {
    '오름관 1동' : [
      {
        'machineNum': "W1",
        'startTime': ['2022-11-09 06:00:00', '2022-11-09 08:00:00', '2022-11-09 10:00:00', '2022-11-09 12:00:00', "2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ['2022-11-09 08:00:00', '2022-11-09 10:00:00', '2022-11-09 12:00:00', '2022-11-09 14:00:00', "2022-11-15 16:30:00", "2022-11-16 14:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
      },
      {
        'machineNum': "W2",
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
        'startTime': ["2022-11-15 15:00:00", "2022-11-16 12:30:00"],
        'endTime': ["2022-11-15 16:30:00", "2022-11-16 14:30:00"],
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
    Map? machine;
    List tempStartTime = List<String>.empty(growable: true);
    List tempEndTime = List<String>.empty(growable: true);
    if((machine = findMachine(dormitory, machineNum)) != null){
      tempStartTime = machine!['startTime'];
      tempStartTime.add(startTime);
      machine['startTime'] = tempStartTime;
      tempEndTime = machine['endTime'];
      tempEndTime.add(endTime);
      machine['endTime'] = tempEndTime;
    }
    notifyListeners();
  }

  void deleteReservation(String dormitory, String machineNum, String startTime, String endTime){
    Map? machine;
    List tempStartTime = List<String>.empty(growable: true);
    List tempEndTime = List<String>.empty(growable: true);
    if((machine = findMachine(dormitory, machineNum)) != null){
      tempStartTime = machine!['startTime'];
      tempStartTime.remove(startTime);
      machine['startTime'] = tempStartTime;
      tempEndTime = machine['endTime'];
      tempEndTime.remove(endTime);
      machine['endTime'] = tempEndTime;
    }
    notifyListeners();
  }
}