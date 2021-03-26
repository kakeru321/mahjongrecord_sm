import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mahjong_record_sm/formats/member-online.dart';
import 'package:mahjong_record_sm/parts/buttom_with_icon.dart';
import 'package:mahjong_record_sm/parts/buttom_with_icon_online.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:toast/toast.dart';

class ChipRecordAddOnline extends StatefulWidget {
  @override
  _ChipRecordAddOnlineState createState() => _ChipRecordAddOnlineState();
}

class _ChipRecordAddOnlineState extends State<ChipRecordAddOnline> {
  var firstTipController = TextEditingController();
  var secondTipController = TextEditingController();
  var thirdTipController = TextEditingController();
  var forthTipController = TextEditingController();

  List<MemberOnline> _memberList = [];
  List<DropdownMenuItem> _memberNameList = [];
  List<String> _uniqueCheck = [];
  String _selectedPlayer1Name;
  String _selectedPlayer2Name;
  String _selectedPlayer3Name;
  String _selectedPlayer4Name;

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

    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      maxHeight = size.height - kToolbarHeight;
    } else if (Platform.isIOS) {
      maxHeight = size.height;
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: HexColor('f9f7f7'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: maxHeight * (2 / 100),
              ),
              Column(
                children: [
                  Text(
                    "Player1",
                    style: TextStyle(fontSize: 28.0, color: HexColor('3f72af')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _player1Name(),
                      _player1Chip(),
                      Text(
                        "枚",
                        style: TextStyle(
                            fontSize: 28.0, color: HexColor('3f72af')),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: maxHeight * (2 / 100),
              ),
              Column(
                children: [
                  Text(
                    "Player2",
                    style: TextStyle(fontSize: 28.0, color: HexColor('3f72af')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _player2Name(),
                      _player2Chip(),
                      Text(
                        "枚",
                        style: TextStyle(
                            fontSize: 28.0, color: HexColor('3f72af')),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: maxHeight * (2 / 100),
              ),
              Column(
                children: [
                  Text(
                    "Player3",
                    style: TextStyle(fontSize: 28.0, color: HexColor('3f72af')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _player3Name(),
                      _player3Chip(),
                      Text(
                        "枚",
                        style: TextStyle(
                            fontSize: 28.0, color: HexColor('3f72af')),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: maxHeight * (2 / 100),
              ),
              Column(
                children: [
                  Text(
                    "Player4",
                    style: TextStyle(fontSize: 28.0, color: HexColor('3f72af')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _player4Name(),
                      _player4Chip(),
                      Text(
                        "枚",
                        style: TextStyle(
                            fontSize: 28.0, color: HexColor('3f72af')),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: maxHeight * (3 / 100),
              ),
              ButtonWithIconOnline(
                onPressed: () => _inputTipRecord(),
                icon: Icon(
                  Icons.done_outline,
                  color: HexColor('f9f7f7'),
                ),
                label: "登録",
              ),
            ],
          ),
        ),
      ),
    );
  }

  //一人目の名前を登録する。
  _player1Name() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: HexColor('dbe2ef'),
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: DropdownButton(
            items: _memberNameList,
            value: _selectedPlayer1Name,
            onChanged: (selectedValue) {
              setState(() {
                _selectedPlayer1Name = selectedValue;
              });
            },
          ),
        ),
      ),
    );
  }

  //一人目のチップ枚数を登録する。
  _player1Chip() {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: firstTipController,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28.0, color: HexColor('3f72af')),
        inputFormatters: [
          LengthLimitingTextInputFormatter(3),
        ],
      ),
    );
  }

  //二人目の名前を登録する。
  _player2Name() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: HexColor('dbe2ef'),
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: DropdownButton(
            items: _memberNameList,
            value: _selectedPlayer2Name,
            onChanged: (selectedValue) {
              setState(() {
                _selectedPlayer2Name = selectedValue;
              });
            },
          ),
        ),
      ),
    );
  }

  //二人目のチップ枚数を登録する。
  _player2Chip() {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: secondTipController,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28.0, color: HexColor('3f72af')),
        inputFormatters: [
          LengthLimitingTextInputFormatter(3),
        ],
      ),
    );
  }

  //三人目の名前を登録する。
  _player3Name() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: HexColor('dbe2ef'),
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: DropdownButton(
            items: _memberNameList,
            value: _selectedPlayer3Name,
            onChanged: (selectedValue) {
              setState(() {
                _selectedPlayer3Name = selectedValue;
              });
            },
          ),
        ),
      ),
    );
  }

  //三人目のチップ枚数を登録する。
  _player3Chip() {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: thirdTipController,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28.0, color: HexColor('3f72af')),
        inputFormatters: [
          LengthLimitingTextInputFormatter(3),
        ],
      ),
    );
  }

  //四人目の名前を登録する。
  _player4Name() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: HexColor('dbe2ef'),
      ),
      child: SizedBox(
        width: 200,
        child: Center(
          child: DropdownButton(
            items: _memberNameList,
            value: _selectedPlayer4Name,
            onChanged: (selectedValue) {
              setState(() {
                _selectedPlayer4Name = selectedValue;
              });
            },
          ),
        ),
      ),
    );
  }

  //四人目のチップ枚数を登録する。
  _player4Chip() {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: forthTipController,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28.0, color: HexColor('3f72af')),
        inputFormatters: [
          LengthLimitingTextInputFormatter(3),
        ],
      ),
    );
  }

  //すべてのメンバー名を登録する。
  void _getAllMember() async {
    dynamic session = await FlutterSession().get('mySession');
    _memberList = [];
    QuerySnapshot memberRecordSnapshot = await FirebaseFirestore.instance
        .collection("teamList")
        .doc(session['teamId'])
        .collection("memberList")
        .get();

    for (var i = 0; i < memberRecordSnapshot.docs.length; i++) {
      _memberList.add(
        MemberOnline(
          memberRecordSnapshot.docs[i]['memberName'],
          memberRecordSnapshot.docs[i]['teamId'],
        ),
      );
    }

    setMemberNameList();
    setState(() {});
  }

  //すべてのメンバー名をリスト化する。
  void setMemberNameList() {
    _memberNameList = [];
    for (int position = 0; position < _memberList.length; position++) {
      _memberNameList.add(
        DropdownMenuItem(
          value: _memberList[position].memberName,
          child: Text(
            "${_memberList[position].memberName}",
            style: TextStyle(fontSize: 28.0),
          ),
        ),
      );
    }
  }

  //チップ枚数を登録する。
  _inputTipRecord() async {
    _uniqueCheck = [];
    if (_selectedPlayer1Name == "" ||
        firstTipController.text == "" ||
        _selectedPlayer2Name == "" ||
        secondTipController.text == "" ||
        _selectedPlayer3Name == "" ||
        thirdTipController.text == "" ||
        _selectedPlayer4Name == "" ||
        forthTipController.text == "") {
      Toast.show("空欄があると登録できません。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    //5人以上でプレイした場合に分けて登録できるように下記の条件を廃止
/*    if (int.parse(firstTipController.text) +
            int.parse(secondTipController.text) +
            int.parse(thirdTipController.text) +
            int.parse(forthTipController.text) !=
        0) {
      Toast.show("チップの合計が０枚になりません。", context, duration: Toast.LENGTH_SHORT);
      return;
    }*/
    _uniqueCheck.add(_selectedPlayer1Name);
    _uniqueCheck.add(_selectedPlayer2Name);
    _uniqueCheck.add(_selectedPlayer3Name);
    _uniqueCheck.add(_selectedPlayer4Name);

    for (int i = 0; i < _uniqueCheck.length - 1; i++) {
      for (int j = i + 1; j < _uniqueCheck.length; j++) {
        if (_uniqueCheck[i] == _uniqueCheck[j]) {
          Toast.show("メンバーが重複しています。", context, duration: Toast.LENGTH_SHORT);
          return;
        }
      }
    }
    _uniqueCheck = null;
    _insertChip();

    Toast.show("登録完了しました。", context, duration: Toast.LENGTH_SHORT);

    setState(() {});
  }

  void _insertChip() async {
    dynamic session = await FlutterSession().get('mySession');
    FirebaseFirestore.instance
        .collection("teamList")
        .doc(session['teamId'])
        .collection("chipRecord")
        .add(
      {
        "strPlayer1Name": _selectedPlayer1Name,
        "strPlayer2Name": _selectedPlayer2Name,
        "strPlayer3Name": _selectedPlayer3Name,
        "strPlayer4Name": _selectedPlayer4Name,
        "intPlayer1Tip": int.parse(firstTipController.text),
        "intPlayer2Tip": int.parse(secondTipController.text),
        "intPlayer3Tip": int.parse(thirdTipController.text),
        "intPlayer4Tip": int.parse(forthTipController.text),
        "intTimeStamp": DateTime.now(),
        "teamId": session['teamId']
      },
    );

    _selectedPlayer1Name = null;
    _selectedPlayer2Name = null;
    _selectedPlayer3Name = null;
    _selectedPlayer4Name = null;
    firstTipController.clear();
    secondTipController.clear();
    thirdTipController.clear();
    forthTipController.clear();
  }
}
