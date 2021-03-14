import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/screens/member_add_screen.dart';
import 'package:mahjong_record_sm/screens/record_add_screen.dart';
import 'package:mahjong_record_sm/screens/record_inquiry_screen.dart';
import 'package:mahjong_record_sm/services/admob.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  List _pageList = [
    RecordInquiryScreen(),
    RecordAddScreen(),
    MemberAddScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_selectedIndex],
      bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            AdmobBanner(
              adUnitId: AdMobService().getBannerAdUnitId(),
              adSize: AdmobBannerSize(
                width: MediaQuery.of(context).size.width.toInt(),
                height: AdMobService().getHeight(context).toInt(),
                name: 'SMART_BANNER',
              ),
            ),
            BottomNavigationBar(
              backgroundColor: Colors.orange,
              selectedItemColor: Colors.limeAccent,
              unselectedItemColor: Colors.black54,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.article,
                    color: Colors.white,
                  ),
                  label: '戦績照会',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.photo_filter,
                    color: Colors.white,
                  ),
                  label: '戦績入力',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_add_sharp,
                    color: Colors.white,
                  ),
                  label: 'メンバー管理',
                )
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ]),
    );
  }
}
