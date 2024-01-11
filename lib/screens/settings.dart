// ignore_for_file: constant_identifier_names
import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:yolx/common/global.dart';

import '../theme.dart';
import '../widgets/page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with PageMixin {
  late TextEditingController _rpcPortEditingController;
  late TextEditingController _rpcSecretEditingController;
  late TextEditingController _uaEditingController;
  late TextEditingController _proxyEditingController;
  late TextEditingController _bypassProxyEditingController;
  @override
  void initState() {
    super.initState();
    _rpcPortEditingController =
        TextEditingController(text: Global.rpcPort.toString());
    _rpcSecretEditingController = TextEditingController(text: Global.rpcSecret);
    _uaEditingController = TextEditingController(text: Global.ua);
    _proxyEditingController = TextEditingController(text: Global.proxy);
    _bypassProxyEditingController =
        TextEditingController(text: Global.bypassProxy);
  }

  @override
  void dispose() {
    _rpcPortEditingController.dispose();
    _rpcSecretEditingController.dispose();
    _uaEditingController.dispose();
    _proxyEditingController.dispose();
    _bypassProxyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();
    const spacer = SizedBox(
      height: 10.0,
      width: 10.0,
    );

    const supportedLocales = FluentLocalizations.supportedLocales;
    var currentLocale = appTheme.locale ?? Localizations.maybeLocaleOf(context);
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Settings')),
      children: [
        Text(
          'Basic',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        spacer,
        Expander(
          header: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                'Theme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sets the theme of the application.'),
              spacer,
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(ThemeMode.values.length, (index) {
              final mode = ThemeMode.values[index];
              return Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                child: RadioButton(
                  checked: appTheme.mode == mode,
                  onChanged: (value) async {
                    if (value) {
                      appTheme.mode = mode;

                      await Global.prefs.setInt('ThemeMode', mode.index);
                    }
                  },
                  content: Text('$mode'.replaceAll('ThemeMode.', '')),
                ),
              );
            }),
          ),
        ),
        spacer,
        Card(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            child: Row(
              children: [
                const SizedBox(width: 4),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Language',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Sets an override for the app\'s preferred language.'),
                  ],
                ),
                const Spacer(),
                ComboBox<Locale>(
                  value: currentLocale,
                  onChanged: (Locale? newValue) async {
                    if (newValue != null) {
                      setState(() {
                        currentLocale = newValue;
                        appTheme.locale = currentLocale;
                      });

                      await Global.prefs
                          .setString('Language', currentLocale!.languageCode);
                    }
                  },
                  items: supportedLocales
                      .map<ComboBoxItem<Locale>>((Locale locale) {
                    return ComboBoxItem<Locale>(
                      value: locale,
                      child: Text('$locale'),
                    );
                  }).toList(),
                ),
              ],
            )),
        spacer,
        Expander(
          header: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                'Navigation Mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sets the display mode of the navigation pane.'),
              spacer,
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(PaneDisplayMode.values.length, (index) {
              final mode = PaneDisplayMode.values[index];
              return Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                child: RadioButton(
                  checked: appTheme.displayMode == mode,
                  onChanged: (value) async {
                    if (value) appTheme.displayMode = mode;

                    await Global.prefs.setInt('NavigationMode', mode.index);
                  },
                  content: Text(
                    mode.toString().replaceAll('PaneDisplayMode.', ''),
                  ),
                ),
              );
            }),
          ),
        ),
        spacer,
        Expander(
          header: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                'Navigation Indicator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sets the visibility of the navigation indicator.'),
              spacer,
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                List.generate(NavigationIndicators.values.length, (index) {
              final mode = NavigationIndicators.values[index];
              return Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                child: RadioButton(
                  checked: appTheme.indicator == mode,
                  onChanged: (value) async {
                    if (value) appTheme.indicator = mode;

                    await Global.prefs
                        .setInt('NavigationIndicator', mode.index);
                  },
                  content: Text(
                    mode.toString().replaceAll('NavigationIndicators.', ''),
                  ),
                ),
              );
            }),
          ),
        ),
        spacer,
        Text(
          'Advanced',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        spacer,
        Expander(
          header: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                'Proxy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sets Download Proxy Server.'),
              spacer,
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBox(
                placeholder: '[http://][USER:PASSWORD@]HOST[:PORT]',
                controller: _proxyEditingController,
                expands: false,
              ),
              spacer,
              TextBox(
                placeholder:
                    'Bypass proxy settings for these Hosts and Domains,one per line',
                controller: _bypassProxyEditingController,
                expands: false,
              ),
              spacer,
              Row(
                children: [
                  FilledButton(
                    child: const Text('Save & Apply'),
                    onPressed: () async {
                      setState(() {
                        Global.proxy = _proxyEditingController.text;
                        Global.bypassProxy = _bypassProxyEditingController.text;
                      });
                      await Global.prefs.setString('Proxy', Global.proxy);
                      await Global.prefs
                          .setString('BypassProxy', Global.bypassProxy);
                      // ignore: use_build_context_synchronously
                      await displayInfoBar(context, builder: (context, close) {
                        return InfoBar(
                          title: const Text('Preferences saved successfully.'),
                          action: IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: close,
                          ),
                          severity: InfoBarSeverity.success,
                        );
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
        spacer,
        Expander(
          header: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                'RPC',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sets the RPC of the application.'),
              spacer,
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('RPC Listen Port'),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      placeholder: 'RPC Listen Port',
                      controller: _rpcPortEditingController,
                      expands: false,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.graph_symbol, size: 24.0),
                    onPressed: () async {
                      setState(() {
                        Global.rpcPort = 11000 + Random().nextInt(8999);
                        _rpcPortEditingController.text =
                            Global.rpcPort.toString();
                      });
                      await Global.prefs.setInt('RPCPort', Global.rpcPort);
                      // ignore: use_build_context_synchronously
                      await displayInfoBar(context, builder: (context, close) {
                        return InfoBar(
                          title: const Text(
                              'This setting modification requires application restart to take effect.'),
                          action: IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: close,
                          ),
                          severity: InfoBarSeverity.warning,
                        );
                      });
                    },
                  )
                ],
              ),
              spacer,
              const Text('RPC Secret'),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      placeholder: 'RPC Secret',
                      controller: _rpcSecretEditingController,
                      expands: false,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.graph_symbol, size: 24.0),
                    onPressed: () async {
                      setState(() {
                        const availableChars =
                            'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                        Global.rpcSecret = List.generate(
                            12,
                            (index) => availableChars[Random()
                                .nextInt(availableChars.length)]).join();
                        _rpcSecretEditingController.text = Global.rpcSecret;
                      });
                      await Global.prefs
                          .setString('RPCSecret', Global.rpcSecret);
                      // ignore: use_build_context_synchronously
                      await displayInfoBar(context, builder: (context, close) {
                        return InfoBar(
                          title: const Text(
                              'This setting modification requires application restart to take effect.'),
                          action: IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: close,
                          ),
                          severity: InfoBarSeverity.warning,
                        );
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        spacer,
        Expander(
          header: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                'User-Agent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Mock User-Agent.'),
              spacer,
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Button(
                    child: const Text('Aria2'),
                    onPressed: () async {
                      setState(() {
                        Global.ua = "aria2/1.36.0";
                        _uaEditingController.text = Global.ua;
                      });
                      await Global.prefs.setString('UA', Global.ua);
                    },
                  ),
                  Button(
                    child: const Text('Transmission'),
                    onPressed: () async {
                      setState(() {
                        Global.ua = "Transmission/3.00";
                        _uaEditingController.text = Global.ua;
                      });
                      await Global.prefs.setString('UA', Global.ua);
                    },
                  ),
                  Button(
                    child: const Text('Chrome'),
                    onPressed: () async {
                      setState(() {
                        Global.ua =
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36";
                        _uaEditingController.text = Global.ua;
                      });
                      await Global.prefs.setString('UA', Global.ua);
                    },
                  ),
                  Button(
                    child: const Text('Edge'),
                    onPressed: () async {
                      setState(() {
                        Global.ua =
                            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 Edg/100.0.1185.44";
                        _uaEditingController.text = Global.ua;
                      });
                      await Global.prefs.setString('UA', Global.ua);
                    },
                  ),
                  Button(
                    child: const Text('Du'),
                    onPressed: () async {
                      setState(() {
                        Global.ua =
                            "netdisk;6.0.0.12;PC;PC-Windows;10.0.16299;WindowsBaiduYunGuanJia";
                        _uaEditingController.text = Global.ua;
                      });
                      await Global.prefs.setString('UA', Global.ua);
                    },
                  ),
                ],
              ),
              TextBox(
                controller: _uaEditingController,
                maxLines: null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorBlock(AppTheme appTheme, AccentColor color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          appTheme.color = color;
        },
        style: ButtonStyle(
          padding: ButtonState.all(EdgeInsets.zero),
          backgroundColor: ButtonState.resolveWith((states) {
            if (states.isPressing) {
              return color.light;
            } else if (states.isHovering) {
              return color.lighter;
            }
            return color;
          }),
        ),
        child: Container(
          height: 40,
          width: 40,
          alignment: AlignmentDirectional.center,
          child: appTheme.color == color
              ? Icon(
                  FluentIcons.check_mark,
                  color: color.basedOnLuminance(),
                  size: 22.0,
                )
              : null,
        ),
      ),
    );
  }
}
