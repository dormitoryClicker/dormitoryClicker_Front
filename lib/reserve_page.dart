import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dorm_data.dart';
import 'users_data.dart';
import 'user_info.dart';
import 'my_page.dart';

class MyTime{
  static String set_Day = getToday(daySelect: 0);

  static String start_Hour = '00';
  static bool select_stHour = false;

  static String end_Hour = '00';
  static bool select_edHour = false;

  static String start_Min = '00';
  static bool select_stMin = false;

  static String end_Min = '00';
  static bool select_edMin = false;

  static String getToday({required int daySelect}) {
    var now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day + daySelect);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(day);
    return strToday;
  }

  static void popping() {
    set_Day = getToday(daySelect: 0);
    start_Hour = '00';
    select_stHour = false;
    end_Hour = '00';
    select_edHour = false;
    start_Min = '00';
    select_stMin = false;
    end_Min = '00';
    select_edMin = false;
  }
}

class ReservePage extends StatefulWidget {
  const ReservePage({Key? key}) : super(key: key);

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {

  final List<String> _valueList_Hour = [
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11',
    '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'
  ];
  final List<String> _valueList_Minute = [
    '00', '10', '20', '30', '40', '50'
  ];

  String _selectedValue_Hour_S = '00';
  String _selectedValue_Minute_S = '00';

  String _selectedValue_Hour_E = '00';
  String _selectedValue_Minute_E = '00';

  bool dDay_0 = false;
  bool dDay_1 = false;
  bool dDay_2 = false;
  late List<bool> isSelected;
  List<String> printList_S = List<String>.empty(growable: true);
  List<String> printList_E = List<String>.empty(growable: true);

  void initState(){
    isSelected = [dDay_0, dDay_1, dDay_2];
    super.initState();
  }

  void toggleSelect(value) {
    if (value == 0) {
      MyTime.set_Day = MyTime.getToday(daySelect: value);

      dDay_0 = true;
      dDay_1 = false;
      dDay_2 = false;

      delPrintList();
      getPrintList(day: MyTime.set_Day);
    }
    else if (value == 1) {
      MyTime.set_Day = MyTime.getToday(daySelect: value);

      dDay_0 = false;
      dDay_1 = true;
      dDay_2 = false;

      delPrintList();
      getPrintList(day: MyTime.set_Day);
    }
    else if (value == 2) {
      MyTime.set_Day = MyTime.getToday(daySelect: value);

      dDay_0 = false;
      dDay_1 = false;
      dDay_2 = true;

      delPrintList();
      getPrintList(day: MyTime.set_Day);
    }
    setState(() {
      isSelected = [dDay_0, dDay_1, dDay_2];
    });
  }

  String calculateTimeDiffer(
      {required String startTimeHour, required String startTimeMinute,
        required String endTimeHour, required String endTimeMinute}) {

    int sH = int.parse(startTimeHour);
    int sM = int.parse(startTimeMinute);
    int eH = int.parse(endTimeHour);
    int eM = int.parse(endTimeMinute);

    int diff = (eH * 60 + eM * 1) - (sH * 60 + sM * 1);
    int diffHr = diff ~/ 60;
    int diffMin = diff % 60;

    if(MyTime.select_edHour == true || MyTime.select_edMin == true) {
      if(diff <= 0){
        return '시간을 다시 설정해주세요';
      }
    } else {
      return '시간 계산중 . . . ';
    }

    return '$diffHr시간 $diffMin분';
  }

  String message = '';
  String my_r_time = '';

  void getReserve ({required String day, required DateTime startTime, required DateTime endTime}) {
    int sH = int.parse(MyTime.start_Hour);
    int sM = int.parse(MyTime.start_Min);
    int eH = int.parse(MyTime.end_Hour);
    int eM = int.parse(MyTime.end_Min);

    int diff = (eH * 60 + eM * 1) - (sH * 60 + sM * 1);

    DateTime newStartTime = DateTime.parse('$day ${MyTime.start_Hour}:${MyTime.start_Min}:00');
    DateTime newEndTime = DateTime.parse('$day ${MyTime.end_Hour}:${MyTime.end_Min}:00');

    if(userInfo.getCanReservation() == true){  // 예약을 할 수 있는가?
      if(MyTime.select_edHour == false && MyTime.select_edMin == false
          && MyTime.select_edHour == false && MyTime.select_edMin == false) {
        message = '시간을 지정해주세요.';
      }
      else if (MyTime.select_edHour == true || MyTime.select_edMin == true) {
        if(diff > 0){  // 합당한 총시간을 지정하였는가?
          if(diff > 180 ){  // 3시간 이상을 지정하였는가?
            message = '3시간을 초과합니다.';
          }
          else{
            Map? tempMachine = dormData.findMachine(userInfo.getDormitory(), userInfo.getMachineNum());
            List<String> tempStartTimeList = tempMachine!['startTime'];
            List<String> tempEndTimeList = tempMachine['endTime'];
            for(int i = 0; i < tempStartTimeList.length; i++){
              if(newStartTime.difference(DateTime.parse(tempStartTimeList[i])).inSeconds >= 0
                && newStartTime.difference(DateTime.parse(tempEndTimeList[i])).inSeconds <= 0){
                message = '해당 시간에 이미 예약이 존재합니다.';
                return;
              }
              if(newEndTime.difference(DateTime.parse(tempStartTimeList[i])).inSeconds >= 0
                  && newEndTime.difference(DateTime.parse(tempEndTimeList[i])).inSeconds <= 0){
                message = '해당 시간에 이미 예약이 존재합니다.';
                return;
              }
            }

            userInfo.putCanReservation(false);
            //userInfo.putMachineNum(machineNum);
            userInfo.putStartTime(DateFormat('yyyy-MM-dd HH:mm:00').format(newStartTime));
            userInfo.putEndTime(DateFormat('yyyy-MM-dd HH:mm:00').format(newEndTime));

            dormData.addReservation(
              userInfo.getDormitory(), userInfo.getMachineNum(),
              DateFormat('yyyy-MM-dd HH:mm:00').format(newStartTime),
              DateFormat('yyyy-MM-dd HH:mm:00').format(newEndTime)
            );

            usersData.addReservation(
              userInfo.getUserId(), userInfo.getMachineNum(),
                DateFormat('yyyy-MM-dd HH:mm:00').format(newStartTime),
                DateFormat('yyyy-MM-dd HH:mm:00').format(newEndTime)
            );

            message = '예약되었습니다.';
            my_r_time = "${userInfo.getStartTime().month}월 ${userInfo.getStartTime().day}일 "
                "${userInfo.getStartTime().hour}시 ${userInfo.getStartTime().minute}분"
                " - "
                "${userInfo.getEndTime().month}월 ${userInfo.getEndTime().day}일 "
                "${userInfo.getEndTime().hour}시 ${userInfo.getEndTime().minute}분";
            message += "\n\n$my_r_time";
          }
        }
        else {
          message = '다시 시간을 지정해주세요.';
        }
      }
    }
    else {
      message = '예약을 이미 하셨습니다.';
      my_r_time = "${startTime.month}월 ${startTime.day}일 "
          "${startTime.hour}시 ${startTime.minute}분"
          " - "
          "${endTime.month}월 ${endTime.day}일 "
          "${endTime.hour}시 ${endTime.minute}분";
      message += "\n\n${my_r_time}";
    }
  }

  void getPrintList({required String day}) {
    int print_i = 0;
    Map? tempMachine = dormData.findMachine(userInfo.getDormitory(), userInfo.getMachineNum());
    List<String> tempStartTimeList = tempMachine!['startTime'];
    List<String> tempEndTimeList = tempMachine['endTime'];
    for(int i = 0 ; i < tempStartTimeList.length ; i++ ) {
      if (DateTime.parse(tempStartTimeList[i]).month.toString() == DateTime.parse(day).month.toString() &&
          DateTime.parse(tempStartTimeList[i]).day.toString() == DateTime.parse(day).day.toString() ){
        printList_S.add(tempStartTimeList[i]);
        printList_E.add(tempEndTimeList[i]);
        print_i += 1;
      }
      else {}
    }
  }

  void delPrintList() {
    printList_S.clear();
    printList_E.clear();
  }

  void popping_drop() {
    _selectedValue_Hour_S = '00';
    _selectedValue_Minute_S = '00';

    _selectedValue_Hour_E = '00';
    _selectedValue_Minute_E = '00';
  }

  var userInfo;
  var usersData;
  var dormData;

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserInfo>(context, listen: true);
    dormData = Provider.of<DormData>(context, listen: true);
    usersData = Provider.of<UsersData>(context, listen: true);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.lightBlue,
                      size: 25.0,
                    ),
                    onPressed: () {
                      popping_drop();
                      MyTime.popping();
                      Map? temp = usersData.findUser(userInfo.getUserId());
                      userInfo.putMachineNum(temp!['machineNum']);
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    '${userInfo.getDormitory()} ${userInfo.getMachineNum()} 예약',
                    style: const TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                  ),
                )
              ]
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '< 예약시 주의사항 >\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        TextSpan(
                          text: '한번에 최대 3시간까지만 예약 가능합니다.\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        TextSpan(
                          text: '하루에 한번만 예약이 가능합니다.\n',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),

                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: isSelected,
                          onPressed: toggleSelect,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Day\n(${MyTime.getToday(daySelect: 0)})',
                                //style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Day +1\n(${MyTime.getToday(daySelect: 1)})',
                                //style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Day +2\n(${MyTime.getToday(daySelect: 2)})',
                                //style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Visibility(
                      visible: (dDay_0 == true || dDay_1 == true ||dDay_2 == true) ?
                      true : false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "시작시간",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _selectedValue_Hour_S,
                                  items: _valueList_Hour.map(
                                        (value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? value){
                                    setState(() {
                                      _selectedValue_Hour_S = value!;
                                      MyTime.select_stHour = true;
                                      MyTime.start_Hour = value;
                                    });
                                  },
                                ),
                              )
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text("h:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _selectedValue_Minute_S,
                                  items: _valueList_Minute.map(
                                        (value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? value){
                                    setState(() {
                                      _selectedValue_Minute_S = value!;
                                      MyTime.select_stMin = true;
                                      MyTime.start_Min = value;
                                    });
                                  },
                                ),
                              )
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text("m",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: Container()
                          )
                        ],
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      (dDay_0 == true || dDay_1 == true ||dDay_2 == true) ? '~' : '날짜를 선택해주세요',
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Visibility(
                      visible: (dDay_0 == true || dDay_1 == true ||dDay_2 == true) ?
                      true : false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "종료시간",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _selectedValue_Hour_E,
                                  items: _valueList_Hour.map(
                                        (value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? value){
                                    setState(() {
                                      _selectedValue_Hour_E = value!;
                                      MyTime.select_edHour = true;
                                      MyTime.end_Hour = value;
                                    });
                                  },
                                ),
                              )
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text("h:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _selectedValue_Minute_E,
                                  items: _valueList_Minute.map(
                                        (value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? value){
                                    setState(() {
                                      _selectedValue_Minute_E = value!;
                                      MyTime.select_edMin = true;
                                      MyTime.end_Min = value;
                                    });
                                  },
                                ),
                              )
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text("m",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: Container()
                          )
                        ],
                      ),
                    ),
                  ),

                  Flexible(
                    flex:1,
                    fit: FlexFit.tight,
                    child: Visibility(
                      visible: (dDay_0 == true || dDay_1 == true ||dDay_2 == true) ?
                      true : false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                    calculateTimeDiffer(
                                        startTimeHour: _selectedValue_Hour_S, startTimeMinute: _selectedValue_Minute_S,
                                        endTimeHour: _selectedValue_Hour_E, endTimeMinute: _selectedValue_Minute_E
                                    )
                                ),
                              )
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    onPressed: (){
                                      getReserve(day: MyTime.set_Day, startTime: userInfo.getStartTime(), endTime: userInfo.getEndTime());
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text(message),
                                              actions: [
                                                Center(
                                                  child: ElevatedButton(
                                                    child: const Text('확인'),
                                                    onPressed: () {
                                                      if(message == '예약되었습니다.\n\n$my_r_time'){
                                                        Navigator.pushNamed(context, '/mypage');
                                                      } else {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                      );
                                    },
                                    child: const Text('예약하기')
                                ),
                              )
                          )
                        ],
                      ),
                    )
                  ),

                  Visibility(
                    visible: (dDay_0 == true || dDay_1 == true ||dDay_2 == true) ?
                    true : false,
                    child: const Divider(
                      color: Colors.black,
                      thickness: 1.0,
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Visibility(
                      visible: (dDay_0 == true || dDay_1 == true ||dDay_2 == true) ?
                      true : false,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('< 예약 현황 >',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.black),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: (){
                                      delPrintList();
                                      getPrintList(day: MyTime.set_Day);
                                    },
                                    child: const Text('새로고침'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: ListView.builder(
                      itemCount: printList_S.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(printList_S.length);
                        print(index);
                        return _buildItem(printList_S[index], printList_E[index], index);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String printlist_s, String printlist_e, int index) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(
          '${printlist_s}  ~  ${printlist_e}',
          style: const TextStyle(
              fontWeight: FontWeight.w600
          ),
        ),
        leading: const CircleAvatar(backgroundColor: Colors.amber),
      ),
    );
  }
}