import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/parts/bottom_navigation_bar_original.dart';
import 'package:mahjong_record_sm/screens/board_every.dart';
import 'package:mahjong_record_sm/screens/chip_every.dart';
import 'package:mahjong_record_sm/screens/member_every.dart';

class RecordInquiryScreen extends StatefulWidget {
  @override
  _RecordInquiryScreenState createState() => _RecordInquiryScreenState();
}

class _RecordInquiryScreenState extends State<RecordInquiryScreen> {
  @override
  Widget build(BuildContext context) {
    final List<TabInfo> _tabs = [
      TabInfo(
        "　　対局毎　　",
        BoardEvery(),
      ),
      TabInfo(
        "　メンバー毎　",
        MemberEvery(),
      ),
      TabInfo(
        "　チップ収支　",
        ChipEvery(),
      ),
    ];

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          title: Text(
            "戦 績 照 会",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          bottom: PreferredSize(
            child: TabBar(
              labelColor: Colors.limeAccent,
              indicatorColor: Colors.limeAccent,
              unselectedLabelColor: Colors.black54,
              isScrollable: true,
              tabs: _tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),
            preferredSize: Size.fromHeight(30.0),
          ),
        ),
        body: TabBarView(
          children: _tabs.map((tab) => tab.widget).toList(),
        ),
        bottomNavigationBar: BottomNavigationBarOriginal(),
      ),
    );
  }
}

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}
