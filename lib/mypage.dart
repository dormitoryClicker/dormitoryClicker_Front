import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Washing Machine Clicker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MyPage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _reservation = true;
  String _location = "오름관 1동 1층";
  DateTime _startTime = DateTime.parse('2022-10-21 19:40:00');
  DateTime _endTime = DateTime.parse('2022-10-21 21:00:00');

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("TestName"),
              accountEmail: const Text("TestAccount@kumoh.ac.kr"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: null,
              ),
              decoration: BoxDecoration(
                color: Colors.blue[300],
              ),
            ),
            ListTile(
              title: const Text("HOME"),
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new HomePage())
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
            TimerBuilder.periodic(
                Duration(seconds: 1),
                builder: (context) {
                  return Column(
                    children: [
                      Text(
                        _reservation ? "예약된 내역이 있습니다" : "예약된 내역이 없습니다",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        _reservation ? _location : "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        _reservation ?
                        "${_startTime.month}월 ${_startTime.day}일 "
                            "${_startTime.hour}시 ${_startTime.minute}분"
                            " - "
                            "${_endTime.month}월 ${_endTime.day}일 "
                            "${_endTime.hour}시 ${_endTime.minute}분"
                            : "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        _reservation ? calculateTimeDifference(startTime: _startTime, endTime: _endTime) : '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      )
                    ],
                  );
                }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}
