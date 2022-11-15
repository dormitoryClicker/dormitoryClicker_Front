import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
import 'user_info.dart';
import 'users_data.dart';
import 'dorm_data.dart';
import 'home_page.dart';
import 'signin_page.dart';
import 'setting_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var userInfo;
  var usersData;
  var dormData;

  @override
  Widget build(BuildContext context) {

    userInfo = Provider.of<UserInfo>(context, listen: true);
    usersData = Provider.of<UsersData>(context, listen: true);
    dormData = Provider.of<DormData>(context, listen: true);

    DateTime tempStartTime = userInfo.getStartTime();
    DateTime tempEndTime = userInfo.getEndTime();

    String calculateTimeDifference(
        {required DateTime? startTime, required DateTime? endTime}) {
      int diffSec = endTime!.difference(DateTime.now()).inSeconds;
      if (diffSec <= 0){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          usersData.deleteReservation(userInfo.getUserId());
          userInfo.putCanReservation(true);
          userInfo.putMachineNum("");
          userInfo.putStartTime("");
          userInfo.putEndTime("");
        });
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
              accountName: Text(userInfo.getUserName()),
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
                          Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(bottom: 12, right: 30),
                            child: Visibility(
                              visible: userInfo.getCanReservation() ?
                              false : true,
                              child: ElevatedButton(
                                onPressed: (){
                                  usersData.deleteReservation(userInfo.getUserId());
                                  dormData.deleteReservation(
                                    userInfo.getDormitory(),
                                    userInfo.getMachineNum(),
                                    DateFormat('yyyy-MM-dd HH:mm:00').format(userInfo.getStartTime()),
                                    DateFormat('yyyy-MM-dd HH:mm:00').format(userInfo.getEndTime())
                                  );
                                  userInfo.putCanReservation(true);
                                  userInfo.putMachineNum("");
                                  userInfo.putStartTime("");
                                  userInfo.putEndTime("");
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15.0))
                                ),
                                child: const Text(
                                  "예약취소",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
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
                        userInfo.putUserId("");
                        userInfo.putPassword("");
                        userInfo.putUserName("");
                        userInfo.putDormitory("");
                        userInfo.putCanReservation(true);
                        userInfo.putMachineNum("");
                        userInfo.putStartTime("");
                        userInfo.putEndTime("");
                        Navigator.pushNamed(context, '/signin');
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
