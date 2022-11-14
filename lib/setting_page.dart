import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:provider/provider.dart';
import 'my_page.dart';
import 'user_info.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  var info;

  final List<String> _selectedTimer = [
    '10', '15', '20','25', '30',
  ];

  var _isChecked = false;
  String _initTimer = '10';

  @override
  Widget build(BuildContext context) {
    info = Provider.of<UserInfo>(context, listen: true);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
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
                  child: Text(
                    '환경설정',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                  ),
                )
              ]
          ),

          Flexible(
            flex: 10,
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: ListView(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                children: [
                  Expanded(
                    //height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 8,
                          fit: FlexFit.tight,
                          child: Container(
                            child: Text("알림 설정", textAlign: TextAlign.left,),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Switch(
                            value: _isChecked,
                            onChanged: (value){
                              setState(() {
                                _isChecked = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    //height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 8,
                          fit: FlexFit.tight,
                          child: Container(
                            child: Text("알림 시간 설정", textAlign: TextAlign.left,),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: DropdownButton(
                            isExpanded: true,
                            value: _initTimer,
                            items: _selectedTimer.map(
                                (value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                            ).toList(),
                            onChanged: (String? value){
                              setState(() {
                                _initTimer = value!;
                              });
                            },
                          ),
                        ),
                        Text('분 전 알림'),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          child:TextFormField(
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.apartment),
                              labelText: '기숙사 재지정',
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return '기숙사를 입력해주세요!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 35,
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                              onPressed: (){},
                              child: const Text('변경')),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
