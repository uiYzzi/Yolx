import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolx/common/const.dart';
import 'package:yolx/theme.dart';

class Global {
  static late SharedPreferences prefs;
  static final appTheme = AppTheme();
  static int rpcPort = defaultRPCPort;
  static String rpcSecret = '';
  static String ua = '';
  static String proxy = '';
  static String bypassProxy = '';
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    appTheme.mode = ThemeMode.values[prefs.getInt('ThemeMode') ?? 0];
    appTheme.locale = Locale(prefs.getString('Language')?.split('_')[0] ?? 'zh',
        prefs.getString('Language')?.split('_')[1] ?? 'CN');
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
  }
}
