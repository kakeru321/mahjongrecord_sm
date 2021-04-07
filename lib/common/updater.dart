import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahjong_record_sm/common/version_check.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

/// 強制アップデートダイアログを出す為のダミーに近いStatefulWidget
class Updater extends StatefulWidget {
  Updater({Key key}) : super(key: key);

  @override
  State<Updater> createState() => _UpdaterState();
}

class _UpdaterState extends State<Updater> {
  @override
  void initState() {
    final checker = locator<VersionCheckService>();
    checker.versionCheck().then((needUpdate) => _showUpdateDialog(needUpdate));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
    );
  }

  // FIXME ストアにアプリを登録したらurlが入れられる
  static const APP_STORE_URL =
      'https://apps.apple.com/jp/app/id1552695825?mt=8';

  // FIXME ストアにアプリを登録したらurlが入れられる
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=mimim.shshsh.mahjong_record_sm';

  /// 更新版案内ダイアログを表示
  void _showUpdateDialog(bool needUpdate) {
    if (!needUpdate) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final title = "バージョン更新のお知らせ";
        final message = "新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用下さい。";
        final btnLabel = "今すぐ更新";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      btnLabel,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => _launchURL(APP_STORE_URL),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      btnLabel,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => _launchURL(PLAY_STORE_URL),
                  ),
                ],
              );
      },
    );
  }

  /// 指定のURLを起動する. App Store or Play Storeのリンク
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
