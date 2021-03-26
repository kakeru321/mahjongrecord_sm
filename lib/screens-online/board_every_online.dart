import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:intl/intl.dart';
import 'package:mahjong_record_sm/formats/point-online.dart';
import 'package:mahjong_record_sm/formats/score-online.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';

class BoardEveryOnline extends StatefulWidget {
  @override
  _BoardEveryOnlineState createState() => _BoardEveryOnlineState();
}

class _BoardEveryOnlineState extends State<BoardEveryOnline> {
  int periodSelect = 1;

  List<PointOnline> _pointList = [];
  List<ScoreOnline> _scoreList = [];

  ScrollController _viewController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getAllPoint();
    _getAllScore();
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
      backgroundColor: HexColor('f9f7f7'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: maxHeight * (1 / 100),
            ),
            _radioButtons(),
            Divider(
              height: 5.0,
              color: HexColor('112d4e'),
              indent: 3.0,
              endIndent: 3.0,
              thickness: 1,
            ),
            SizedBox(height: maxHeight - 375.0, child: _pointScoreListWidget()),
          ],
        ),
      ),
    );
  }

  //ラジオボタン
  Widget _radioButtons() {
    return Card(
      elevation: 5.0,
      color: HexColor('dbe2ef'),
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

  //ラジオボタン選択値
  _onRadioSelected(value) {
    setState(() {
      periodSelect = value;
    });
  }

  //すべての素点を取得する。
  void _getAllPoint() async {
    dynamic session = await FlutterSession().get('mySession');
    _pointList = [];

    QuerySnapshot pointRecordSnapshot = await FirebaseFirestore.instance
        .collection("teamList")
        .doc(session['teamId'])
        .collection("pointRecord")
        .get();

    for (var i = 0; i < pointRecordSnapshot.docs.length; i++) {
      _pointList.add(
        PointOnline(
          pointRecordSnapshot.docs[i]['intFirstPoint'],
          pointRecordSnapshot.docs[i]['intSecondPoint'],
          pointRecordSnapshot.docs[i]['intThirdPoint'],
          pointRecordSnapshot.docs[i]['intForthPoint'],
          pointRecordSnapshot.docs[i]['intTimeStamp'].toDate(),
          pointRecordSnapshot.docs[i]['strFirstMemberName'],
          pointRecordSnapshot.docs[i]['strSecondMemberName'],
          pointRecordSnapshot.docs[i]['strThirdMemberName'],
          pointRecordSnapshot.docs[i]['strForthMemberName'],
          pointRecordSnapshot.docs[i]['teamId'],
        ),
      );
    }
    setState(() {});
  }

  //すべての得点を取得する。
  void _getAllScore() async {
    dynamic session = await FlutterSession().get('mySession');
    _scoreList = [];

    QuerySnapshot scoreRecordSnapshot = await FirebaseFirestore.instance
        .collection("teamList")
        .doc(session['teamId'])
        .collection("scoreRecord")
        .get();

    for (var i = 0; i < scoreRecordSnapshot.docs.length; i++) {
      _scoreList.add(
        ScoreOnline(
          scoreRecordSnapshot.docs[i]['intFirstScore'],
          scoreRecordSnapshot.docs[i]['intSecondScore'],
          scoreRecordSnapshot.docs[i]['intThirdScore'],
          scoreRecordSnapshot.docs[i]['intForthScore'],
          scoreRecordSnapshot.docs[i]['intTimeStamp'].toDate(),
          scoreRecordSnapshot.docs[i]['strFirstMemberName'],
          scoreRecordSnapshot.docs[i]['strSecondMemberName'],
          scoreRecordSnapshot.docs[i]['strThirdMemberName'],
          scoreRecordSnapshot.docs[i]['strForthMemberName'],
          scoreRecordSnapshot.docs[i]['teamId'],
        ),
      );
    }
    setState(() {});
  }

  //すべての素点と得点をリストにする。
  Widget _pointScoreListWidget() {
    return ListView.builder(
        controller: _viewController,
        itemCount: _pointList.length,
        itemBuilder: (context, int position) => _pointItem(position));
  }

  //すべての得点と素点をカードで並べる
  Widget _pointItem(int position) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: HexColor('112d4e'), width: 3),
      ),
      elevation: 5.0,
      color: HexColor('dbe2ef'),
      child: _card(position),
    );
  }

  //カードの中身を定義
  _card(int position) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxWidth = size.width - padding.left - padding.right;

    var _duration =
        DateTime.now().difference(_pointList[position].intTimeStamp).inHours;

    _pointList.sort((a, b) => b.intTimeStamp.compareTo(a.intTimeStamp));
    _scoreList.sort((a, b) => b.intTimeStamp.compareTo(a.intTimeStamp));

    if (periodSelect == 2) {
      if (_duration > 720) {
        return;
      }
    }
    if (periodSelect == 3) {
      if (_duration > 24) {
        return;
      }
    }
    if (periodSelect == 4) {
      if (_duration > 12) {
        return;
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('112d4e'), width: 3),
              color: HexColor('3f72af'),
            ),
            child: FlatButton(
              onPressed: null,
              child: SizedBox(
                width: maxWidth,
                child: Text(
                  DateFormat("yyyy/MM/dd - EEE - HH:mm:ss")
                      .format(_pointList[position].intTimeStamp),
                  style: TextStyle(fontSize: 24.0, color: HexColor('f9f7f7')),
                ),
              ),
//TODO deletePointScore              onLongPress: () =>
//                  _deletePointScore(_pointList[position], _scoreList[position]),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Center(
                child: Text(
                  "${_pointList[position].strFirstMemberName}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "持点（点）",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${_pointList[position].intFirstPoint}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "得点（P）",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${_scoreList[position].intFirstScore}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 3.0,
          color: HexColor('112d4e'),
          indent: 8.0,
          endIndent: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Center(
                child: Text(
                  "${_pointList[position].strSecondMemberName}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "持点（点）",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${_pointList[position].intSecondPoint}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "得点（P）",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${_scoreList[position].intSecondScore}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 3.0,
          color: HexColor('112d4e'),
          indent: 8.0,
          endIndent: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Center(
                child: Text(
                  "${_pointList[position].strThirdMemberName}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "持点（点）",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${_pointList[position].intThirdPoint}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "得点（P）",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${_scoreList[position].intThirdScore}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 3.0,
          color: HexColor('112d4e'),
          indent: 8.0,
          endIndent: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Center(
                child: Text(
                  "${_pointList[position].strForthMemberName}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "持点（点）",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${_pointList[position].intForthPoint}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: maxWidth * (30 / 100),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "得点（P）",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${_scoreList[position].intForthScore}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //選択したデータを削除する。
/*  _deletePointScore(Point selectedPoint, Score selectedScore) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(DateFormat("yyyy/MM/dd - EEE - HH:mm:ss")
            .format(selectedPoint.intTimeStamp)),
        content: Text("削除しても良いですか？"),
        actions: [
          FlatButton(
            onPressed: () async {
              await database.deletePoint(selectedPoint);
              await database.deleteScore(selectedScore);
              Toast.show("削除完了しました", context, duration: Toast.LENGTH_SHORT);
              _getAllPoint();
              Navigator.pop(context);
            },
            child: Text("はい"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("いいえ"),
          ),
        ],
      ),
    );
  }*/
}
