// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Downloading`
  String get downloading {
    return Intl.message(
      'Downloading',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Waiting`
  String get waiting {
    return Intl.message(
      'Waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `Stopped`
  String get stopped {
    return Intl.message(
      'Stopped',
      name: 'stopped',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Delete All Tasks`
  String get deleteAllTasks {
    return Intl.message(
      'Delete All Tasks',
      name: 'deleteAllTasks',
      desc: '',
      args: [],
    );
  }

  /// `Refresh Task List`
  String get refreshTaskList {
    return Intl.message(
      'Refresh Task List',
      name: 'refreshTaskList',
      desc: '',
      args: [],
    );
  }

  /// `Resume All Tasks`
  String get resumeAllTasks {
    return Intl.message(
      'Resume All Tasks',
      name: 'resumeAllTasks',
      desc: '',
      args: [],
    );
  }

  /// `Pause All Tasks`
  String get pauseAllTasks {
    return Intl.message(
      'Pause All Tasks',
      name: 'pauseAllTasks',
      desc: '',
      args: [],
    );
  }

  /// `Purge Task Record`
  String get purgeTaskRecord {
    return Intl.message(
      'Purge Task Record',
      name: 'purgeTaskRecord',
      desc: '',
      args: [],
    );
  }

  /// `Basic`
  String get basic {
    return Intl.message(
      'Basic',
      name: 'basic',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Sets the theme of the application.`
  String get setsTheThemeOfTheApplication {
    return Intl.message(
      'Sets the theme of the application.',
      name: 'setsTheThemeOfTheApplication',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Sets an override for the app's preferred language.`
  String get setsAnOverrideForTheAppsPreferredLanguage {
    return Intl.message(
      'Sets an override for the app\'s preferred language.',
      name: 'setsAnOverrideForTheAppsPreferredLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Navigation Mode`
  String get navigationMode {
    return Intl.message(
      'Navigation Mode',
      name: 'navigationMode',
      desc: '',
      args: [],
    );
  }

  /// `Sets the display mode of the navigation pane.`
  String get setsTheDisplayModeOfTheNavigationPane {
    return Intl.message(
      'Sets the display mode of the navigation pane.',
      name: 'setsTheDisplayModeOfTheNavigationPane',
      desc: '',
      args: [],
    );
  }

  /// `Navigation Indicator`
  String get navigationIndicator {
    return Intl.message(
      'Navigation Indicator',
      name: 'navigationIndicator',
      desc: '',
      args: [],
    );
  }

  /// `Set the style of the navigation indicator.`
  String get setsTheStyleOfTheNavigationIndicator {
    return Intl.message(
      'Set the style of the navigation indicator.',
      name: 'setsTheStyleOfTheNavigationIndicator',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get advanced {
    return Intl.message(
      'Advanced',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `Sets Download Proxy Server.`
  String get setsDownloadProxyServer {
    return Intl.message(
      'Sets Download Proxy Server.',
      name: 'setsDownloadProxyServer',
      desc: '',
      args: [],
    );
  }

  /// `Proxy`
  String get proxy {
    return Intl.message(
      'Proxy',
      name: 'proxy',
      desc: '',
      args: [],
    );
  }

  /// `Bypass proxy settings for these Hosts and Domains,one per line`
  String get bypassProxy {
    return Intl.message(
      'Bypass proxy settings for these Hosts and Domains,one per line',
      name: 'bypassProxy',
      desc: '',
      args: [],
    );
  }

  /// `Save & Apply`
  String get saveApply {
    return Intl.message(
      'Save & Apply',
      name: 'saveApply',
      desc: '',
      args: [],
    );
  }

  /// `Preferences saved successfully.`
  String get savedSuccessfully {
    return Intl.message(
      'Preferences saved successfully.',
      name: 'savedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `RPC`
  String get RPC {
    return Intl.message(
      'RPC',
      name: 'RPC',
      desc: '',
      args: [],
    );
  }

  /// `Sets the RPC of the application.`
  String get setsTheRPCOfTheApplication {
    return Intl.message(
      'Sets the RPC of the application.',
      name: 'setsTheRPCOfTheApplication',
      desc: '',
      args: [],
    );
  }

  /// `RPC Listen Port`
  String get RPCListenPort {
    return Intl.message(
      'RPC Listen Port',
      name: 'RPCListenPort',
      desc: '',
      args: [],
    );
  }

  /// `This setting modification requires application restart to take effect.`
  String get RPCInfo {
    return Intl.message(
      'This setting modification requires application restart to take effect.',
      name: 'RPCInfo',
      desc: '',
      args: [],
    );
  }

  /// `RPC Secret`
  String get RPCSecret {
    return Intl.message(
      'RPC Secret',
      name: 'RPCSecret',
      desc: '',
      args: [],
    );
  }

  /// `User-Agent`
  String get UA {
    return Intl.message(
      'User-Agent',
      name: 'UA',
      desc: '',
      args: [],
    );
  }

  /// `Mock User-Agent.`
  String get mockUA {
    return Intl.message(
      'Mock User-Agent.',
      name: 'mockUA',
      desc: '',
      args: [],
    );
  }

  /// `Source code`
  String get sourceCode {
    return Intl.message(
      'Source code',
      name: 'sourceCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm close`
  String get confirmClose {
    return Intl.message(
      'Confirm close',
      name: 'confirmClose',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to close this window?`
  String get closeInfo {
    return Intl.message(
      'Are you sure you want to close this window?',
      name: 'closeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Download Path`
  String get downloadPath {
    return Intl.message(
      'Download Path',
      name: 'downloadPath',
      desc: '',
      args: [],
    );
  }

  /// `Set default download path`
  String get downloadPathInfo {
    return Intl.message(
      'Set default download path',
      name: 'downloadPathInfo',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newDownload {
    return Intl.message(
      'New',
      name: 'newDownload',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get URL {
    return Intl.message(
      'URL',
      name: 'URL',
      desc: '',
      args: [],
    );
  }

  /// `Torrent`
  String get torrent {
    return Intl.message(
      'Torrent',
      name: 'torrent',
      desc: '',
      args: [],
    );
  }

  /// `One task url per line (supports magnet)`
  String get URLTextBox {
    return Intl.message(
      'One task url per line (supports magnet)',
      name: 'URLTextBox',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Path`
  String get path {
    return Intl.message(
      'Path',
      name: 'path',
      desc: '',
      args: [],
    );
  }

  /// `Delete This Tasks`
  String get deleteThisTasks {
    return Intl.message(
      'Delete This Tasks',
      name: 'deleteThisTasks',
      desc: '',
      args: [],
    );
  }

  /// `Resume This Tasks`
  String get resumeThisTasks {
    return Intl.message(
      'Resume This Tasks',
      name: 'resumeThisTasks',
      desc: '',
      args: [],
    );
  }

  /// `Pause This Tasks`
  String get pauseThisTasks {
    return Intl.message(
      'Pause This Tasks',
      name: 'pauseThisTasks',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}