import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:mahjong_record_sm/screens-online/board_every_online.dart';
import 'package:mahjong_record_sm/screens-online/chip_every_online.dart';
import 'package:mahjong_record_sm/screens-online/member_every_online.dart';

class RecordInquiryScreenOnline extends StatefulWidget {
  @override
  _RecordInquiryScreenOnlineState createState() =>
      _RecordInquiryScreenOnlineState();
}

class _RecordInquiryScreenOnlineState extends State<RecordInquiryScreenOnline> {
  @override
  Widget build(BuildContext context) {
    final List<TabInfo> _tabs = [
      TabInfo(
        "　　対局毎　　",
        BoardEveryOnline(),
      ),
      TabInfo(
        "　メンバー毎　",
        MemberEveryOnline(),
      ),
      TabInfo(
        "　チップ収支　",
        ChipEveryOnline(),
      ),
    ];

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "戦 績 照 会",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: HexColor('f9f7f7'),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: HexColor('3f72af'),
          bottom: PreferredSize(
            child: TabBar(
              labelColor: HexColor('f9f7f7'),
              indicatorColor: HexColor('f9f7f7'),
              unselectedLabelColor: HexColor('f9f7f7'),
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
      ),
    );
  }
}

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}
