import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
import 'userInfo.dart';
import 'homepage.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var info;

  String _userName = "금오공";
  String _userId = "20221111";
  String _dormitory = "오름 1동";

  bool _reservation = true;
  DateTime _startTime = DateTime.parse('2022-11-10 10:45:00');
  DateTime _endTime = DateTime.parse('2022-11-10 12:00:00');

  String calculateTimeDifference(
      {required DateTime startTime, required DateTime endTime}) {
    int diffSec = endTime.difference(DateTime.now()).inSeconds;
    if (diffSec <= 0) _reservation = false;

    int check = DateTime.now().difference(startTime).inSeconds;
    if (check <= 0) return '예약 시간이 되지 않았습니다';

    int hr = diffSec ~/ 3600;
    int min = (diffSec - 3600 * hr) ~/ 60;
    int sec = diffSec % 60;

    return '${hr}시간 ${min}분 ${sec}초 남음';
  }

  @override
  Widget build(BuildContext context) {
    info = Provider.of<UserInfo>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("마이페이지"),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                  info.isEmpty(info.getUserName()) ? "로그인 필요" : info.getUserName()
              ),
              accountEmail: Text(
                  info.isEmpty(info.getUserId()) ? "" : info.getUserId()
              ),
              decoration: BoxDecoration(
                color: Colors.blue[300],
              ),
            ),
            ListTile(
              title: const Text("HOME"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomePage())
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text("마이페이지"),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new MyPage())
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text("문의/건의"),
              onTap: () {
                print("");
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 100,
              margin: EdgeInsets.all(12),
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Row(
                      children: const [
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Text(
                              "이름",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                        ),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Text(
                              "학번",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                        ),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Text(
                              "기숙사",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                        ),
                      ],
                    )
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Row(
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Text(
                              _userName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            )
                        ),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Text(
                              _userId,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            )
                        ),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Text(
                              _dormitory,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            )
                        ),
                      ],
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(left: 12.0, right: 12.0),
                child: TimerBuilder.periodic(
                  const Duration(seconds: 1),
                  builder: (context) {
                    return Center(
                      child: Column(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Center(
                              child: Text(
                                _reservation ? "예약된 내역이 있습니다" : "예약된 내역이 없습니다",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            )
                          ),
                          Visibility(
                            visible: _reservation,
                            child: Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "${_startTime.month}월 ${_startTime.day}일 "
                                      "${_startTime.hour}시 ${_startTime.minute}분"
                                      " - "
                                      "${_endTime.month}월 ${_endTime.day}일 "
                                      "${_endTime.hour}시 ${_endTime.minute}분",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ),
                          ),
                          Visibility(
                            visible: _reservation,
                            child: Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Center(
                                child: Text(
                                  calculateTimeDifference(startTime: _startTime, endTime: _endTime),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ),
                          )
                        ],
                      )
                    );
                  }
                )
              )
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 70,
              margin: EdgeInsets.all(12),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.settings)
                    )
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.logout)
                    )
                  )
                ],
              )
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: !info.isEmpty(info.getUserId()),
        child: FloatingActionButton(
          onPressed: (){
            _reservation = false;
          },
          backgroundColor: Colors.blue,
          child: const Text(
            "예약취소",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      )
    );
  }
}
