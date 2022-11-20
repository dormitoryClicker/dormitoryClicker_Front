import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_info.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  Future<void> getUserData(String userId) async {
    http.Response res = await http.post('https://123.123.123.123:123/user',
        body: {
          'userId': userId,
        }
    );

    //여기서는 응답이 객체로 변환된 res 변수를 사용할 수 있다.
    //여기서 res.body를 jsonDecode 함수로 객체로 만들어서 데이터를 처리할 수 있다.
    String jsonData = res.body;
    Map<String, dynamic> userData = jsonDecode(jsonData);

    userInfo.putUserId(userData['userId']);
    userInfo.putPassword(userData['password']);
    userInfo.putUserName(userData['userName']);
    userInfo.putDormitory(userData['dormitory']);
    List<String>? reservation = userData['reservation'];
    if (reservation != null) {
      userInfo.putCanReservation(false);
      userInfo.putStartTime(reservation[0]);
      userInfo.putEndTime(reservation[1]);
    } else {
      userInfo.putCanReservation(true);
      userInfo.putStartTime("");
      userInfo.putEndTime("");
    }

    return; //작업이 끝났기 때문에 리턴
  }

  var userInfo;

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserInfo>(context, listen: true);

    DateTime tempStartTime = userInfo.getStartTime();
    DateTime tempEndTime = userInfo.getEndTime();

    String calculateTimeDifference(
        {required DateTime? startTime, required DateTime? endTime}) {
      int diffSec = endTime!.difference(DateTime.now()).inSeconds;
      if (diffSec <= 0){
        return '예약 시간이 종료되었습니다';
      }

      int check = DateTime.now().difference(startTime!).inSeconds;
      if (check <= 0) return '예약 시간이 되지 않았습니다';

      int hr = diffSec ~/ 3600;
      int min = (diffSec - 3600 * hr) ~/ 60;
      int sec = diffSec % 60;

      return '$hr시간 $min분 $sec초 남음';
    }

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
              accountName: const Text(""),
              accountEmail: Text(userInfo.getUserId()),
              decoration: BoxDecoration(color: Colors.blue[300]),
            ),
            ListTile(
              title: const Text("홈"),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text("마이페이지"),
              onTap: () {
                Navigator.pushNamed(context, '/mypage');
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text("문의/건의"),
              onTap: () {
                /*************************************/
                /**************이메일 API*************/
                /*************************************/
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
              margin: const EdgeInsets.all(12),
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
                              userInfo.getUserName(),
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
                              userInfo.getUserId(),
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
                              userInfo.getDormitory(),
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
                margin: const EdgeInsets.only(left: 12.0, right: 12.0),
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
                                userInfo.getCanReservation() ?
                                "예약 내역이 없습니다" : "예약 내역이 있습니다",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            )
                          ),
                          Visibility(
                            visible: userInfo.getCanReservation() ?
                            false : true,
                            child: Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Center(
                                child: Text(
                                  userInfo.getCanReservation() ? "" :
                                  "${tempStartTime.month}월 ${tempStartTime.day}일 "
                                      "${tempStartTime.hour}시 ${tempStartTime.minute}분"
                                      " - "
                                      "${tempEndTime.month}월 ${tempEndTime.day}일 "
                                      "${tempEndTime.hour}시 ${tempEndTime.minute}분",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ),
                          ),
                          Visibility(
                            visible: userInfo.getCanReservation() ?
                            false : true,
                            child: Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Center(
                                child: Text(
                                  userInfo.getCanReservation() ? "" :
                                  calculateTimeDifference(startTime: tempStartTime, endTime: tempEndTime),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ),
                          ),
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
              margin: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/setting');
                      },
                      icon: const Icon(Icons.settings)
                    )
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: IconButton(
                      onPressed: (){
                        // userInfo.putUserId("");
                        // userInfo.putPassword("");
                        // userInfo.putUserName("");
                        // userInfo.putDormitory("");
                        // userInfo.putCanReservation(true);
                        // userInfo.putMachineNum("");
                        // userInfo.putStartTime("");
                        // userInfo.putEndTime("");
                        Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
                      },
                      icon: const Icon(Icons.logout)
                    )
                  )
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}
