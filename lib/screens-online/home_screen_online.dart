import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mahjong_record_sm/parts/buttom_with_icon.dart';
import 'package:mahjong_record_sm/parts/buttom_with_icon_online.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:mahjong_record_sm/parts/session_management.dart';
import 'package:mahjong_record_sm/screens-online/base_page_online.dart';
import 'package:mahjong_record_sm/screens-online/edit_screen_team.dart';
import 'package:toast/toast.dart';

//★この画面はまだ使用されていない★

class HomeScreenOnline extends StatefulWidget {
  @override
  _HomeScreenOnlineState createState() => _HomeScreenOnlineState();
}

class _HomeScreenOnlineState extends State<HomeScreenOnline> {
  var teamIdController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
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
      backgroundColor: HexColor('f9f7f7'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: maxHeight * (15 / 100),
            ),
            Container(
              decoration: new BoxDecoration(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10.0)),
                color: HexColor('3f72af'),
              ),
              child: SizedBox(
                height: maxHeight * (20 / 100),
                width: maxWidth * (80 / 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "試験運用中です。",
                      style:
                          TextStyle(fontSize: 36.0, color: HexColor('f9f7f7')),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "本運用前にデータを削除します。",
                      style:
                          TextStyle(fontSize: 20.0, color: HexColor('f9f7f7')),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: maxHeight * (5 / 100),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: new TextFormField(
                  controller: teamIdController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    hintText: 'Team IDを入力してください。',
                    labelText: 'Team ID *',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: new TextFormField(
                  controller: passwordController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    hintText: 'Passwordを入力してください。',
                    labelText: 'Password *',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: maxHeight * (10 / 100),
            ),
            ButtonWithIconOnline(
              onPressed: () => _recordInquiryScreen(),
              icon: Icon(
                Icons.play_arrow,
                color: HexColor('f9f7f7'),
              ),
              label: "ログイン",
            ),
            SizedBox(
              height: maxHeight * (5 / 100),
            ),
            ButtonWithIconOnline(
              onPressed: () => _editScreenTeam(),
              icon: Icon(
                Icons.play_arrow,
                color: HexColor('f9f7f7'),
              ),
              label: "チーム作成",
            ),
            SizedBox(
              height: maxHeight * (5 / 100),
            ),
            Text(
              "powereted by North School",
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "Mont",
                color: HexColor('f9f7f7'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //ログイン確認
  _recordInquiryScreen() async {
    if (teamIdController.text == "") {
      Toast.show("IDが空欄です。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    if (passwordController.text == "") {
      Toast.show("Passwordが空欄です。", context, duration: Toast.LENGTH_SHORT);
      return;
    }

    bool checkId = await checkExistence("teamList", teamIdController.text);

    if (checkId == false) {
      Toast.show("登録されていないIDです。", context, duration: Toast.LENGTH_SHORT);
      return;
    } else {
      var passwordCheck =
          await getPassword("teamList", teamIdController.text, "teamPassword");
      if (passwordController.text == passwordCheck) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BasePageOnline()));
      } else {
        Toast.show("IDまたはPasswordが異なります。", context,
            duration: Toast.LENGTH_SHORT);
      }
    }
  }

  //チーム作成画面へ遷移
  _editScreenTeam() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditScreenTeam()));
  }

  //アカウント存在チェック
  Future<bool> checkExistence(String collection, String documentId) async {
    final doc = await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .get();

    final exists = doc.exists;
    return exists;
  }

  //照合用パスワードの取得
  Future<String> getPassword(
      String collection, String documentId, String field) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .get();
    Map<String, dynamic> record = docSnapshot.data();
    saveSession(context);
    return record[field];
  }

  //セッション保存
  Future<void> saveSession(context) async {
    SessionManagement mySession = SessionManagement(
        teamId: teamIdController.text, teamPassword: passwordController.text);

    await FlutterSession().set('mySession', mySession);
  }
}
