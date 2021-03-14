import 'package:admob_flutter/admob_flutter.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/screens/base_page.dart';

MyDatabase database;

void main() {
  database = MyDatabase();
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "シンプルすぎる計算脳トレ",
        theme: ThemeData(
          fontFamily: 'GenShinGothic',
        ),
        home: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BasePage(),
          //RecordInquiryScreen(),
        ));
  }
}
