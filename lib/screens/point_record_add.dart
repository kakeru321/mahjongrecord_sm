import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/main.dart';
import 'package:mahjong_record_sm/parts/bottom_navigation_bar_original.dart';
import 'package:mahjong_record_sm/parts/buttom_with_icon.dart';
import 'package:toast/toast.dart';

class PointRecordAdd extends StatefulWidget {
  @override
  _PointRecordAddState createState() => _PointRecordAddState();
}

class _PointRecordAddState extends State<PointRecordAdd> {
  var firstMemberNameController = TextEditingController();
  var secondMemberNameController = TextEditingController();
  var thirdMemberNameController = TextEditingController();
  var forthMemberNameController = TextEditingController();

  var firstPointController = TextEditingController();
  var secondPointController = TextEditingController();
  var thirdPointController = TextEditingController();
  var forthPointController = TextEditingController();

  List<Member> _memberList = List();
  List<DropdownMenuItem> _memberNameList = List();
  List<String> _uniqueCheck = List();
  String _selectedFirstMember;
  String _selectedSecondMember;
  String _selectedThirdMember;
  String _selectedForthMember;

  @override
  void initState() {
    super.initState();
    _getAllMember();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.top - padding.bottom;
    var maxWidth = size.width - padding.left - padding.right;

    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      maxHeight = size.height - kToolbarHeight;
    } else if (Platform.isIOS) {
      maxHeight = size.height;
    }
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 5.0,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: maxHeight * (2 / 100),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "１着",
                            style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 70.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [
                          _firstMemberNameInputPart(),
                          _firstPointInputPart(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: maxHeight * (2 / 100),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "２着",
                            style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 70.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [
                          _secondMemberNameInputPart(),
                          _secondPointInputPart(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: maxHeight * (2 / 100),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "３着",
                            style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 70.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [
                          _thirdMemberNameInputPart(),
                          _thirdPointInputPart(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: maxHeight * (2 / 100),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "４着",
                            style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 70.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [
                          _forceMemberNameInputPart(),
                          _forcePointInputPart(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: maxHeight * (2 / 100),
                  ),
                ],
              ),
            ),
            ButtonWithIcon(
              onPressed: () => _inputPointScoreRecord(),
              icon: Icon(
                Icons.done_outline,
                color: Colors.white,
              ),
              label: "登録",
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstMemberNameInputPart() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.limeAccent,
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: DropdownButton(
            items: _memberNameList,
            value: _selectedFirstMember,
            onChanged: (selectedValue) {
              setState(() {
                _selectedFirstMember = selectedValue;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _firstPointInputPart() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: firstPointController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
            ],
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            "00",
            style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
          ),
        ),
        Text(
          "点",
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _secondMemberNameInputPart() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.limeAccent,
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: DropdownButton(
            items: _memberNameList,
            value: _selectedSecondMember,
            onChanged: (selectedValue) {
              setState(() {
                _selectedSecondMember = selectedValue;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _secondPointInputPart() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: secondPointController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
            ],
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            "00",
            style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
          ),
        ),
        Text(
          "点",
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _thirdMemberNameInputPart() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.limeAccent,
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: DropdownButton(
            items: _memberNameList,
            value: _selectedThirdMember,
            onChanged: (selectedValue) {
              setState(() {
                _selectedThirdMember = selectedValue;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _thirdPointInputPart() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: thirdPointController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
            ],
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            "00",
            style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
          ),
        ),
        Text(
          "点",
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _forceMemberNameInputPart() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.limeAccent,
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: DropdownButton(
            items: _memberNameList,
            value: _selectedForthMember,
            onChanged: (selectedValue) {
              setState(() {
                _selectedForthMember = selectedValue;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _forcePointInputPart() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: forthPointController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
            ],
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            "00",
            style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
          ),
        ),
        Text(
          "点",
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  _inputPointScoreRecord() async {
    if (_selectedFirstMember == "" ||
        firstPointController.text == "" ||
        _selectedSecondMember == "" ||
        secondPointController.text == "" ||
        _selectedThirdMember == "" ||
        thirdPointController.text == "" ||
        _selectedForthMember == "" ||
        forthPointController.text == "") {
      Toast.show("空欄があると登録できません。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    if (int.parse(firstPointController.text) +
            int.parse(secondPointController.text) +
            int.parse(thirdPointController.text) +
            int.parse(forthPointController.text) !=
        1000) {
      Toast.show("合計得点が１０００００点になりません。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    _uniqueCheck.removeRange(0, _uniqueCheck.length);
    _uniqueCheck.add(_selectedFirstMember);
    _uniqueCheck.add(_selectedSecondMember);
    _uniqueCheck.add(_selectedThirdMember);
    _uniqueCheck.add(_selectedForthMember);

    for (int i = 0; i < _uniqueCheck.length - 1; i++) {
      for (int j = i + 1; j < _uniqueCheck.length; j++) {
        if (_uniqueCheck[i] == _uniqueCheck[j]) {
          Toast.show("メンバーが重複しています。", context, duration: Toast.LENGTH_SHORT);
          return;
        }
      }
    }

    var _firstPoint = int.parse(firstPointController.text) * 100;
    var _secondPoint = int.parse(secondPointController.text) * 100;
    var _thirdPoint = int.parse(thirdPointController.text) * 100;
    var _forthPoint = int.parse(forthPointController.text) * 100;

    var point = Point(
      id: null,
      strFirstMemberName: _selectedFirstMember,
      strSecondMemberName: _selectedSecondMember,
      strThirdMemberName: _selectedThirdMember,
      strForthMemberName: _selectedForthMember,
      intFirstPoint: _firstPoint,
      intSecondPoint: _secondPoint,
      intThirdPoint: _thirdPoint,
      intForthPoint: _forthPoint,
      intTimeStamp: DateTime.now(),
    );
    await database.addPoint(point);
    print("OK_point");

    var score = Score(
      id: null,
      strFirstMemberName: _selectedFirstMember,
      strSecondMemberName: _selectedSecondMember,
      strThirdMemberName: _selectedThirdMember,
      strForthMemberName: _selectedForthMember,
      intFirstScore: _firstScoreCalc(),
      intSecondScore: _secondScoreCalc(),
      intThirdScore: _thirdScoreCalc(),
      intForthScore: _forthScoreCalc(),
      intTimeStamp: DateTime.now(),
    );
    await database.addScore(score);
    print("OK_score");

    _uniqueCheck = null;
    _selectedFirstMember = null;
    _selectedSecondMember = null;
    _selectedThirdMember = null;
    _selectedForthMember = null;
    firstPointController.clear();
    secondPointController.clear();
    thirdPointController.clear();
    forthPointController.clear();

    Toast.show("登録完了しました。", context, duration: Toast.LENGTH_SHORT);

    setState(() {});
  }

  // ignore: missing_return
  int _firstScoreCalc() {
    var intSecondScoreCalc = _secondScoreCalc();
    var intThirdScoreCalc = _thirdScoreCalc();
    var intForthScoreCalc = _forthScoreCalc();

    var intFirstScoreCalc =
        (intSecondScoreCalc + intThirdScoreCalc + intForthScoreCalc) * (-1);
    return intFirstScoreCalc.toInt();
  }

  int _secondScoreCalc() {
    var _secondPoint = double.parse(secondPointController.text) * 100;
    var intSecondScoreCalc =
        ((_secondPoint - 30000 + 10000 - 100) / 1000).round();
    return intSecondScoreCalc.toInt();
  }

  int _thirdScoreCalc() {
    var _thirdPoint = double.parse(thirdPointController.text) * 100;
    var intThirdScoreCalc =
        ((_thirdPoint - 30000 - 10000 - 100) / 1000).round();
    return intThirdScoreCalc.toInt();
  }

  int _forthScoreCalc() {
    var _forthPoint = double.parse(forthPointController.text) * 100;
    var intForthScoreCalc =
        ((_forthPoint - 30000 - 20000 - 100) / 1000).round();
    return intForthScoreCalc.toInt();
  }

  void _getAllMember() async {
    _memberList = await database.allMembers;
    setMemberNameList();
    setState(() {});
  }

  void setMemberNameList() {
    _memberNameList.removeRange(0, _memberNameList.length);
    for (int position = 0; position < _memberList.length; position++) {
      _memberNameList.add(
        DropdownMenuItem(
          value: _memberList[position].strMemberName,
          child: Text(
            "${_memberList[position].strMemberName}",
            style: TextStyle(fontSize: 28.0),
          ),
        ),
      );
    }
  }
}
