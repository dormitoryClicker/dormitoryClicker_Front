import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  Future _getDataSetting(String userId)
  => _memoizer.runOnce(() => getUserData(userId));

  Future<String> getUserData(String userId) async {
    Map data = {'userId': userId};
    var body = json.encode(data);

    http.Response res = await http.post(Uri.parse('http://localhost:8080/user'),
        headers: {'Content-Type': "application/json"},
        body: body
    );

    //여기서는 응답이 객체로 변환된 res 변수를 사용할 수 있다.
    //여기서 res.body를 jsonDecode 함수로 객체로 만들어서 데이터를 처리할 수 있다.
    String jsonData = res.body;

    if (jsonData == "Not found userId with $userId") {
      return "404: User Not Found";
    } else if (jsonData == "Server Unavailable") {
      return "500: Server Unavailable";
    } else {
      userInfo.putUserId(jsonDecode(jsonData)['userId']);
      userInfo.putPassword(jsonDecode(jsonData)['password']);
      userInfo.putUserName(jsonDecode(jsonData)['userName']);
      userInfo.putDormitory(jsonDecode(jsonData)['dormitory']);
      if (jsonDecode(jsonData)['reservation_time'] != null) {
        userInfo.putCanReservation(false);
        userInfo.putStartTime(jsonDecode(jsonData)['reservation_time']['start']);
        userInfo.putEndTime(jsonDecode(jsonData)['reservation_time']['end']);
      } else {
        userInfo.putCanReservation(true);
        userInfo.putStartTime("");
        userInfo.putEndTime("");
      }

      return "Success";
    }
  }

  Future<String> cancelReservation(String userId) async {
    http.Response res = await http.post(Uri.parse('http://localhost:8080/cancel'),
        body: {
          'userId': userId
        }
    );

    //여기서는 응답이 객체로 변환된 res 변수를 사용할 수 있다.
    //여기서 res.body를 jsonDecode 함수로 객체로 만들어서 데이터를 처리할 수 있다.
    String jsonData = res.body;

    if (jsonData == "Not found userId with $userId") {
      return "404: Not Found User Id";
    } else if (jsonData == "Server Unavailable") {
      return "500: Server Unavailable";
    } else {
      return "success";
    }
  }

  void _sendEmail() async {
    final Email email = Email(
      body: '',
      subject: '[세탁기 클리커 사용 문의]',
      recipients: ['20180088@kumoh.ac.kr'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch(error) {
      String title = "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.";
      //String message = "";
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인')),
          ],
        ),
      );
    }
  }

  var userInfo;

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserInfo>(context, listen: true);

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
                _sendEmail();
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _getDataSetting(userInfo.getUserId()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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

                      const Divider(
                        indent: 20,
                        endIndent: 20,
                      ),

                      Flexible(
                          flex: 7,
                          fit: FlexFit.tight,
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
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    userInfo.getCanReservation() ? "" :
                                                    "${userInfo.getStartTime().month}월 ${userInfo.getStartTime().day}일 "
                                                        "${userInfo.getStartTime().hour}시 ${userInfo.getStartTime().minute}분"
                                                        " - "
                                                        "${userInfo.getEndTime().month}월 ${userInfo.getEndTime().day}일 "
                                                        "${userInfo.getEndTime().hour}시 ${userInfo.getEndTime().minute}분",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.timelapse),
                                                    Text(
                                                      userInfo.getCanReservation() ? "" :
                                                      '${calculateTimeDifference(startTime: userInfo.getStartTime(), endTime: userInfo.getEndTime())}',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                                child: OutlinedButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      cancelReservation(userInfo.getUserId()).then((value) {
                                                        String message = value;
                                                        if (value == "success") {
                                                          message = "예약을 취소했습니다.";
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              content: Text(message),
                                                              actions: [
                                                                Center(
                                                                  child: ElevatedButton(
                                                                    onPressed: () {
                                                                      if (value == "success") {
                                                                        userInfo.putCanReservation(true);
                                                                      }
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: const Text("확인")
                                                                  )
                                                                )
                                                              ],
                                                            );
                                                          }
                                                        );
                                                      });
                                                    });
                                                  },
                                                  child: const Text(
                                                    "예약취소",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 15,
                                                    ),
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
                      ),

                      const Divider(
                        indent: 20,
                        endIndent: 20,
                      ),

                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
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
                      )
                    ],
                  ),
                )
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
        },
      )
    );
  }
}
