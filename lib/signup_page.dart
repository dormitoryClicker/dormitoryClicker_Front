import 'package:flutter/material.dart';
import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                  child: const Text(
                    "Register",
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
                          return '이름을 입력해주세요!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.apartment),
                        labelText: '기숙사',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return '기숙사를 입력해주세요!';
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
                          return '학번을 입력해주세요!';
                        }
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
                          return '비밀번호를 입력해주세요!';
                        }
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
                          return '비밀번호를 다시 한 번 입력해주세요!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
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