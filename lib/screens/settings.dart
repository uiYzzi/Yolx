// ignore_for_file: constant_identifier_names
import 'dart:math';

import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';
import 'package:yolx/utils/aria2_manager.dart';
// ignore: library_prefixes
import 'package:yolx/utils/ariar2_http_utils.dart' as Aria2Http;
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
  late TextEditingController _downloadPathEditingController;
  late TextEditingController _maxOverallDownloadLimitEditingController;
  late TextEditingController _maxDownloadLimitEditingController;
  late TextEditingController _maxOverallUploadLimitEditingController;
  late TextEditingController _maxUploadLimitEditingController;
  late bool _rememberWindowSize;
  late bool _classificationSaving;
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
    _downloadPathEditingController =
        TextEditingController(text: Global.downloadPath);
    _rememberWindowSize = Global.rememberWindowSize;
    _maxOverallDownloadLimitEditingController =
        TextEditingController(text: Global.maxOverallDownloadLimit.toString());
    _maxDownloadLimitEditingController =
        TextEditingController(text: Global.maxDownloadLimit.toString());
    _maxOverallUploadLimitEditingController =
        TextEditingController(text: Global.maxOverallUploadLimit.toString());
    _maxUploadLimitEditingController =
        TextEditingController(text: Global.maxUploadLimit.toString());
    _classificationSaving = Global.classificationSaving;
  }

  @override
  void dispose() {
    _rpcPortEditingController.dispose();
    _rpcSecretEditingController.dispose();
    _uaEditingController.dispose();
    _proxyEditingController.dispose();
    _bypassProxyEditingController.dispose();
    _maxOverallDownloadLimitEditingController.dispose();
    _maxDownloadLimitEditingController.dispose();
    _maxOverallUploadLimitEditingController.dispose();
    _maxUploadLimitEditingController.dispose();
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

    final supportedLocales =
        context.findAncestorWidgetOfExactType<FluentApp>()?.supportedLocales;
    var currentLocale = appTheme.locale ?? Localizations.maybeLocaleOf(context);
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text(S.of(context).settings)),
      children: [
        Text(
          S.of(context).basic,
          style: FluentTheme.of(context).typography.subtitle,
        ),
        spacer,
        Expander(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                S.of(context).theme,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(S.of(context).setsTheThemeOfTheApplication),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).language,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(S
                        .of(context)
                        .setsAnOverrideForTheAppsPreferredLanguage),
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
                          .setString('Language', currentLocale.toString());
                    }
                  },
                  items: supportedLocales
                      ?.map<ComboBoxItem<Locale>>((Locale locale) {
                    return ComboBoxItem<Locale>(
                      value: locale,
                      child: Text('$locale'),
                    );
                  }).toList(),
                ),
              ],
            )),
        spacer,
        Card(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).rememberWindowSize,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(S.of(context).rememberWindowSizeInfo),
                  ],
                ),
                const Spacer(),
                ToggleSwitch(
                  checked: _rememberWindowSize,
                  onChanged: (bool value) {
                    setState(() {
                      _rememberWindowSize = value; // 更新状态
                      Global.rememberWindowSize = value;
                      Global.prefs.setBool('RememberWindowSize', value);
                    });
                  },
                ),
              ],
            )),
        spacer,
        Expander(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                S.of(context).navigationMode,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(S.of(context).setsTheDisplayModeOfTheNavigationPane),
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
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                S.of(context).navigationIndicator,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(S.of(context).setsTheStyleOfTheNavigationIndicator),
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
        Card(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).downloadPath,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(S.of(context).downloadPathInfo),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 200,
                  child: TextBox(
                    enabled: false,
                    controller: _downloadPathEditingController,
                    expands: false,
                  ),
                ),
                IconButton(
                    icon: const Icon(FluentIcons.fabric_folder, size: 18.0),
                    onPressed: () async {
                      final String? path = await getDirectoryPath();
                      if (path != null) {
                        setState(() {
                          Global.downloadPath = path;
                          _downloadPathEditingController.text = path;
                        });
                        Aria2Http.changeGlobalOption(
                            {'dir': Global.downloadPath}, Global.rpcUrl);
                      }
                    })
              ],
            )),
        spacer,
        Card(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).classificationSaving,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(S.of(context).classificationSavingInfo),
                  ],
                ),
                const Spacer(),
                ToggleSwitch(
                  checked: _classificationSaving,
                  onChanged: (bool value) {
                    setState(() {
                      _classificationSaving = value; // 更新状态
                      Global.classificationSaving = value;
                      Global.prefs.setBool('ClassificationSaving', value);
                    });
                  },
                ),
              ],
            )),
        spacer,
        Expander(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                S.of(context).speedLimit,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(S.of(context).speedLimitInfo),
              spacer,
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).maxOverallDownloadLimit),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      controller: _maxOverallDownloadLimitEditingController,
                      expands: false,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text("MB/s"),
                ],
              ),
              spacer,
              Text(S.of(context).maxDownloadLimit),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      controller: _maxDownloadLimitEditingController,
                      expands: false,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text("MB/s"),
                ],
              ),
              spacer,
              Text(S.of(context).maxOverallUploadLimit),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      controller: _maxOverallUploadLimitEditingController,
                      expands: false,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text("MB/s"),
                ],
              ),
              spacer,
              Text(S.of(context).maxUploadLimit),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      controller: _maxUploadLimitEditingController,
                      expands: false,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text("MB/s"),
                ],
              ),
              spacer,
              Row(
                children: [
                  FilledButton(
                    child: Text(S.of(context).saveApply),
                    onPressed: () async {
                      setState(() {
                        if (_maxOverallDownloadLimitEditingController
                            .text.isNotEmpty) {
                          Global.maxOverallDownloadLimit = double.parse(
                              _maxOverallDownloadLimitEditingController.text);
                        }
                        if (_maxDownloadLimitEditingController
                            .text.isNotEmpty) {
                          Global.maxDownloadLimit = double.parse(
                              _maxDownloadLimitEditingController.text);
                        }
                        if (_maxOverallUploadLimitEditingController
                            .text.isNotEmpty) {
                          Global.maxOverallUploadLimit = double.parse(
                              _maxOverallUploadLimitEditingController.text);
                        }
                        if (_maxUploadLimitEditingController.text.isNotEmpty) {
                          Global.maxUploadLimit = double.parse(
                              _maxUploadLimitEditingController.text);
                        }
                      });
                      await Global.prefs.setDouble('MaxOverallDownloadLimit',
                          Global.maxOverallDownloadLimit);
                      await Global.prefs.setDouble(
                          'MaxDownloadLimit', Global.maxDownloadLimit);
                      await Global.prefs.setDouble('MaxOverallUploadLimit',
                          Global.maxOverallUploadLimit);
                      await Global.prefs
                          .setDouble('MaxUploadLimit', Global.maxUploadLimit);
                      Aria2Http.changeGlobalOption({
                        'max-overall-download-limit':
                            (Global.maxOverallDownloadLimit * 1048576)
                                .toInt()
                                .toString(),
                        'max-download-limit':
                            (Global.maxDownloadLimit * 1048576)
                                .toInt()
                                .toString(),
                        'max-overall-upload-limit':
                            (Global.maxOverallUploadLimit * 1048576)
                                .toInt()
                                .toString(),
                        'max-upload-limit':
                            (Global.maxUploadLimit * 1048576).toInt().toString()
                      }, Global.rpcUrl);
                      // ignore: use_build_context_synchronously
                      await displayInfoBar(context, builder: (context, close) {
                        return InfoBar(
                          title: Text(S.of(context).savedSuccessfully),
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
        Text(
          S.of(context).advanced,
          style: FluentTheme.of(context).typography.subtitle,
        ),
        spacer,
        Expander(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                S.of(context).proxy,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(S.of(context).setsDownloadProxyServer),
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
                placeholder: S.of(context).bypassProxy,
                controller: _bypassProxyEditingController,
                expands: false,
              ),
              spacer,
              Row(
                children: [
                  FilledButton(
                    child: Text(S.of(context).saveApply),
                    onPressed: () async {
                      setState(() {
                        Global.proxy = _proxyEditingController.text;
                        Global.bypassProxy = _bypassProxyEditingController.text;
                      });
                      await Global.prefs.setString('Proxy', Global.proxy);
                      await Global.prefs
                          .setString('BypassProxy', Global.bypassProxy);
                      if (Global.proxy.isNotEmpty) {
                        Aria2Http.changeGlobalOption(
                            {'all-proxy': Global.proxy}, Global.rpcUrl);
                      }
                      if (Global.bypassProxy.isNotEmpty) {
                        Aria2Http.changeGlobalOption(
                            {'no-proxy': Global.bypassProxy}, Global.rpcUrl);
                      }
                      // ignore: use_build_context_synchronously
                      await displayInfoBar(context, builder: (context, close) {
                        return InfoBar(
                          title: Text(S.of(context).savedSuccessfully),
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
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                S.of(context).RPC,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(S.of(context).setsTheRPCOfTheApplication),
              spacer,
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).RPCListenPort),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      placeholder: S.of(context).RPCListenPort,
                      controller: _rpcPortEditingController,
                      expands: false,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.graph_symbol, size: 24.0),
                    onPressed: () async {
                      setState(() {
                        _rpcPortEditingController.text =
                            (11000 + Random().nextInt(8999)).toString();
                      });
                    },
                  )
                ],
              ),
              spacer,
              Text(S.of(context).RPCSecret),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      placeholder: S.of(context).RPCSecret,
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
                        _rpcSecretEditingController.text = List.generate(
                            12,
                            (index) => availableChars[Random()
                                .nextInt(availableChars.length)]).join();
                      });
                    },
                  )
                ],
              ),
              spacer,
              Row(
                children: [
                  FilledButton(
                    child: Text(S.of(context).saveApply),
                    onPressed: () async {
                      Global.rpcSecret = _rpcSecretEditingController.text;
                      await Global.prefs
                          .setString('RPCSecret', Global.rpcSecret);
                      Global.rpcPort =
                          int.parse(_rpcPortEditingController.text);
                      await Global.prefs.setInt('RPCPort', Global.rpcPort);
                      Aria2Manager().startServer();
                      // ignore: use_build_context_synchronously
                      await displayInfoBar(context, builder: (context, close) {
                        return InfoBar(
                          title: Text(S.of(context).RPCInfo),
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
              )
            ],
          ),
        ),
        spacer,
        Expander(
          header: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacer,
              Text(
                S.of(context).UA,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(S.of(context).mockUA),
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
                        _uaEditingController.text = "aria2/1.36.0";
                      });
                    },
                  ),
                  Button(
                    child: const Text('Transmission'),
                    onPressed: () async {
                      setState(() {
                        _uaEditingController.text = "Transmission/3.00";
                      });
                    },
                  ),
                  Button(
                    child: const Text('Chrome'),
                    onPressed: () async {
                      setState(() {
                        _uaEditingController.text =
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36";
                      });
                    },
                  ),
                  Button(
                    child: const Text('Edge'),
                    onPressed: () async {
                      setState(() {
                        _uaEditingController.text =
                            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 Edg/100.0.1185.44";
                      });
                    },
                  ),
                  Button(
                    child: const Text('Du'),
                    onPressed: () async {
                      setState(() {
                        _uaEditingController.text =
                            "netdisk;6.0.0.12;PC;PC-Windows;10.0.16299;WindowsBaiduYunGuanJia";
                      });
                    },
                  ),
                ],
              ),
              spacer,
              TextBox(
                controller: _uaEditingController,
                maxLines: null,
              ),
              spacer,
              Row(
                children: [
                  FilledButton(
                    child: Text(S.of(context).saveApply),
                    onPressed: () async {
                      Global.ua = _uaEditingController.text;
                      Aria2Http.changeGlobalOption(
                          {'user-agent': Global.ua}, Global.rpcUrl);
                      // ignore: use_build_context_synchronously
                      await displayInfoBar(context, builder: (context, close) {
                        return InfoBar(
                          title: Text(S.of(context).savedSuccessfully),
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
      ],
    );
  }

  void updateRPCPort(BuildContext context) async {
    setState(() {
      Global.rpcPort = 11000 + Random().nextInt(8999);
      _rpcPortEditingController.text = Global.rpcPort.toString();
    });

    await Global.prefs.setInt('RPCPort', Global.rpcPort);

    // ignore: use_build_context_synchronously
    await displayInfoBar(context, builder: (context, close) {
      return InfoBar(
        title: Text(S.of(context).RPCInfo),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: InfoBarSeverity.warning,
      );
    });
  }
}
