import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userInfo.dart';
import 'homepage.dart';
import 'signuppage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  var info;

  String _userId = "20221111";
  String _password = "1q2w3e4r5t";
  String _userName = "금오공";
  String _dormitory = "오름관 1동";

  String? _tempId;
  String? _tempPw;

  @override
  Widget build(BuildContext context) {
    info = Provider.of<UserInfo>(context, listen: true);
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
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
              const Text(
                "Login",
                style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
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
                            if(_tempId != _userId || _tempPw != _password){
                              /* 팝업 창 생성 필요 */
                              print("학번 또는 비밀번호가 유효하지 않음");
                              return;
                            }
                            info.putUserId(_tempId);
                            info.putPassword(_tempPw);
                            info.putUserName(_userName);
                            info.putDormitory(_dormitory);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomePage())
                            );
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
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const SignUpPage())
                        );
                      },
                    ),
                  ],
                ),
              )
            )
          )
        ],
      )
    );
  }
}
