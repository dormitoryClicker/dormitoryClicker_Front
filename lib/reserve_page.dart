import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dorm_data.dart';
import 'users_data.dart';
import 'user_info.dart';
import 'my_page.dart';

class MyTime{
  static String set_Day = getToday(daySelect: 0);

  static String startHour = '00';
  static String startMin = '00';
  static String endHour = '00';
  static String endMin = '00';

  static bool isStartTimeSelected = false;
  static bool isEndTimeSelected = false;

  static String getToday({required int daySelect}) {
    var now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day + daySelect);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(day);
    return strToday;
  }

  static void popping() {
    set_Day = getToday(daySelect: 0);
    startHour = '00';
    startMin = '00';
    endHour = '00';
    endMin = '00';
    isStartTimeSelected = false;
    isEndTimeSelected = false;
  }
}

class ReservePage extends StatefulWidget {
  const ReservePage({Key? key}) : super(key: key);

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {

  /***********************날짜 선택 토글 버튼 관련*************************/
  bool dDay_0 = false;
  bool dDay_1 = false;
  bool dDay_2 = false;
  late List<bool> isSelected;

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
    }
    else if (value == 1) {
      MyTime.set_Day = MyTime.getToday(daySelect: value);

      dDay_0 = false;
      dDay_1 = true;
      dDay_2 = false;
    }
    else if (value == 2) {
      MyTime.set_Day = MyTime.getToday(daySelect: value);

      dDay_0 = false;
      dDay_1 = false;
      dDay_2 = true;
    }
    setState(() {
      isSelected = [dDay_0, dDay_1, dDay_2];
    });
  }
  /**********************************************************************/


  /*******************************예약하기*******************************/
  String message = '';
  String my_r_time = '';
  void getReserve ({required String day, required DateTime startTime, required DateTime endTime}) {
    DateTime newStartTime = DateTime.parse('$day ${MyTime.startHour}:${MyTime.startMin}:00');
    DateTime newEndTime = DateTime.parse('$day ${MyTime.endHour}:${MyTime.endMin}:00');

    if(userInfo.getCanReservation() == true){  // 예약을 할 수 있는가?
      if(MyTime.isStartTimeSelected == false || MyTime.isEndTimeSelected == false) {
        message = '시간을 지정해주세요.';
      }
      else {
        userInfo.putCanReservation(false);
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
      message = '예약을 이미 하셨습니다.';
      my_r_time = "${startTime.month}월 ${startTime.day}일 "
          "${startTime.hour}시 ${startTime.minute}분"
          " - "
          "${endTime.month}월 ${endTime.day}일 "
          "${endTime.hour}시 ${endTime.minute}분";
      message += "\n\n${my_r_time}";
    }
  }
  /**********************************************************************/


  /****************************리스트 뷰 관련*****************************/
  final List<String> startTimeList = [
    '00시 00분', '00시 30분', '01시 00분', '01시 30분', '02시 00분', '02시 30분', '03시 00분', '03시 30분', '04시 00분', '04시 30분', '05시 00분', '05시 30분', '06시 00분',
    '06시 30분', '07시 00분', '07시 30분', '08시 00분', '08시 30분', '09시 00분', '09시 30분', '10시 00분', '10시 30분', '11시 00분', '11시 30분', '12시 00분', '12시 30분',
    '13시 00분', '13시 30분', '14시 00분', '14시 30분', '15시 00분', '15시 30분', '16시 00분', '16시 30분', '17시 00분', '17시 30분', '18시 00분', '18시 30분', '19시 00분',
    '19시 30분', '20시 00분', '20시 30분', '21시 00분', '21시 30분', '22시 00분', '22시 30분', '23시 00분', '23시 30분'
  ];
  final List<String> endTimeList = [
    '00시 30분', '01시 00분', '01시 30분', '02시 00분', '02시 30분', '03시 00분', '03시 30분', '04시 00분', '04시 30분', '05시 00분', '05시 30분', '06시 00분', '06시 30분',
    '07시 00분', '07시 30분', '08시 00분', '08시 30분', '09시 00분', '09시 30분', '10시 00분', '10시 30분', '11시 00분', '11시 30분', '12시 00분', '12시 30분', '13시 00분',
    '13시 30분', '14시 00분', '14시 30분', '15시 00분', '15시 30분', '16시 00분', '16시 30분', '17시 00분', '17시 30분', '18시 00분', '18시 30분', '19시 00분', '19시 30분',
    '20시 00분', '20시 30분', '21시 00분', '21시 30분', '22시 00분', '22시 30분', '23시 00분', '23시 30분', '24시 00분'
  ];

  int count = 0;
  int? selectedStartIndex;
  int? selectedEndIndex;

  List<List<bool>> isEnableTile = [
    List.generate(48, (i) => true),
    List.generate(48, (i) => true),
    List.generate(48, (i) => true)
  ];
  List<List<int>> listViewState = [
    List.generate(48, (i) => 2),
    List.generate(48, (i) => 2),
    List.generate(48, (i) => 2)
  ];

  Color? setListViewColor(int index){
    if (dDay_0 == true) {
      if(listViewState[0][index] == 0) return Colors.black26;
      else if(listViewState[0][index] == 1) return Colors.green;
      else return Colors.white;
    } else if (dDay_1 == true) {
      if(listViewState[1][index] == 0) return Colors.black26;
      else if(listViewState[1][index] == 1) return Colors.green;
      else return Colors.white;
    } else if (dDay_2 == true) {
      if(listViewState[2][index] == 0) return Colors.black26;
      else if(listViewState[2][index] == 1) return Colors.green;
      else return Colors.white;
    }
    return null;
  }

  void clearListView(){
    Map tempMachine = dormData.findMachine(userInfo.getDormitory(), userInfo.getMachineNum());
    List<String> tempStartTime = tempMachine['startTime'];
    List<String> tempEndTime = tempMachine['endTime'];
    List<int> disableStartTimeList = List<int>.empty(growable: true);
    List<int> disableEndTimeList = List<int>.empty(growable: true);

    for(int i = 0; i < tempStartTime.length; i++){
      for(int j = 0; j < startTimeList.length; j++){
        if(tempStartTime[i][8] + tempStartTime[i][9] == MyTime.set_Day[8] + MyTime.set_Day[9]
            && tempStartTime[i][11] + tempStartTime[i][12] == startTimeList[j][0] + startTimeList[j][1]
            && tempStartTime[i][14] + tempStartTime[i][15] == startTimeList[j][4] + startTimeList[j][5]){
          disableStartTimeList.add(j);
        }
      }
    }
    for(int i = 0; i < tempEndTime.length; i++){
      for(int j = 0; j < endTimeList.length; j++){
        if(tempEndTime[i][8] + tempEndTime[i][9] == MyTime.set_Day[8] + MyTime.set_Day[9]
            && tempEndTime[i][11] + tempEndTime[i][12] == endTimeList[j][0] + endTimeList[j][1]
            && tempEndTime[i][14] + tempEndTime[i][15] == endTimeList[j][4] + endTimeList[j][5]){
          disableEndTimeList.add(j);
        }
      }
    }

    count = 0;
    selectedStartIndex = null;
    selectedEndIndex = null;

    for(int i = 0; i < startTimeList.length; i++){
      if (dDay_0 == true) {
        isEnableTile[0][i] = true;
        listViewState[0][i] = 2;
      } else if (dDay_1 == true) {
        isEnableTile[1][i] = true;
        listViewState[1][i] = 2;
      } else if (dDay_2 == true) {
        isEnableTile[2][i] = true;
        listViewState[2][i] = 2;
      }
    }

    for(int i = 0; i < disableStartTimeList.length; i++){
      for(int j = disableStartTimeList[i]; j <= disableEndTimeList[i]; j++){
        if (dDay_0 == true) {
          isEnableTile[0][j] = false;
          listViewState[0][j] = 0;

          int nowTime = int.parse(DateTime.now().hour.toString()) * 60 + int.parse(DateTime.now().minute.toString());

          for(int k = 0; k < isEnableTile[0].length; k++){
            int tempHour = int.parse(startTimeList[k][0] + startTimeList[k][1]);
            int tempMin = int.parse(startTimeList[k][4] + startTimeList[k][5]);
            if(tempHour * 60 + tempMin <= nowTime){
              isEnableTile[0][k] = false;
              listViewState[0][k] = 0;
            }
          }
        } else if (dDay_1 == true) {
          isEnableTile[1][j] = false;
          listViewState[1][j] = 0;
        } else if (dDay_2 == true) {
          isEnableTile[2][j] = false;
          listViewState[2][j] = 0;
        }
      }
    }
  }
  /**********************************************************************/


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
                          text: '한번에 최대 2시간까지만 예약 가능합니다.\n',
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
                          onPressed: (value){
                            toggleSelect(value);
                            clearListView();
                          },
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
                    child: Text(
                      (dDay_0 == false && dDay_1 == false && dDay_2 == false) ?
                      "날짜를 선택해주세요" : (count == 0) ?
                      "시작 시간을 선택해주세요" : (count == 1) ?
                      "종료 시간을 선택해주세요" : "예약 버튼을 눌러주세요",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25
                      ),
                    ),
                  ),

                  Visibility(
                    visible: (dDay_0 == true || dDay_1 == true ||dDay_2 == true) ?
                    true : false,
                    child: Flexible(
                      flex: 7,
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container()
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: ListView.builder(
                              itemCount: 48,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildItem(startTimeList[index], endTimeList[index], index);
                              },
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        clearListView();
                                      });
                                    },
                                    child: const Text("초기화"),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  margin: const EdgeInsets.only(right: 10.0, left: 10.0),
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
                                    child: const Text("예약"),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
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

  Widget _buildItem(String startTimeListElement, String endTimeListElement, int index) {
    return Card(
      elevation: 1,
      child: ListTile(
        title: Text(
          '$startTimeListElement ~ $endTimeListElement',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        tileColor: setListViewColor(index),
        onTap: ((dDay_0 == true) ?
        isEnableTile[0][index] : (dDay_1 == true) ?
        isEnableTile[1][index] : isEnableTile[2][index]) ? (){
          int flag = (dDay_0 == true) ? 0 : (dDay_1 == true) ? 1 : 2;
          setState(() {
            if(listViewState[flag][index] == 2){
              if(count == 0) {
                for(int i = 0; i < index; i++){
                  isEnableTile[flag][i] = false;
                  listViewState[flag][i] = 0;
                }

                listViewState[flag][index] = 1;
                selectedStartIndex = index;
                isEnableTile[flag][index] = false;
                MyTime.isStartTimeSelected = true;
                count++;
              }
              else if (count == 1) {
                String startTime = startTimeList[selectedStartIndex!];
                String endTime = endTimeList[index];
                int startTimeHour = int.parse(startTime[0] + startTime[1]);
                int startTimeMin = int.parse(startTime[4] + startTime[5]);
                int endTimeHour = int.parse(endTime[0] + endTime[1]);
                int endTimeMin = int.parse(endTime[4] + endTime[5]);

                int timeDiff = endTimeHour * 60 + endTimeMin - (startTimeHour * 60 + startTimeMin);

                if(timeDiff > 120){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text("예약 시간이 2시간을 초과합니다."),
                        actions: [
                          Center(
                              child: ElevatedButton(
                                  onPressed: (){ Navigator.pop(context); },
                                  child: const Text("확인")
                              )
                          )
                        ],
                      );
                    }
                  );
                }
                else {
                  listViewState[flag][index] = 1;
                  selectedEndIndex = index;
                  isEnableTile[flag][index] = false;
                  MyTime.isEndTimeSelected = true;
                  MyTime.startHour = startTime[0] + startTime[1];
                  MyTime.startMin = startTime[4] + startTime[5];
                  MyTime.endHour = endTime[0] + endTime[1];
                  MyTime.endMin = endTime[4] + endTime[5];
                  count++;

                  for(int i = 0; i < 48; i++) { isEnableTile[flag][i] = false; }
                  for(int? i = selectedStartIndex! + 1; i! < selectedEndIndex!; i++){
                    listViewState[flag][i] = 1;
                  }
                }
              }
            } else if(listViewState[flag][index] == 1) {
              listViewState[flag][index] = 1;
            }
          });
        } : null,
      ),
    );
  }
}

/*
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
*/