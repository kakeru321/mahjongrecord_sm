import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/formats/member-online.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'edit_screen_online.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_session/flutter_session.dart';

class MemberAddScreenOnline extends StatefulWidget {
  @override
  _MemberAddScreenOnlineState createState() => _MemberAddScreenOnlineState();
}

class _MemberAddScreenOnlineState extends State<MemberAddScreenOnline> {
  List<MemberOnline> _memberList = [];

  @override
  void initState() {
    super.initState();
    _getAllMember();
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
      appBar: AppBar(
        title: Text(
          "メ ン バー 管 理",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: HexColor('f9f7f7'),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('3f72af'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewMember(),
        child: Icon(Icons.add_outlined),
        tooltip: "新しいメンバーを追加",
        backgroundColor: HexColor('112d4e'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: maxHeight * (1 / 100),
          ),
          SizedBox(height: maxHeight - 250.0, child: _memberListWidget()),
        ],
      ),
    );
  }

  //メンバー登録画面に遷移する。
  _addNewMember() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreenOnline(),
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
    setState(() {});
  }

  //すべてのメンバーをリスト化する。
  Widget _memberListWidget() {
    return ListView.builder(
        itemCount: _memberList.length,
        itemBuilder: (context, int position) => _memberItem(position));
  }

  //カードの中身を定義
  Widget _memberItem(int position) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: HexColor('112d4e'), width: 2)),
      color: HexColor('dbe2ef'),
      child: ListTile(
        title: Text(
          "${_memberList[position].memberName}",
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
//        onLongPress: () => _deleteMember(_memberList[position]), TODO memberDelete
      ),
    );
  }

/*
  //メンバーを削除する。
  _deleteMember(Member selectedMember) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(selectedMember.strMemberName),
        content: Text("削除しても良いですか？"),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () async {
              await database.deleteMember(selectedMember);
              Toast.show("削除完了しました", context);
              _getAllMember();
              Navigator.pop(context);
            },
            child: Text("はい"),
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("いいえ"),
          )
        ],
      ),
    );
  }*/
}
