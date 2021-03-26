import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:mahjong_record_sm/screens-online/home_screen_online.dart';
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
              "新しいチームを登録",
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
                onPressed: () => _insertTeam(),
              )
            ],
            backgroundColor: HexColor('3f72af'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Text(
                    "チームアカウントを登録してメンバーに共有してください",
                    style: TextStyle(fontSize: 12.0, color: HexColor('3f72af')),
                  ),
                ),
                SizedBox(
                  height: 30.0,
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
                      controller: teamPasswordController,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        hintText: 'Passwordを入力してください。',
                        labelText: 'Password *',
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

  //TODO 重複したIDが登録できないようにする
  Future<bool> _backToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreenOnline()));
    return Future.value(false);
  }

  _insertTeam() {
    if (teamIdController.text == "") {
      Toast.show("Team IDが空欄です。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    if (teamPasswordController.text == "") {
      Toast.show("Passwordが空欄です。", context, duration: Toast.LENGTH_SHORT);
      return;
    }

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

    Toast.show("登録完了しました。", context, duration: Toast.LENGTH_SHORT);
  }
}
