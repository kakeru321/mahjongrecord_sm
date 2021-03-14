import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/services/admob.dart';
import 'package:toast/toast.dart';

import '../main.dart';
import 'edit_screen.dart';

class MemberAddScreen extends StatefulWidget {
  @override
  _MemberAddScreenState createState() => _MemberAddScreenState();
}

class _MemberAddScreenState extends State<MemberAddScreen> {
  List<Member> _memberList = [];

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
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text(
          "メ ン バー 管 理",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewMember(),
        child: Icon(Icons.add_outlined),
        tooltip: "新しいメンバーを追加",
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          SizedBox(height: maxHeight - 375.0, child: _memberListWidget()),
        ],
      ),
    );
  }

  //メンバー登録画面に遷移する。
  _addNewMember() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(),
      ),
    );
  }

  //すべてのメンバーを取得する。
  void _getAllMember() async {
    _memberList = await database.allMembers;
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.lightGreenAccent,
      child: ListTile(
        title: Text(
          "${_memberList[position].strMemberName}",
          style: TextStyle(color: Colors.blueGrey),
        ),
        onLongPress: () => _deleteMember(_memberList[position]),
      ),
    );
  }

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
  }
}
