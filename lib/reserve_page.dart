import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
import 'user_info.dart';

class MyTime{
  static String set_Day = '';


  static String start_Hour = '00';
  static bool select_stHour = false;

  static String end_Hour = '00';
  static bool select_edHour = false;

  static String start_Min = '00';
  static bool select_stMin = false;

  static String end_Min = '00';
  static bool select_edMin = false;

}



class ReservePage extends StatefulWidget {
  const ReservePage({Key? key}) : super(key: key);

  @override
  State<ReservePage> createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {

  final GlobalKey<AnimatedListState> _animatedlistKey = GlobalKey<AnimatedListState>();
  List<String> R_items = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
  ];
  List<String> R_S_times = [
    'yy-mm-dd 06:00',
    'yy-mm-dd 08:00',
    'yy-mm-dd 10:00',
    'yy-mm-dd 12:00',
    'yy-mm-dd 14:00',
  ];
  List<String> R_E_times = [
    'yy-mm-dd 08:00',
    'yy-mm-dd 10:00',
    'yy-mm-dd 12:00',
    'yy-mm-dd 14:00',
    'yy-mm-dd 16:00',
  ];

  final List<String> _valueList_Hour = [
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12',
    '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'];

  final List<String> _valueList_Minute = [
    '00', '10', '20', '30', '40', '50', '60'
  ];
  String _selectedValue_Hour_S = '00';
  String _selectedValue_Minute_S = '00';

  String _selectedValue_Hour_E = '00';
  String _selectedValue_Minute_E = '00';

  String result = '';
  bool dDay_0 = true;
  bool dDay_1 = false;
  bool dDay_2 = false;
  late List<bool> isSelected;

  void initState(){
    isSelected = [dDay_0, dDay_1, dDay_2];
    super.initState();
  }

  void toggleSelect(value) {
    if (value == 0) {
      MyTime.set_Day = getToday(daySelect: value);

      dDay_0 = true;
      dDay_1 = false;
      dDay_2 = false;
    }
    else if (value == 1) {
      MyTime.set_Day = getToday(daySelect: value);

      dDay_0 = false;
      dDay_1 = true;
      dDay_2 = false;
    }
    else if (value == 2) {
      MyTime.set_Day = getToday(daySelect: value);

      dDay_0 = false;
      dDay_1 = false;
      dDay_2 = true;
    }
    setState(() {
      isSelected = [dDay_0, dDay_1, dDay_2];
    });
  }

  String calculateTimeDiffer(
      {required String S_H, required String S_M,
        required String E_H, required String E_M}) {

    int sH = int.parse(S_H);
    int sM = int.parse(S_M);
    int eH = int.parse(E_H);
    int eM = int.parse(E_M);

    int diff = (eH * 60 + eM * 1) - (sH * 60 + sM * 1);
    int diffHr = diff ~/ 60;
    int diffMin = diff % 60;

    if(MyTime.select_edHour == true || MyTime.select_edMin == true) {
      if(diff <= 0){
        return '시간을 다시 설정해주세요.';
      }
    }
    else {
      return '시간 계산중 . . . ';
    }

    return '총 예약시간:    ${diffHr}시간  ${diffMin}분';
  }

  int daySelect = 0;

  String getToday({required int daySelect}) {
    var now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day + daySelect);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(day);
    return strToday;
  }

  String? getMName({required int index}) {
    if(index <= 3)
      return '세탁기#${index + 1}';
    else if(index <= 5)
      return '건조기#${index - 3}';
    return null;
  }

  void getReserve ({required String day, required String s_hour, required String s_minute,
    required String e_hour, required String e_minute}) {

    int sH = int.parse(s_hour);
    int sM = int.parse(s_minute);
    int eH = int.parse(e_hour);
    int eM = int.parse(e_minute);

    int diff = (eH * 60 + eM * 1) - (sH * 60 + sM * 1);
    int diffHr = diff ~/ 60;
    int diffMin = diff % 60;

    int reserved = info.getReserved();

    if(reserved == 0){  // 이미 예약을 하였는가?
      if(MyTime.select_edHour == false && MyTime.select_edMin == false
          && MyTime.select_edHour == false && MyTime.select_edMin == false) {
        print("시간을 지정해주세요.");
      }
      else if (MyTime.select_edHour == true || MyTime.select_edMin == true) {
        if(diff >= 0){  // 합당한 총시간을 지정하였는가?
          if(diff > 180 ){  // 3시간 이상을 지정하였는가?
            print("3시간을 초과합니다.");
          }
          else{
            print("예약이 가능할 것 같습니다.");
            info.putReserved(1);
          }
        }
        else {
          print("다시 시간을 지정해주세요.");
        }
      }
    }
    else if (reserved == 1){
      print("예약을 이미 하셨습니다.");
    }

    DateTime _startTime = DateTime.parse('${day} ${s_hour}:${s_minute}:00');
    DateTime _endTime = DateTime.parse('${day} ${e_hour}:${e_minute}:00');

    print("${_startTime.month}월 ${_startTime.day}일 "
        "${_startTime.hour}시 ${_startTime.minute}분"
        " - "
        "${_endTime.month}월 ${_endTime.day}일 "
        "${_endTime.hour}시 ${_endTime.minute}분");
  }

  var info;

  @override
  Widget build(BuildContext context) {
    info = Provider.of<UserInfo>(context, listen: true);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.lightBlue,
                      size: 25.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    '${info.getDormitory()} ${getMName(index: info.getMacNumber())} 예약',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                  ),
                )
              ]
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: RichText(
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
              ),
            ),
          ),

          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: isSelected,
                    onPressed: toggleSelect,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Day\n(${getToday(daySelect: 0)})',
                          //style: TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Day +1\n(${getToday(daySelect: 1)})',
                          //style: TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Day +2\n(${getToday(daySelect: 2)})',
                          //style: TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("예약시작 시간:         ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
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
                        ),

                        const Text("h  :          ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
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
                        ),
                        const Text("min",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text('   ~',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        const Text("예약종료 시간:         ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
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
                        ),

                        const Text("h  :          ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
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
                        ),
                        const Text("min",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Flexible(
                    flex:2,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(calculateTimeDiffer(
                            S_H: _selectedValue_Hour_S, S_M: _selectedValue_Minute_S,
                            E_H: _selectedValue_Hour_E, E_M: _selectedValue_Minute_E))
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: (){  // 시간 정상 입력돴는지 확인용
                              //getComplete(day: MyTime.set_Day, s_hour: MyTime.start_Hour, s_minute: MyTime.start_Min,e_hour: MyTime.end_Hour, e_minute: MyTime.end_Min);
                              getReserve(day: MyTime.set_Day, s_hour: MyTime.start_Hour, s_minute: MyTime.start_Min,
                                  e_hour: MyTime.end_Hour, e_minute: MyTime.end_Min);
                            },
                            child: const Text('예약하기')),
                        const Text('    '),
                        ElevatedButton(
                            onPressed: (){},
                            child: const Text('예약취소')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('<   예약 현황    >',
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
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: (){},
                        child: const Text('새로고침')),
                    const Text('         '),
                  ],
                ),
              ),
            ],
          ),

          Flexible(
            flex: 10,
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: AnimatedList(
                key: _animatedlistKey,
                initialItemCount: R_items.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(R_items[index], R_S_times[index], R_E_times[index], animation, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String item, String r_s_time, String r_e_time, Animation<double> animation, int index) {
    return SlideTransition(
      position: animation.drive(Tween(begin: const Offset(-1.0,0.0), end: const Offset(0.0,0.0))),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(
            item,
            style: const TextStyle(
                fontWeight: FontWeight.w600
            ),
          ),
          subtitle: Text('${r_s_time}  ~  ${r_e_time}'),
          leading: const CircleAvatar(backgroundColor: Colors.amber,),
        ),
      ),
    );
  }
}