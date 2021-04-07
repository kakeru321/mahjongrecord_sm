import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/common/home_screen.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditScreenTeam extends StatefulWidget {
  @override
  _EditScreenTeamState createState() => _EditScreenTeamState();
}

class _EditScreenTeamState extends State<EditScreenTeam> {
  var teamIdController = TextEditingController();
  var teamPasswordController = TextEditingController();

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
      maxHeight = size.height - kToolbarHeight + 50;
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
              "チームアカウント作成",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: HexColor('f9f7f7')),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.done),
                tooltip: "作成",
                onPressed: () => _insertTeam(),
              )
            ],
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
                      "チームアカウントを作成してメンバーに共有してください。",
                      style:
                          TextStyle(fontSize: 12.0, color: HexColor('3f72af')),
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
                      "1チームにつき1アカウントになります。",
                      style:
                          TextStyle(fontSize: 12.0, color: HexColor('3f72af')),
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
                      "Team IDとPasswordを入力後、画面右上のチェックボタンを押下",
                      style:
                          TextStyle(fontSize: 12.0, color: HexColor('3f72af')),
                    ),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (5 / 100),
                ),
                SizedBox(
                  height: maxHeight * (15 / 100),
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
                  height: maxHeight * (15 / 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                      child: new TextFormField(
                        controller: teamPasswordController,
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
                  height: maxHeight * (3 / 100),
                  child: Center(
                    child: Text(
                      "本アプリには以下の機能があります。",
                      style:
                          TextStyle(fontSize: 14.0, color: HexColor('3f72af')),
                    ),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Container(
                    width: double.infinity,
                    child: Text("　　　・メンバーとの対局データの共有",
                        style: TextStyle(
                            fontSize: 12.0, color: HexColor('3f72af')),
                        textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Container(
                    width: double.infinity,
                    child: Text("　　　　　各メンバーのスマホから対局データの登録や照会ができます。",
                        style: TextStyle(
                            fontSize: 10.0, color: HexColor('3f72af')),
                        textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Container(
                    width: double.infinity,
                    child: Text("　　　　　※iOSとAndroidどちらも対応しています。",
                        style: TextStyle(
                            fontSize: 10.0, color: HexColor('3f72af')),
                        textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (1 / 100),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Container(
                    width: double.infinity,
                    child: Text("　　　・レートを含めた値を算出",
                        style: TextStyle(
                            fontSize: 12.0, color: HexColor('3f72af')),
                        textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Container(
                    width: double.infinity,
                    child: Text("　　　　　素点を入力するだけで簡単にレートを含めた値を算出できます。",
                        style: TextStyle(
                            fontSize: 10.0, color: HexColor('3f72af')),
                        textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (1 / 100),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Container(
                    width: double.infinity,
                    child: Text("　　　・チップ枚数も管理可能",
                        style: TextStyle(
                            fontSize: 12.0, color: HexColor('3f72af')),
                        textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(
                  height: maxHeight * (2 / 100),
                  child: Container(
                    width: double.infinity,
                    child: Text("　　　　　素点と同様にチップ枚数も管理が可能です。",
                        style: TextStyle(
                            fontSize: 10.0, color: HexColor('3f72af')),
                        textAlign: TextAlign.left),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  Future<bool> _backToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    return Future.value(false);
  }

  _insertTeam() async {
    if (teamIdController.text == "") {
      Toast.show("Team IDが空欄です。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    if (teamPasswordController.text == "") {
      Toast.show("Passwordが空欄です。", context, duration: Toast.LENGTH_SHORT);
      return;
    }

    bool checkId = await checkExistence("teamList", teamIdController.text);

    if (checkId == true) {
      Toast.show("すでに登録されているIDです。", context, duration: Toast.LENGTH_SHORT);
      return;
    } else {
      FirebaseFirestore.instance
          .collection("teamList")
          .doc(teamIdController.text)
          .set(
        {
          "teamId": teamIdController.text,
          "teamPassword": teamPasswordController.text
        },
      );
      teamIdController.clear();
      teamPasswordController.clear();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

      Toast.show("登録完了しました。", context, duration: Toast.LENGTH_SHORT);
    }
  }
}
