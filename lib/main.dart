import 'package:admob_flutter/admob_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:mahjong_record_sm/common/version_check.dart';
import 'package:mahjong_record_sm/db/database.dart';
import 'package:flutter/material.dart';

import 'common/home_screen.dart';

MyDatabase database;

GetIt locator = GetIt.instance;

void setupLocator() {
  locator
      .registerLazySingleton<VersionCheckService>(() => VersionCheckService());
}

void main() {
  setupLocator();
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
      title: "シンプルきろく",
      theme: ThemeData(
        fontFamily: 'GenShinGothic',
      ),
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: HomeScreen(),
        //RecordInquiryScreen(),
      ),
      localizationsDelegates: [
//        GlobalCupertinoLocalizations.delegate, // 追加
      ],
    );
  }
}
