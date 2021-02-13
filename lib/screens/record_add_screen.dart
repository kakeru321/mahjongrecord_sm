import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/main.dart';
import 'package:mahjong_record_sm/parts/bottom_navigation_bar_original.dart';
import 'package:mahjong_record_sm/parts/buttom_with_icon.dart';
import 'package:mahjong_record_sm/screens/chip_record_add.dart';
import 'package:mahjong_record_sm/screens/point_record_add.dart';
import 'package:toast/toast.dart';

class RecordAddScreen extends StatefulWidget {
  @override
  _RecordAddScreenState createState() => _RecordAddScreenState();
}

class _RecordAddScreenState extends State<RecordAddScreen> {
  @override
  Widget build(BuildContext context) {
    final List<TabInfo> _tabs = [
      TabInfo("　　 　　点数 　　　　", PointRecordAdd()),
      TabInfo("　　　チップ枚数　　　", ChipRecordAdd()),
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
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
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
