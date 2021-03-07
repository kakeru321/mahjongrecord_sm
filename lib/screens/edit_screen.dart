import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/main.dart';
import 'member_add_screen.dart';
import 'package:toast/toast.dart';

class EditScreen extends StatefulWidget {
  final Member member;

  EditScreen({this.member});
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var addMemberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backToMemberAddScreen(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.lightGreen,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => _backToMemberAddScreen()),
            automaticallyImplyLeading: true,
            title: Text(
              "新しいメンバーの追加",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.done),
                tooltip: "登録",
                onPressed: () => _insertMember(),
              )
            ],
            backgroundColor: Colors.orange,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Text(
                    "メンバー名を入力して「登録」ボタンを押して下さい",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
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
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: addMemberController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }

  //メンバー登録画面に戻る。
  Future<bool> _backToMemberAddScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MemberAddScreen()));
    return Future.value(false);
  }

  //メンバーを登録する。
  _insertMember() async {
    if (addMemberController.text == "") {
      Toast.show("メンバー名を入力しないと登録できません。", context, duration: Toast.LENGTH_SHORT);
      return;
    }
    var member = Member(
      strMemberName: addMemberController.text,
    );
    await database.addMember(member);
    print("OK");
    addMemberController.clear();

    Toast.show("登録完了しました。", context, duration: Toast.LENGTH_SHORT);
  }
}
