import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dorm_data.dart';
import 'user_info.dart';
import 'users_data.dart';
import 'my_page.dart';
import 'reserve_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userInfo;
  var usersData;
  var dormData;

  static const IconData washIcon = IconData(
      0xe398,
      fontFamily: 'MaterialIcons'
  );

  static const IconData dryIcon = IconData(
      0xf0575,
      fontFamily: 'MaterialIcons'
  );

  List<Map> tempDormList = List<Map>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserInfo>(context, listen: true);
    usersData = Provider.of<UsersData>(context, listen: true);
    dormData = Provider.of<DormData>(context, listen: true);

    tempDormList = dormData.machines[userInfo.getDormitory()];

    String getMachineName(int index) {
      String machineNum = dormData.machines[userInfo.getDormitory()][index]['machineNum'];
      if(machineNum.startsWith('W')){
        return "세탁 ${machineNum[1]}";
      } else {
        return "건조 ${machineNum[1]}";
      }
    }

    IconData getMachineIcon(int index) {
      String machineNum = dormData.machines[userInfo.getDormitory()][index]['machineNum'];
      if(machineNum.startsWith('W')){
        return washIcon;
      } else {
        return dryIcon;
      }
    }

    String getEarliestReservation(int index){
      List<String> startTimeList = dormData.machines[userInfo.getDormitory()][index]['startTime'];
      List<String> endTimeList = dormData.machines[userInfo.getDormitory()][index]['endTime'];
      if(startTimeList.isNotEmpty) {
        String earliestStartTime = startTimeList[0];
        int check = 0;
        for (int i = 1; i < startTimeList.length; i++) {
          check = DateTime.parse(earliestStartTime).difference(DateTime.parse(startTimeList[i])).inSeconds;
          if(check < 0) {
            if(DateTime.now().difference(DateTime.parse(earliestStartTime)).inSeconds > 0){
              earliestStartTime = startTimeList[i];
            } else {
              continue;
            }
          }
          else earliestStartTime = startTimeList[i];
        }
        int earliestTimeIndex = startTimeList.indexOf(earliestStartTime);
        return "$earliestStartTime  ~  ${endTimeList[earliestTimeIndex]}";
      }
      return "예약 없음";
    }

    return WillPopScope(
      onWillPop: () async {
        await _onBackPressed(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(userInfo.getDormitory()),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      const Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text('< 주간 날씨 >')
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.sunny),
                                        Text("일", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.sunny),
                                        Text("월", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.cloud),
                                        Text("화", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.cloudy_snowing),
                                        Text("수", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.cloud),
                                        Text("목", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.sunny),
                                        Text("금", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.sunny_snowing),
                                        Text("토", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),

              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      const Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text('< 오늘 날씨 >')
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.sunny),
                                        Text("일", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.sunny),
                                        Text("월", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.cloud),
                                        Text("화", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.cloudy_snowing),
                                        Text("수", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.cloud),
                                        Text("목", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.sunny),
                                        Text("금", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Column(
                                      children: const [
                                        Icon(Icons.sunny_snowing),
                                        Text("토", textAlign: TextAlign.center)
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),

              Flexible(
                flex: 8,
                fit: FlexFit.tight,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      const Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text('< 기기 선택 >')
                      ),
                      Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 3,
                              crossAxisSpacing: 3,
                              childAspectRatio: 3/5,
                            ),
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index){
                              return Card(
                                margin: const EdgeInsets.all(2),
                                elevation: 2,
                                child: GridTile(
                                  footer: Container(
                                    height: 40,
                                    child: GridTileBar(
                                        backgroundColor: Colors.black38,
                                        title: Text(getMachineName(index), textAlign: TextAlign.center)
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: Icon(getMachineIcon(index), size: 50,),
                                    onPressed: (){
                                      if(index <= 3) {
                                        userInfo.putMachineNum("W${index + 1}");
                                      } else {
                                        userInfo.putMachineNum("D${index - 3}");
                                      }
                                      Navigator.pushNamed(context, '/reservation');
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

Future<void> _onBackPressed(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('어플을 종료합니다'),
      actions: [
        TextButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text('확인')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('취소')),
      ],
    ),
  );
}