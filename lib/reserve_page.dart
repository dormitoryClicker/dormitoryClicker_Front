import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_info.dart';
import 'reservation_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Future _getDataSetting1(String dormitory, String machineNum)
    => _memoizer.runOnce(() => getReservationData(dormitory, machineNum));

  Future<String> getReservationData(String dormitory, String machineNum) async {
    http.Response res = await http.get(Uri.parse(
        'http://localhost:8080/reservation?dormitory=$dormitory&machineNum=$machineNum'
    ));

    //여기서는 응답이 객체로 변환된 res 변수를 사용할 수 있다.
    //여기서 res.body를 jsonDecode 함수로 객체로 만들어서 데이터를 처리할 수 있다.
    String jsonData = res.body;

    if (jsonData == "There's no machine") { return "404: Machine Not Found"; }
    else {
      for(int i = 0; i < jsonDecode(jsonData)['startDatetime']!.length; i++){
        reservationData.reservations['startDatetime'].add(DateTime.parse(jsonDecode(jsonData)['startDatetime']![i]));
        reservationData.reservations['endDatetime'].add(DateTime.parse(jsonDecode(jsonData)['endDatetime']![i]));
      }

      return "Success";
    }
  }

  Future<String> putReservationData(String userId, String dormitory, String machineNum, DateTime startDatetime, DateTime endDatetime) async {
    http.Response res = await http.post(Uri.parse('http://localhost:8080/reservation'),
        body: {
          'userId': userId,
          'dormitory': dormitory,
          'machineNum': machineNum,
          'startDatetime': DateFormat('yyyy-MM-dd HH:mm:00').format(startDatetime),
          'endDatetime': DateFormat('yyyy-MM-dd HH:mm:00').format(endDatetime),
        }
    );

    //여기서는 응답이 객체로 변환된 res 변수를 사용할 수 있다.
    //여기서 res.body를 jsonDecode 함수로 객체로 만들어서 데이터를 처리할 수 있다.
    return res.body;
  }

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

  ReservationData clearListView(ReservationData reservationData){
    Map<String, List<DateTime>> tempMachine = reservationData.reservations;

    List<DateTime>? tempStartTime = tempMachine['startDatetime'];
    List<DateTime>? tempEndTime = tempMachine['endDatetime'];
    List<int> disableStartTimeList = List<int>.empty(growable: true);
    List<int> disableEndTimeList = List<int>.empty(growable: true);

    for(int i = 0; i < tempStartTime!.length; i++){
      String tempStart = DateFormat('yyyy-MM-dd HH:mm:00').format(tempStartTime[i]);
      for(int j = 0; j < startTimeList.length; j++){
        if(tempStart[8] + tempStart[9] == MyTime.set_Day[8] + MyTime.set_Day[9]
            && tempStart[11] + tempStart[12] == startTimeList[j][0] + startTimeList[j][1]
            && tempStart[14] + tempStart[15] == startTimeList[j][4] + startTimeList[j][5]){
          disableStartTimeList.add(j);
        }
      }
    }
    for(int i = 0; i < tempEndTime!.length; i++){
      String tempEnd = DateFormat('yyyy-MM-dd HH:mm:00').format(tempEndTime[i]);
      for(int j = 0; j < endTimeList.length; j++){
        if(tempEnd[8] + tempEnd[9] == MyTime.set_Day[8] + MyTime.set_Day[9]
            && tempEnd[11] + tempEnd[12] == endTimeList[j][0] + endTimeList[j][1]
            && tempEnd[14] + tempEnd[15] == endTimeList[j][4] + endTimeList[j][5]){
          disableEndTimeList.add(j);
        } else if(tempEnd[8] + tempEnd[9] == NumberFormat('00').format(int.parse(MyTime.set_Day[8] + MyTime.set_Day[9]) + 1)
            && tempEnd[11] + tempEnd[12] == "00"
            && endTimeList[j][0] + endTimeList[j][1] == "24"){
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

    int nowTime = int.parse(DateTime.now().hour.toString()) * 60 + int.parse(DateTime.now().minute.toString());

    for(int i = 0; i < isEnableTile[0].length; i++){
      int tempHour = int.parse(startTimeList[i][0] + startTimeList[i][1]);
      int tempMin = int.parse(startTimeList[i][4] + startTimeList[i][5]);
      if(tempHour * 60 + tempMin <= nowTime){
        isEnableTile[0][i] = false;
        listViewState[0][i] = 0;
      }
    }

    for(int i = 0; i < disableStartTimeList.length; i++){
      for(int j = disableStartTimeList[i]; j <= disableEndTimeList[i]; j++){
        if (dDay_0 == true) {
          isEnableTile[0][j] = false;
          listViewState[0][j] = 0;
        } else if (dDay_1 == true) {
          isEnableTile[1][j] = false;
          listViewState[1][j] = 0;
        } else if (dDay_2 == true) {
          isEnableTile[2][j] = false;
          listViewState[2][j] = 0;
        }
      }
    }

    return reservationData;
  }
  /**********************************************************************/


  var userInfo;
  var reservationData;

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserInfo>(context, listen: true);
    reservationData = Provider.of<ReservationData>(context, listen: true);

    return Scaffold(
      body: FutureBuilder(
        future: _getDataSetting1(userInfo.getDormitory(), userInfo.getMachineNum()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                            reservationData.reservations['startDatetime'].clear();
                            reservationData.reservations['endDatetime'].clear();
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
                                  setState(() {
                                    reservationData = clearListView(reservationData);
                                  });
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
                                                reservationData = clearListView(reservationData);
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
                                              DateTime newStartTime = DateTime.parse('${MyTime.set_Day} ${MyTime.startHour}:${MyTime.startMin}:00');
                                              DateTime newEndTime = DateTime.parse('${MyTime.set_Day} ${MyTime.endHour}:${MyTime.endMin}:00');

                                              if(MyTime.isStartTimeSelected == false || MyTime.isEndTimeSelected == false) {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content: const Text('시간을 지정해주세요.'),
                                                        actions: [
                                                          Center(
                                                            child: ElevatedButton(
                                                              child: const Text('확인'),
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                );
                                              } else {
                                                putReservationData(userInfo.getUserId(), userInfo.getDormitory(), userInfo.getMachineNum(), newStartTime, newEndTime).then((value) {
                                                  if(value == "already reservation"){
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            content: const Text('이미 예약된 내역이 있습니다.'),
                                                            actions: [
                                                              Center(
                                                                child: ElevatedButton(
                                                                  child: const Text('확인'),
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                    );
                                                  } else if (value == "There's no machine") {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            content: const Text('기기 확인이 불가능합니다.'),
                                                            actions: [
                                                              Center(
                                                                child: ElevatedButton(
                                                                  child: const Text('확인'),
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                    );
                                                  } else if (value == "success") {
                                                    userInfo.putCanReservation(false);
                                                    userInfo.putStartTime(DateFormat('yyyy-MM-dd HH:mm:00').format(newStartTime));
                                                    userInfo.putEndTime(DateFormat('yyyy-MM-dd HH:mm:00').format(newEndTime));

                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            content: Text("예약되었습니다.\n\n"
                                                                "${userInfo.getStartTime().month}월 ${userInfo.getStartTime().day}일 "
                                                                "${userInfo.getStartTime().hour}시 ${userInfo.getStartTime().minute}분"
                                                                " - "
                                                                "${userInfo.getEndTime().month}월 ${userInfo.getEndTime().day}일 "
                                                                "${userInfo.getEndTime().hour}시 ${userInfo.getEndTime().minute}분"),
                                                            actions: [
                                                              Center(
                                                                child: ElevatedButton(
                                                                  child: const Text('확인'),
                                                                  onPressed: () {
                                                                    Navigator.pushNamed(context, '/mypage');
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                    );
                                                  }
                                                });
                                              }
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
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(12),
                    child: Text(
                      'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                      style: TextStyle(fontSize: 15),
                    )
                )
            );
          } else {
            return Center(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(12),
                    child: const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 80.0,
                      ),
                    )
                )
            );
          }
        }
      )
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
                    if (listViewState[flag][i] == 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text("이미 예약된 시간입니다."),
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
                      reservationData = clearListView(reservationData);
                      break;
                    } else {
                      listViewState[flag][i] = 1;
                    }
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