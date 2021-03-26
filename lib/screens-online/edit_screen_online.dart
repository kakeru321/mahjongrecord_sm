import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:mahjong_record_sm/screens-online/base_page_online.dart';
import 'package:mahjong_record_sm/services/admob.dart';
import 'package:toast/toast.dart';

class EditScreenOnline extends StatefulWidget {
  final Member member;

  EditScreenOnline({this.member});
  @override
  _EditScreenOnlineState createState() => _EditScreenOnlineState();
}

class _EditScreenOnlineState extends State<EditScreenOnline> {
  var addMemberController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    Firebase.initializeApp();
    return WillPopScope(
      onWillPop: () => _backToMemberAddScreen(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: HexColor('f9f7f7'),
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: HexColor('f9f7f7'),
                onPressed: () => _backToMemberAddScreen()),
            automaticallyImplyLeading: true,
            title: Text(
              "新しいメンバーの追加",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: HexColor('f9f7f7')),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.done),
                tooltip: "登録",
                color: HexColor('f9f7f7'),
                onPressed: () => _insertMember(),
              )
            ],
            backgroundColor: HexColor('3f72af'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: maxHeight * (1 / 100),
                ),
                AdmobBanner(
                  adUnitId: AdMobService().getBannerAdUnitId(),
                  adSize: AdmobBannerSize(
                    width: MediaQuery.of(context).size.width.toInt(),
                    height: AdMobService().getHeight(context).toInt(),
                    name: 'SMART_BANNER',
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Text(
                    "メンバー名を入力して「登録」ボタンを押して下さい",
                    style: TextStyle(fontSize: 12.0, color: HexColor('f9f7f7')),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                _memberInputPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //メンバーを登録する。
  Widget _memberInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Text(
            "メンバー名",
            style: TextStyle(fontSize: 24.0, color: HexColor('3f72af')),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: addMemberController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0, color: HexColor('3f72af')),
          ),
        ],
      ),
    );
  }

  //メンバー登録画面に戻る。
  Future<bool> _backToMemberAddScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BasePageOnline()));
    return Future.value(false);
  }

  //メンバーを登録する。
  Future<void> _insertMember() async {
    dynamic session = await FlutterSession().get('mySession');
    if (addMemberController.text == "") {
      Toast.show("メンバー名を入力しないと登録できません。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    FirebaseFirestore.instance
        .collection("teamList")
        .doc(session['teamId'])
        .collection("memberList")
        .add({
      "memberName": addMemberController.text,
      "teamId": session['teamId']
    });

    addMemberController.clear();

    Toast.show("登録完了しました。", context, duration: Toast.LENGTH_SHORT);
  }
}
