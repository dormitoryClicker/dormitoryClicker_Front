import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userInfo.dart';
import 'mypage.dart';
import 'reservepage.dart';
import 'signinpage.dart';
import 'signuppage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var info;

  @override
  Widget build(BuildContext context) {
    info = Provider.of<UserInfo>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            Visibility(
                visible: info.isEmpty(info.getUserId()),
                child: IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const SignInPage())
                      );
                    },
                    icon: Icon(Icons.login)
                )
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                    info.isEmpty(info.getUserName()) ? "로그인 필요" : info.getUserName()
                ),
                accountEmail: Text(
                    info.isEmpty(info.getUserId()) ? "" : info.getUserId()
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                ),
              ),
              ListTile(
                title: const Text("HOME"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HomePage())
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
              children: [
                Text("홈페이지"),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => new ReservePage())
                      );
                    },
                    child: Text("예약페이지")
                )
              ],
            )
        )
    );
  }
}