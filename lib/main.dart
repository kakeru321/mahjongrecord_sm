import 'package:mahjong_record_sm/db/database.dart';
import 'package:mahjong_record_sm/screens/home_screen.dart';
import 'package:flutter/material.dart';

MyDatabase database;

void main() {
  database = MyDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "シンプルすぎる計算脳トレ",
      theme: ThemeData(
        fontFamily: 'GenShinGothic',
      ),
      home: HomeScreen(),
    );
  }
}
