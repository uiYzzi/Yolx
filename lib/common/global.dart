import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolx/common/const.dart';
import 'package:yolx/theme.dart';
// ignore: library_prefixes

class Global {
  static late SharedPreferences prefs;
  static final appTheme = AppTheme();
  static int rpcPort = defaultRPCPort;
  static String rpcSecret = '';
  static String ua = '';
  static String proxy = '';
  static String bypassProxy = '';
  static String downloadPath = '';
  static String rpcUrl =
      rpcURLValue.replaceAll('{port}', Global.rpcPort.toString());
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    appTheme.mode = ThemeMode.values[prefs.getInt('ThemeMode') ?? 0];
    if (prefs.getString('Language')?.split('_').length == 2) {
      appTheme.locale = Locale(
          prefs.getString('Language')?.split('_')[0] ?? 'zh',
          prefs.getString('Language')?.split('_')[1] ?? 'CN');
    } else {
      appTheme.locale = Locale(prefs.getString('Language') ?? 'en');
    }

    appTheme.displayMode =
        PaneDisplayMode.values[prefs.getInt('NavigationMode') ?? 4];
    appTheme.indicator =
        NavigationIndicators.values[prefs.getInt('NavigationIndicator') ?? 0];
    rpcPort = prefs.getInt('RPCPort') ?? defaultRPCPort;
    rpcSecret = prefs.getString('RPCSecret') ?? '';
    ua = prefs.getString('UA') ??
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36';
    proxy = prefs.getString('Proxy') ?? '';
    bypassProxy = prefs.getString('BypassProxy') ?? '';
    Directory? dir = await getDownloadsDirectory();
    downloadPath = (prefs.getString('DownloadPath') ?? dir?.path)!;
  }
}
