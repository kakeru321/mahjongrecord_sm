import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/main.dart';
import 'package:toast/toast.dart';

class MemberEvery extends StatefulWidget {
  @override
  _MemberEveryState createState() => _MemberEveryState();
}

class _MemberEveryState extends State<MemberEvery> {
  List<int> _calcMemberNumberList = List();
  int _calcSummaryScore1 = 0;
  List<Member> _memberList = List();
  List<String> _memberNameList = List();
  List<int> _calcSummaryScore2 = List();

  int _calcMemberAverage = 0;
  int _countRecord = 0;
  double _conclusionAveragePlace = 0;
  List<double> _conclusionAveragePlaceList = List();

  int periodSelect = 1;
  int conclusionSelect = 2;
  int _selectedIndex = 0;

  List<Point> _pointList = List();
  List<Score> _scoreList = List();

  List<int> _conclusion = List();

  ScrollController _viewController = ScrollController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllPoint();
    _getAllScore();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: maxHeight * (1 / 100),
            ),
            _radioButtons(),
            _conclusionRadioButtons(),
            SizedBox(height: maxHeight - 220.0, child: _pointScoreListWidget()),
          ],
        ),
      ),
    );
  }

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
              "30G",
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
              value: 3,
              groupValue: conclusionSelect,
              onChanged: (value) => _onConclusionRadioSelected(value),
            ),
          ),
          SizedBox(
            // width: 120,
            child: Text(
              "100G",
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

  _onRadioSelected(value) {
    periodSelect = value;
    _getAllMember();
    _getAllPoint();
    _getAllScore();
  }

  _onConclusionRadioSelected(value) {
    conclusionSelect = value;
    _getAllMember();
    _getAllPoint();
    _getAllScore();
  }

  void _getAllPoint() async {
    _pointList = await database.allPoints;
    setState(() {});
  }

  void _getAllScore() async {
    _scoreList = await database.allScores;
  }

  Widget _pointScoreListWidget() {
    return ListView.builder(
        //      physics: const AlwaysScrollableScrollPhysics(),
        controller: _viewController,
        itemCount: _memberList.length,
        itemBuilder: (context, int position) => _pointItem(position));
  }

  Widget _pointItem(int position) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.top - padding.bottom;
    var maxWidth = size.width - padding.left - padding.right;

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
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(
                width: maxWidth * (20 / 100),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "合計（点）",
                        style: TextStyle(fontSize: 8.0),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${_calcSummaryScore2[position]}",
                        style: TextStyle(fontSize: 14.0),
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
                        "平均順位",
                        style: TextStyle(fontSize: 8.0),
                      ),
                    ),
                    Center(
                      child: _nullCheckAveragePlaceList(position),
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
                      child: Text("${_conclusion[position]}"),
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

  //start
  void _getAllMember() async {
    _memberList = await database.allMembers;
    setMemberNameList();
    setState(() {});
  }

  void setMemberNameList() {
    _memberNameList.removeRange(0, _memberNameList.length);

    for (int position = 0; position < _memberList.length; position++) {
      _memberNameList.add(
        _memberList[position].strMemberName,
      );
    }
    _calcMemberScore();
    _calcMemberAveragePlace();
  }

  void _calcMemberScore() {
    _calcSummaryScore2.removeRange(0, _calcSummaryScore2.length);
    for (int i = 0; i < _memberNameList.length; i++) {
      _calcSummaryScore1 = 0;
      _calcMemberNumberList.removeRange(0, _calcMemberNumberList.length);
      for (int j = 0; j < _scoreList.length; j++) {
        var _duration =
            DateTime.now().difference(_scoreList[j].intTimeStamp).inHours;

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

        if (_memberNameList[i] == _scoreList[j].strFirstMemberName) {
          _calcMemberNumberList.add(_scoreList[j].intFirstScore);
        }
        if (_memberNameList[i] == _scoreList[j].strSecondMemberName) {
          _calcMemberNumberList.add(_scoreList[j].intSecondScore);
        }
        if (_memberNameList[i] == _scoreList[j].strThirdMemberName) {
          _calcMemberNumberList.add(_scoreList[j].intThirdScore);
        }
        if (_memberNameList[i] == _scoreList[j].strForthMemberName) {
          _calcMemberNumberList.add(_scoreList[j].intForthScore);
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

  void _calcMemberAveragePlace() {
    _conclusionAveragePlaceList.removeRange(
        0, _conclusionAveragePlaceList.length);

    for (int i = 0; i < _memberNameList.length; i++) {
      _countRecord = 0;
      _calcMemberAverage = 0;
      _conclusionAveragePlace = 0;
      for (int j = 0; j < _scoreList.length; j++) {
        var _duration =
            DateTime.now().difference(_scoreList[j].intTimeStamp).inHours;

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

        if (_memberNameList[i] == _scoreList[j].strFirstMemberName) {
          _calcMemberAverage = _calcMemberAverage + 1;
          _countRecord = _countRecord + 1;
        }
        if (_memberNameList[i] == _scoreList[j].strSecondMemberName) {
          _calcMemberAverage = _calcMemberAverage + 2;
          _countRecord = _countRecord + 1;
        }
        if (_memberNameList[i] == _scoreList[j].strThirdMemberName) {
          _calcMemberAverage = _calcMemberAverage + 3;
          _countRecord = _countRecord + 1;
        }
        if (_memberNameList[i] == _scoreList[j].strForthMemberName) {
          _calcMemberAverage = _calcMemberAverage + 4;
          _countRecord = _countRecord + 1;
        }
      }

      _conclusionAveragePlace = _calcMemberAverage / _countRecord;
      _conclusionAveragePlaceList.add(_conclusionAveragePlace);
    }
    setState(() {});
  }

  _nullCheckAveragePlaceList(position) {
    double _roundAveragePlace = 0;
    if (_conclusionAveragePlaceList[position].isNaN) {
      return Text(
        "-",
        style: TextStyle(fontSize: 14.0),
      );
    } else {
      _roundAveragePlace =
          (_conclusionAveragePlaceList[position] * 10).roundToDouble() / 10;
      return Text(
        _roundAveragePlace.toString(),
        style: TextStyle(fontSize: 14.0),
      );
    }
  }

  void _conclusionScore() {
    _conclusion.removeRange(0, _conclusion.length);
    for (int i = 0; i < _calcSummaryScore2.length; i++) {
      if (conclusionSelect == 1) {
        _conclusion.add(_calcSummaryScore2[i] * 30);
        continue;
      }
      if (conclusionSelect == 2) {
        _conclusion.add(_calcSummaryScore2[i] * 50);
        continue;
      }
      if (conclusionSelect == 3) {
        _conclusion.add(_calcSummaryScore2[i] * 100);
        continue;
      }

      Toast.show("Gが正しく計算されていません。レートを選択し直してください。", context,
          duration: Toast.LENGTH_SHORT);
    }
    setState(() {});
  }
}
