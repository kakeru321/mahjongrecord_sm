import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/parts/bottom_navigation_bar_original.dart';
import 'package:toast/toast.dart';

import '../main.dart';
import 'edit_screen.dart';

class MemberAddScreen extends StatefulWidget {
  @override
  _MemberAddScreenState createState() => _MemberAddScreenState();
}

class _MemberAddScreenState extends State<MemberAddScreen> {
  List<Member> _memberList = List();

  @override
  void initState() {
    super.initState();
    _getAllMember();
  }

  @override
  Widget build(BuildContext context) {
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
      body: _memberListWidget(),
      bottomNavigationBar: BottomNavigationBarOriginal(),
    );
  }

  _addNewMember() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(
                  status: EditStatus.ADD,
                )));
  }

  void _getAllMember() async {
    _memberList = await database.allMembers;
    setState(() {});
  }

  Widget _memberListWidget() {
    return ListView.builder(
        itemCount: _memberList.length,
        itemBuilder: (context, int position) => _memberItem(position));
  }

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
//        onTap: () => _editMember(_memberList[position]),
      ),
    );
  }

  _deleteMember(Member selectedMember) async {
    await database.deleteMember(selectedMember);
    Toast.show("削除完了しました", context);
    _getAllMember();
  }

  _editMember(Member selectedMember) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(
                  status: EditStatus.EDIT,
                  member: selectedMember,
                )));
  }
}
