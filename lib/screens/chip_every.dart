import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/main.dart';
import 'package:toast/toast.dart';

class ChipEvery extends StatefulWidget {
  @override
  _ChipEveryState createState() => _ChipEveryState();
}

class _ChipEveryState extends State<ChipEvery> {
  List<int> _calcMemberNumberList = [];
  int _calcSummaryScore1 = 0;
  List<Member> _memberList = [];
  List<String> _memberNameList = [];
  List<int> _calcSummaryScore2 = [];

  int periodSelect = 1;
  int conclusionSelect = 2;

  List<Tip> _tipList = [];
  List<int> _conclusion = [];

  ScrollController _viewController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getAllTip();
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
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: maxHeight * (1 / 100),
            ),
            _radioButtons(),
            _conclusionRadioButtons(),
            SizedBox(height: maxHeight - 220.0, child: _tipListWidget()),
          ],
        ),
      ),
    );
  }

  //ラジオボタン（期間）
  Widget _radioButtons() {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.limeAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Center(
            child: Text(
              "期間",
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: RadioListTile(
                  value: 1,
                  groupValue: periodSelect,
                  onChanged: (value) => _onRadioSelected(value),
                  title: const Text(
                    "全期間",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: RadioListTile(
                  value: 3,
                  groupValue: periodSelect,
                  onChanged: (value) => _onRadioSelected(value),
                  title: Text(
                    "24時間",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: RadioListTile(
                  value: 2,
                  groupValue: periodSelect,
                  onChanged: (value) => _onRadioSelected(value),
                  title: Text(
                    "1ヶ月間",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: RadioListTile(
                  value: 4,
                  groupValue: periodSelect,
                  onChanged: (value) => _onRadioSelected(value),
                  title: SizedBox(
                    width: 150,
                    child: Text(
                      "12時間",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //ラジオボタン（レート）
  Widget _conclusionRadioButtons() {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.limeAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Center(
            child: Text(
              "レート",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Radio(
              value: 1,
              groupValue: conclusionSelect,
              onChanged: (value) => _onConclusionRadioSelected(value),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              "50G",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Radio(
              value: 2,
              groupValue: conclusionSelect,
              onChanged: (value) => _onConclusionRadioSelected(value),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              "100G",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Radio(
              value: 3,
              groupValue: conclusionSelect,
              onChanged: (value) => _onConclusionRadioSelected(value),
            ),
          ),
          SizedBox(
            // width: 120,
            child: Text(
              "500G",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  //ラジオボタン（期間）の選択値
  _onRadioSelected(value) {
    periodSelect = value;
    _getAllMember();
    _getAllTip();
  }

  //ラジオボタン（レート）の選択値
  _onConclusionRadioSelected(value) {
    conclusionSelect = value;
    _getAllMember();
    _getAllTip();
  }

  //すべてのチップ枚数を取得する。
  void _getAllTip() async {
    _tipList = await database.allTips;
  }

  //すべてのチップをリストにする。
  Widget _tipListWidget() {
    return ListView.builder(
        controller: _viewController,
        itemCount: _memberList.length,
        itemBuilder: (context, int position) => _tipItem(position));
  }

  //カードの中身を定義
  Widget _tipItem(int position) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxWidth = size.width - padding.left - padding.right;

    if (_calcSummaryScore2[position] == 0) {
      return null;
    }

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.lightGreenAccent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: maxWidth * (30 / 100),
                child: Center(
                  child: Text(
                    "${_memberList[position].strMemberName}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(
                width: maxWidth * (20 / 100),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "合計（枚）",
                        style: TextStyle(fontSize: 8.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${_calcSummaryScore2[position]}",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: maxWidth * (20 / 100),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "G",
                        style: TextStyle(fontSize: 8.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${_conclusion[position]}",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //すべてのメンバーを取得する。
  void _getAllMember() async {
    _memberList = await database.allMembers;
    setMemberNameList();
    setState(() {});
  }

  //すべてのメンバーをリスト化する。
  void setMemberNameList() {
    _memberNameList.removeRange(0, _memberNameList.length);

    for (int position = 0; position < _memberList.length; position++) {
      _memberNameList.add(
        _memberList[position].strMemberName,
      );
    }
    _calcMemberTip();
  }

  //メンバーごとにチップ収支を集計
  void _calcMemberTip() {
    _calcSummaryScore2 = [];
    for (int i = 0; i < _memberNameList.length; i++) {
      _calcSummaryScore1 = 0;
      _calcMemberNumberList = [];
      for (int j = 0; j < _tipList.length; j++) {
        var _duration =
            DateTime.now().difference(_tipList[j].intTimeStamp).inHours;

        if (periodSelect == 2) {
          if (_duration > 720) {
            continue;
          }
        }
        if (periodSelect == 3) {
          if (_duration > 24) {
            continue;
          }
        }
        if (periodSelect == 4) {
          if (_duration > 12) {
            continue;
          }
        }

        if (_memberNameList[i] == _tipList[j].strPlayer1Name) {
          _calcMemberNumberList.add(_tipList[j].intPlayer1Tip);
        }
        if (_memberNameList[i] == _tipList[j].strPlayer2Name) {
          _calcMemberNumberList.add(_tipList[j].intPlayer2Tip);
        }
        if (_memberNameList[i] == _tipList[j].strPlayer3Name) {
          _calcMemberNumberList.add(_tipList[j].intPlayer3Tip);
        }
        if (_memberNameList[i] == _tipList[j].strPlayer4Name) {
          _calcMemberNumberList.add(_tipList[j].intPlayer4Tip);
        }
      }
      for (int k = 0; k < _calcMemberNumberList.length; k++) {
        _calcSummaryScore1 = _calcSummaryScore1 + _calcMemberNumberList[k];
      }
      _calcSummaryScore2.add(_calcSummaryScore1);
    }
    setState(() {});
    _conclusionScore();
  }

  //得点を計算しリスト化する。
  void _conclusionScore() {
    _conclusion = [];
    for (int i = 0; i < _calcSummaryScore2.length; i++) {
      if (conclusionSelect == 1) {
        _conclusion.add(_calcSummaryScore2[i] * 50);
        continue;
      }
      if (conclusionSelect == 2) {
        _conclusion.add(_calcSummaryScore2[i] * 100);
        continue;
      }
      if (conclusionSelect == 3) {
        _conclusion.add(_calcSummaryScore2[i] * 500);
        continue;
      }

      Toast.show("Gが正しく計算されていません。レートを選択し直してください。", context,
          duration: Toast.LENGTH_SHORT);
    }
    setState(() {});
  }
}
