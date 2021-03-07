import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/main.dart';
import 'package:mahjong_record_sm/parts/buttom_with_icon.dart';
import 'package:toast/toast.dart';

class ChipRecordAdd extends StatefulWidget {
  @override
  _ChipRecordAddState createState() => _ChipRecordAddState();
}

class _ChipRecordAddState extends State<ChipRecordAdd> {
  var firstTipController = TextEditingController();
  var secondTipController = TextEditingController();
  var thirdTipController = TextEditingController();
  var forthTipController = TextEditingController();

  List<Member> _memberList = [];
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
        backgroundColor: Colors.lightGreen,
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
                    style: TextStyle(fontSize: 28.0, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _player1Name(),
                      _player1Chip(),
                      Text(
                        "枚",
                        style: TextStyle(fontSize: 28.0, color: Colors.white),
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
                    style: TextStyle(fontSize: 28.0, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _player2Name(),
                      _player2Chip(),
                      Text(
                        "枚",
                        style: TextStyle(fontSize: 28.0, color: Colors.white),
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
                    style: TextStyle(fontSize: 28.0, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _player3Name(),
                      _player3Chip(),
                      Text(
                        "枚",
                        style: TextStyle(fontSize: 28.0, color: Colors.white),
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
                    style: TextStyle(fontSize: 28.0, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _player4Name(),
                      _player4Chip(),
                      Text(
                        "枚",
                        style: TextStyle(fontSize: 28.0, color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: maxHeight * (3 / 100),
              ),
              ButtonWithIcon(
                onPressed: () => _inputTipRecord(),
                icon: Icon(
                  Icons.done_outline,
                  color: Colors.white,
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
        color: Colors.limeAccent,
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
        style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
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
        color: Colors.limeAccent,
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
        style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
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
        color: Colors.limeAccent,
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
        style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
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
        color: Colors.limeAccent,
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
        style: TextStyle(fontSize: 28.0, color: Colors.blueGrey),
        inputFormatters: [
          LengthLimitingTextInputFormatter(3),
        ],
      ),
    );
  }

  //すべてのメンバー名を登録する。
  void _getAllMember() async {
    _memberList = await database.allMembers;
    setMemberNameList();
    setState(() {});
  }

  //すべてのメンバー名をリスト化する。
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

  //チップ枚数を登録する。
  _inputTipRecord() async {
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
    if (int.parse(firstTipController.text) +
            int.parse(secondTipController.text) +
            int.parse(thirdTipController.text) +
            int.parse(forthTipController.text) !=
        0) {
      Toast.show("チップの合計が０枚になりません。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    _uniqueCheck.removeRange(0, _uniqueCheck.length);
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

    var tip = Tip(
      id: null,
      strPlayer1Name: _selectedPlayer1Name,
      strPlayer2Name: _selectedPlayer2Name,
      strPlayer3Name: _selectedPlayer3Name,
      strPlayer4Name: _selectedPlayer4Name,
      intPlayer1Tip: int.parse(firstTipController.text),
      intPlayer2Tip: int.parse(secondTipController.text),
      intPlayer3Tip: int.parse(thirdTipController.text),
      intPlayer4Tip: int.parse(forthTipController.text),
      intTimeStamp: DateTime.now(),
    );
    await database.addTip(tip);
    print("OK_tip");

    _uniqueCheck = null;
    _selectedPlayer1Name = null;
    _selectedPlayer2Name = null;
    _selectedPlayer3Name = null;
    _selectedPlayer4Name = null;
    firstTipController.clear();
    secondTipController.clear();
    thirdTipController.clear();
    forthTipController.clear();

    Toast.show("登録完了しました。", context, duration: Toast.LENGTH_SHORT);

    setState(() {});
  }
}
