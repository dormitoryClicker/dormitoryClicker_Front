import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signin_page.dart';
import 'users_data.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  var usersData;

  String? _userName;
  String? _userId;
  String? _password;
  String? _passCheck;
  String? _dormitory;

  String? _dormFirst;
  String? _dormSecond;

  @override
  Widget build(BuildContext context) {
    usersData = Provider.of<UsersData>(context, listen: true);
    return Scaffold(
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
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 30.0),
                  child: const Text(
                    "회원가입",
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
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  children: <Widget>[
                    const SizedBox(height: 24.0),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autofocus: false,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: '이름',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '필수 항목입니다';
                        }
                        _userName = value;
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    DropdownButtonFormField(
                      items: <String>['오름관', '푸름관']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      autofocus: false,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.apartment),
                        labelText: '기숙사 관',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      value: _dormFirst,
                      onChanged: (String? value) {
                        setState(() {
                          _dormFirst = value;
                        });
                      },
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '필수 항목입니다';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    DropdownButtonFormField(
                      items: (_dormFirst == null) ?
                      <String>[].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList() : (_dormFirst == "오름관") ?
                      <String>['1동', '2동', '3동'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList() :
                      <String>['1동', '2동', '3동', '4동'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      autofocus: false,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.apartment),
                        labelText: '기숙사 동',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      value: _dormSecond,
                      onChanged: (String? value) {
                        setState(() {
                          _dormSecond = value;
                        });
                      },
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '필수 항목입니다';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: '학번',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '필수 항목입니다';
                        }
                        _userId = value;
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
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '필수 항목입니다';
                        }
                        _password = value;
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      autofocus: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.spellcheck),
                        labelText: '비밀번호 확인',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '필수 항목입니다';
                        }
                        _passCheck = value;
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            if(usersData.findUser(_userId) != null){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text("이미 가입된 아이디입니다"),
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

                            if(_password != _passCheck){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text("비밀번호가 틀렸습니다"),
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
                            
                            _dormitory = _dormFirst! + ' ' + _dormSecond!;
                            usersData.addUser(_userName, _userId, _password, _dormitory);

                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const SignInPage())
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
                        child: const Text('회원가입', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              )
            ),
          )
        ],
      )
    );
  }
}