import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'user_info.dart';
import 'users_data.dart';
import 'home_page.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  var userInfo;
  var usersData;

  String? _tempId;
  String? _tempPw;

  Map? _tempUser;

  Future _onPowerKey() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserInfo>(context, listen: true);
    usersData = Provider.of<UsersData>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        await _onBackPressed(context);
        return false;
      },
      child: Scaffold(
          body: Column(
            children: [
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
                          _onPowerKey();
                        },
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 30.0),
                        child: const Text(
                          "로그인",
                          style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                        )
                    )
                  ]
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Center(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
                          children: <Widget>[
                            const SizedBox(height: 48.0),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              autofocus: false,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.account_circle),
                                labelText: '학번',
                                contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return '학번을 입력해주세요!';
                                }
                                _tempId = value;
                                return null;
                              },
                            ),
                            const SizedBox(height: 12.0),
                            TextFormField(
                              autofocus: false,
                              obscureText: true,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: '비밀번호',
                                contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return '비밀번호를 입력해주세요!';
                                }
                                _tempPw = value;
                                return null;
                              },
                            ),
                            const SizedBox(height: 24.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()) {
                                    _tempUser = usersData.findUser(_tempId);
                                    if(_tempUser == null){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: const Text("해당 아이디가 존재하지 않습니다"),
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
                                      return;
                                    }
                                    if(_tempUser!['password'] != _tempPw){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: const Text("비밀번호가 유효하지 않습니다"),
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
                                      return;
                                    }
                                    userInfo.putUserId(_tempUser!['userId']);
                                    userInfo.putPassword(_tempUser!['password']);
                                    userInfo.putUserName(_tempUser!['userName']);
                                    userInfo.putDormitory(_tempUser!['dormitory']);
                                    userInfo.putCanReservation(_tempUser!['canReservation']);
                                    userInfo.putMachineNum(_tempUser!['machineNum']);
                                    userInfo.putStartTime(_tempUser!['startTime']);
                                    userInfo.putEndTime(_tempUser!['endTime']);
                                    Navigator.pushReplacementNamed(context, '/');
                                  }
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
                                    shape: MaterialStateProperty.resolveWith((states) {
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
                                      return null;
                                    })
                                ),
                                child: const Text('로그인', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            TextButton(
                              child: const Text(
                                'Create New Account',
                                style: TextStyle(
                                    color: Colors.black87,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                            ),
                          ],
                        ),
                      )
                  )
              )
            ],
          )
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