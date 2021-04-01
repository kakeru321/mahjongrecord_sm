import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mahjong_record_sm/common/home_screen.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:mahjong_record_sm/parts/session_management.dart';
import 'package:mahjong_record_sm/screens-online/base_page_online.dart';
import 'package:toast/toast.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var teamIdController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.top - padding.bottom;
//    var maxWidth = size.width - padding.left - padding.right;

    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      maxHeight = size.height - kToolbarHeight;
    } else if (Platform.isIOS) {
      maxHeight = size.height;
    }

    return WillPopScope(
      onWillPop: () => _backToHomeScreen(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: HexColor('f9f7f7'),
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => _backToHomeScreen()),
            automaticallyImplyLeading: true,
            title: Text(
              "さぁ、はじめよう。",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: HexColor('f9f7f7')),
            ),
            centerTitle: true,
            backgroundColor: HexColor('3f72af'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: maxHeight * (5 / 100),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Center(
                    child: Text(
                      "チームアカウントでログインしてください。",
                      style:
                          TextStyle(fontSize: 14.0, color: HexColor('3f72af')),
                    ),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (1 / 100),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Center(
                    child: Text(
                      "チームメンバーとデータを共有できます。",
                      style:
                          TextStyle(fontSize: 14.0, color: HexColor('3f72af')),
                    ),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (1 / 100),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Center(
                    child: Text(
                      "ログイン後、初めに【メンバー管理画面】から",
                      style:
                          TextStyle(fontSize: 14.0, color: HexColor('3f72af')),
                    ),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Center(
                    child: Text(
                      "【対局者名を登録】してください。",
                      style:
                          TextStyle(fontSize: 14.0, color: HexColor('3f72af')),
                    ),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (5 / 100),
                ),
                SizedBox(
                  height: maxHeight * (10 / 100),
                  child: Padding(
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
                ),
                SizedBox(
                  height: maxHeight * (10 / 100),
                  child: Padding(
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
                ),
                SizedBox(
                  height: maxHeight * (10 / 100),
                ),
                SizedBox(
                  height: maxHeight * (5 / 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: maxHeight * (5 / 100),
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'ログイン',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: HexColor("3f72af"),
                          onPrimary: HexColor("f9f7f7"),
                          elevation: 16,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          _recordInquiryScreen();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  Future<bool> _backToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    return Future.value(false);
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
