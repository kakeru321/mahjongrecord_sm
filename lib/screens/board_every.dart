import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/main.dart';
import 'package:toast/toast.dart';

class BoardEvery extends StatefulWidget {
  @override
  _BoardEveryState createState() => _BoardEveryState();
}

class _BoardEveryState extends State<BoardEvery> {
  int periodSelect = 1;

  List<Point> _pointList = [];
  List<Score> _scoreList = [];

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
      backgroundColor: Colors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: maxHeight * (1 / 100),
            ),
            _radioButtons(),
            SizedBox(height: viewHeight(), child: _pointScoreListWidget()),
          ],
        ),
      ),
    );
  }

  //ラジオボタン
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

  //ラジオボタン選択値
  _onRadioSelected(value) {
    setState(() {
      periodSelect = value;
    });
  }

  //すべての素点を取得する。
  void _getAllPoint() async {
    _pointList = await database.allPoints;
    setState(() {});
  }

  //すべての得点を取得する。
  void _getAllScore() async {
    _scoreList = await database.allScores;
  }

  //すべての素点と得点をリストにする。
  Widget _pointScoreListWidget() {
    return ListView.builder(
        //      physics: const AlwaysScrollableScrollPhysics(),
        controller: _viewController,
        itemCount: _pointList.length,
        itemBuilder: (context, int position) => _pointItem(position));
  }

  //すべての得点と素点をカードで並べる
  Widget _pointItem(int position) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.lightGreenAccent,
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
              border: Border.all(color: Colors.black54, width: 3),
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.limeAccent,
            ),
            child: FlatButton(
              onPressed: null,
              child: SizedBox(
                width: maxWidth,
                child: Text(
                  DateFormat("yyyy/MM/dd - EEE - HH:mm:ss")
                      .format(_pointList[position].intTimeStamp),
                  style: TextStyle(fontSize: 24.0, color: Colors.blueGrey),
                ),
              ),
              onLongPress: () =>
                  _deletePointScore(_pointList[position], _scoreList[position]),
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
          color: Colors.black54,
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
          color: Colors.black54,
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
          color: Colors.black54,
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
  _deletePointScore(Point selectedPoint, Score selectedScore) async {
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
  }

  viewHeight() {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.top - padding.bottom;

    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      if (maxHeight >= 750) {
        maxHeight = size.height - kToolbarHeight - 350.0;
        return maxHeight;
      } else {
        maxHeight = size.height - kToolbarHeight - 275.0;
        return maxHeight;
      }
    } else if (Platform.isIOS) {
      if (maxHeight >= 750) {
        maxHeight = size.height - 400.0;
        return maxHeight;
      } else {
        maxHeight = size.height - 325.0;
        print(maxHeight);
        return maxHeight;
      }
    }
  }
}
