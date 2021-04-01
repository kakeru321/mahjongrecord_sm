import 'dart:io';
import 'dart:math' as math;
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
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

  static String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-7104775285154830~1946964690';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7104775285154830~1946964690';
    }
    return null;
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-7104775285154830/5999235244';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7104775285154830/9525215581';
    }
    return null;
  }

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  @override
  Widget build(BuildContext context) {
    var interstitialRandom = math.Random().nextInt(7);
    var correct = 0;
    print(interstitialRandom);
    /*
    if (interstitialRandom == correct) {
      FirebaseAdMob.instance.initialize(appId: getAppId());

      InterstitialAd myInterstitial = InterstitialAd(
        // Replace the testAdUnitId with an ad unit id from the AdMob dash.
        // https://developers.google.com/admob/android/test-ads
        // https://developers.google.com/admob/ios/test-ads
        adUnitId: getInterstitialAdUnitId(),
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd event is $event");
        },
      );

      myInterstitial
        ..load()
        ..show(
          anchorType: AnchorType.bottom,
          anchorOffset: 0.0,
          horizontalCenterOffset: 0.0,
        );
    }
*/
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
