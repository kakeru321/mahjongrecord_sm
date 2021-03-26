import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/parts/hex_color.dart';
import 'package:mahjong_record_sm/screens-online/chip_record_add_online.dart';
import 'package:mahjong_record_sm/screens-online/point_record_add_online.dart';

class RecordAddScreenOnline extends StatefulWidget {
  @override
  _RecordAddScreenOnlineState createState() => _RecordAddScreenOnlineState();
}

class _RecordAddScreenOnlineState extends State<RecordAddScreenOnline> {
  @override
  Widget build(BuildContext context) {
    final List<TabInfo> _tabs = [
      TabInfo("　　 　　点数 　　　　", PointRecordAddOnline()),
      TabInfo("　　　チップ枚数　　　", ChipRecordAddOnline()),
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          title: Text(
            "戦 績 入 力",
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
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
      ),
    );
  }
}

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}
