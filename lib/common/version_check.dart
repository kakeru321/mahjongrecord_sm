import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';

class VersionCheckService {
  static const String DEV_VERSION_CONFIG = "dev_app_version";
  static const String CONFIG_VERSION = "force_update_app_version";

  /// バージョンチェック関数
  Future<bool> versionCheck() async {
    // versionCode(buildNumber)取得
    final PackageInfo info = await PackageInfo.fromPlatform();
//    int currentVersion = int.parse(info.buildNumber);
    String currentVersion = info.version;
    // releaseビルドかどうかで取得するconfig名を変更
    final configName = bool.fromEnvironment('dart.vm.product')
        ? CONFIG_VERSION
        : DEV_VERSION_CONFIG;

    print(info);
    print(currentVersion);
    print(configName);

    List<String> currentVersionList = currentVersion.split(".");

    // remote config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // 常にサーバーから取得するようにするため期限を最小限にセット
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      String newVersion = remoteConfig.getString(configName);
      List<String> newVersionList = newVersion.split(".");

//      メジャーバージョンの比較
      if (int.parse(newVersionList[0]) > int.parse(currentVersionList[0])) {
        return true;
      }
//      マイナーバージョンの比較
      else if (int.parse(newVersionList[1]) >
          int.parse(currentVersionList[1])) {
        return true;
      }
//      リビジョンバージョンの比較
      else if (int.parse(newVersionList[2]) >
          int.parse(currentVersionList[2])) {
        return true;
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
    return false;
  }
}
