import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/common/log_in.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:mahjong_record_sm/screens-online/edit_screen_team.dart';
import 'package:mahjong_record_sm/screens/base_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: HexColor("f9f7f7"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: maxHeight * (70 / 100),
              child: Column(
                children: [
                  SizedBox(
                    height: maxHeight * (15 / 100),
                  ),
                  SizedBox(
                      height: maxHeight * (10 / 100),
                      child: Center(
                        child: Image.asset('assets/images/home.png'),
                      )),
                  SizedBox(
                    height: maxHeight * (15 / 100),
                  ),
                  SizedBox(
                    height: maxHeight * (15 / 100),
                    child: Center(
                      child: Text(
                        "煩わしい計算から解放される。",
                        style:
                            TextStyle(fontSize: 21, color: HexColor("112d4e")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: maxHeight * (10 / 100),
                  ),
                  SizedBox(
                    height: maxHeight * (5 / 100),
                    child: Center(
                      child: Text(
                        "↓初めての方はチームアカウント作成",
                        style:
                            TextStyle(fontSize: 14, color: HexColor("112d4e")),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: maxHeight * (20 / 100),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: maxHeight * (5 / 100),
                      child: ElevatedButton(
                        child: const Text(
                          'チームアカウント作成',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: HexColor("3f72af"),
                          onPrimary: HexColor("f9f7f7"),
                          elevation: 16,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditScreenTeam()));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: maxHeight * (1.5 / 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: maxHeight * (5 / 100),
                      child: OutlinedButton(
                        child: const Text(
                          'ログイン',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: HexColor("112d4e"),
                          shape: const StadiumBorder(),
                          side: BorderSide(color: HexColor("112d4e")),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: maxHeight * (1.5 / 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: maxHeight * (5 / 100),
                      child: OutlinedButton(
                        child: const Text(
                          'ひとりでつかう',
                          style: TextStyle(fontSize: 14),
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: HexColor("112d4e"),
                          shape: const StadiumBorder(),
                          side: BorderSide(color: HexColor("f9f7f7")),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BasePage()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: maxHeight * (10 / 100),
              child: Text(
                "powereted by mimimi",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Mont",
                  color: HexColor("112d4e"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
