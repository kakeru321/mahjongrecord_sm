import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:toast/toast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mahjong_record_sm/formats/member-online.dart';
import 'package:mahjong_record_sm/formats/point-online.dart';
import 'package:mahjong_record_sm/formats/score-online.dart';

class MemberEveryOnline extends StatefulWidget {
  @override
  _MemberEveryOnlineState createState() => _MemberEveryOnlineState();
}

class _MemberEveryOnlineState extends State<MemberEveryOnline> {
  List<int> _calcMemberNumberList = [];
  List<MemberOnline> _memberList = [];
  List<String> _memberNameList = [];

  int _calcSummaryScore1 = 0;
  List<int> _calcSummaryScore2 = [];
  List<PointOnline> _pointList = [];

  int _calcMemberAverage = 0;
  int _countRecord = 0;
  double _conclusionAveragePlace = 0;
  List<double> _conclusionAveragePlaceList = [];

  int periodSelect = 1;
  int conclusionSelect = 2;

  List<ScoreOnline> _scoreList = [];
  List<int> _conclusion = [];

  ScrollController _viewController = ScrollController();

  final InAppReview inAppReview = InAppReview.instance;
  int interstitialRandom = math.Random().nextInt(10);

  static String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-7104775285154830~1946964690';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7104775285154830~1946964690';
    }
    return null;
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-7104775285154830/5999235244';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7104775285154830/9525215581';
    }
    return null;
  }

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllMember();
    _getAllPoint();
    _getAllScore();
    interstitialAds();
    _getReview();
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
            _conclusionRadioButtons(),
            Divider(
              height: 5.0,
              color: HexColor('112d4e'),
              indent: 3.0,
              endIndent: 3.0,
              thickness: 1,
            ),
            SizedBox(height: viewHeight(), child: _pointScoreListWidget()),
          ],
        ),
      ),
    );
  }

  //ラジオボタン（期間）
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

  //ラジオボタン（レート）
  Widget _conclusionRadioButtons() {
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

  //ラジオボタン（期間）の選択値
  _onRadioSelected(value) {
    periodSelect = value;
    _getAllMember();
    _getAllPoint();
    _getAllScore();
  }

  //ラジオボタン（レート）の選択値
  _onConclusionRadioSelected(value) {
    conclusionSelect = value;
    _getAllMember();
    _getAllPoint();
    _getAllScore();
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
  }

  //すべての得点と素点をリスト化する。
  Widget _pointScoreListWidget() {
    return ListView.builder(
        controller: _viewController,
        itemCount: _memberList.length,
        itemBuilder: (context, int position) => _pointItem(position));
  }

  //リストの中身を定義する。
  Widget _pointItem(int position) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxWidth = size.width - padding.left - padding.right;

    if (_calcSummaryScore2[position] == 0) {
      return Container();
    }

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: HexColor('112d4e'), width: 2),
      ),
      color: HexColor('dbe2ef'),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: maxWidth * (30 / 100),
                child: Center(
                  child: Text(
                    "${_memberList[position].memberName}",
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
                        "合計（点）",
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

  //すべてのメンバーをリスト化する。
  void setMemberNameList() {
    _memberNameList = [];

    for (int position = 0; position < _memberList.length; position++) {
      _memberNameList.add(
        _memberList[position].memberName,
      );
    }
    _calcMemberScore();
    _calcMemberAveragePlace();
  }

  //メンバーの得点を計算しリスト化する。
  void _calcMemberScore() {
    _calcSummaryScore2 = [];
    for (int i = 0; i < _memberNameList.length; i++) {
      _calcSummaryScore1 = 0;
      _calcMemberNumberList = [];
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
    //   setState(() {});
    _conclusionScore();
  }

  //メンバーの平均順位を計算しリスト化する。
  void _calcMemberAveragePlace() {
    _conclusionAveragePlaceList = [];

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

  //メンバー名が空欄でないことの確認をする。
  _nullCheckAveragePlaceList(position) {
    double _roundAveragePlace = 0;
    if (_conclusionAveragePlaceList[position].isNaN) {
      return Text(
        "-",
        style: TextStyle(fontSize: 16.0),
      );
    } else {
      _roundAveragePlace =
          (_conclusionAveragePlaceList[position] * 10).roundToDouble() / 10;
      return Text(
        _roundAveragePlace.toString(),
        style: TextStyle(fontSize: 16.0),
      );
    }
  }

  //レートを計算する市リスト化する。
  void _conclusionScore() {
    _conclusion = [];
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

  void _getReview() async {
    var correctReview = 1;

    if (interstitialRandom == correctReview) {
      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      }
    }
  }

  viewHeight() {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.top - padding.bottom;

    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      if (maxHeight >= 750) {
        maxHeight = size.height - kToolbarHeight - 195.0;
        return maxHeight;
      } else {
        maxHeight = size.height - kToolbarHeight - 150.0;
        return maxHeight;
      }
    } else if (Platform.isIOS) {
      if (maxHeight >= 750) {
        maxHeight = size.height - 245.0;
        return maxHeight;
      } else {
        maxHeight = size.height - 170.0;
        return maxHeight;
      }
    }
  }

  interstitialAds() {
    var correct = 0;
    print(interstitialRandom);

    if (interstitialRandom == correct) {
      FirebaseAdMob.instance.initialize(appId: getAppId());

      InterstitialAd myInterstitial = InterstitialAd(
        // Replace the testAdUnitId with an ad unit id from the AdMob dash.
        // https://developers.google.com/admob/android/test-ads
        // https://developers.google.com/admob/ios/test-ads
        adUnitId: getInterstitialAdUnitId(),
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd event is $event");
        },
      );

      myInterstitial
        ..load()
        ..show(
          anchorType: AnchorType.bottom,
          anchorOffset: 0.0,
          horizontalCenterOffset: 0.0,
        );
    }
  }
}
