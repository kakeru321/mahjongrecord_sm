import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/parts/buttom_with_icon.dart';
import 'package:toast/toast.dart';
import 'record_inquiry_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var teamIdController = TextEditingController();
  var passwordController = TextEditingController();

  String betaTeamId = "hasshu";
  String betaPassword = "zyuppai";

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

    // Resultエリアの縦サイズ
    final titleAreaHeight = maxHeight * (45 / 100);
    // テンキーエリアの縦サイズ
    final buttonAreaHeight = maxHeight * (55 / 100);
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: maxHeight * (15 / 100),
            ),
            Center(
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(10.0)),
                  color: Colors.orange,
                ),
                child: SizedBox(
                  height: maxHeight * (20 / 100),
                  width: maxWidth * (80 / 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "シンプル",
                        style: TextStyle(fontSize: 40.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "麻雀戦績管理",
                        style: TextStyle(fontSize: 40.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
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
            ButtonWithIcon(
              onPressed: () => _recordInquiryScreen(),
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              label: "ログイン",
            ),
            SizedBox(
              height: maxHeight * (5 / 100),
            ),
/*            ButtonWithIcon(
                onPressed: () => _recordInquiryScreen(),
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                label: "チーム作成",
              ),*/
            SizedBox(
              height: maxHeight * (5 / 100),
            ),
            Text(
              "powereted by North School",
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "Mont",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _recordInquiryScreen() {
    if (teamIdController.text == betaTeamId &&
        passwordController.text == betaPassword) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RecordInquiryScreen()));
    } else {
      Toast.show("IDまたはPasswordが異なります。", context, duration: Toast.LENGTH_SHORT);
    }
  }
}
