import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/main.dart';
import 'member_add_screen.dart';
import 'package:toast/toast.dart';

enum EditStatus { ADD, EDIT }

class EditScreen extends StatefulWidget {
  final EditStatus status;
  final Member member;

  EditScreen({@required this.status, this.member});
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var addMemberController = TextEditingController();

  String _titleText = "";

  @override
  void initState() {
    super.initState();
    if (widget.status == EditStatus.ADD) {
      _titleText = "新しいメンバーの追加";
      addMemberController.text = "";
    } else {
      _titleText = "登録したメンバー名の修正";
      addMemberController.text = widget.member.strMemberName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backToMemberAddScreen(),
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => _backToMemberAddScreen()),
          automaticallyImplyLeading: true,
          title: Text(
            _titleText,
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
    );
  }

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

  Future<bool> _backToMemberAddScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MemberAddScreen()));
    return Future.value(false);
  }

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
