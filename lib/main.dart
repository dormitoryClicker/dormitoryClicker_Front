import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
import 'userInfo.dart';
import 'homepage.dart';
import 'mypage.dart';
import 'reservepage.dart';
import 'signinpage.dart';
import 'signuppage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfo>(
      create: (_) => UserInfo(),
      child: MaterialApp(
        title: 'Navigator Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomePage(),
          '/mypage': (context) => MyPage(),
          '/reserve': (context) => ReservePage(),
          '/signin': (context) => SignInPage(),
          '/signup': (context) => SignUpPage(),
        },
      ),
    );
  }
}