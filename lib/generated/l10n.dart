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

  /// `Bypass proxy settings for these Hosts and Domains,a comma separated`
  String get bypassProxy {
    return Intl.message(
      'Bypass proxy settings for these Hosts and Domains,a comma separated',
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

  /// `Restarting aria2 service to take effect settings.`
  String get RPCInfo {
    return Intl.message(
      'Restarting aria2 service to take effect settings.',
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

  /// `One task url per line (supports magnet and thunder://)`
  String get URLTextBox {
    return Intl.message(
      'One task url per line (supports magnet and thunder://)',
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

  /// `Remember Window Size`
  String get rememberWindowSize {
    return Intl.message(
      'Remember Window Size',
      name: 'rememberWindowSize',
      desc: '',
      args: [],
    );
  }

  /// `Restore the previous window size at startup`
  String get rememberWindowSizeInfo {
    return Intl.message(
      'Restore the previous window size at startup',
      name: 'rememberWindowSizeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Topping`
  String get topping {
    return Intl.message(
      'Topping',
      name: 'topping',
      desc: '',
      args: [],
    );
  }

  /// `Speed Limit`
  String get speedLimit {
    return Intl.message(
      'Speed Limit',
      name: 'speedLimit',
      desc: '',
      args: [],
    );
  }

  /// `Restrict download or upload speed`
  String get speedLimitInfo {
    return Intl.message(
      'Restrict download or upload speed',
      name: 'speedLimitInfo',
      desc: '',
      args: [],
    );
  }

  /// `Max Overall Download Limit`
  String get maxOverallDownloadLimit {
    return Intl.message(
      'Max Overall Download Limit',
      name: 'maxOverallDownloadLimit',
      desc: '',
      args: [],
    );
  }

  /// `Max Download Limit`
  String get maxDownloadLimit {
    return Intl.message(
      'Max Download Limit',
      name: 'maxDownloadLimit',
      desc: '',
      args: [],
    );
  }

  /// `Max Overall Upload Limit`
  String get maxOverallUploadLimit {
    return Intl.message(
      'Max Overall Upload Limit',
      name: 'maxOverallUploadLimit',
      desc: '',
      args: [],
    );
  }

  /// `Max Upload Limit`
  String get maxUploadLimit {
    return Intl.message(
      'Max Upload Limit',
      name: 'maxUploadLimit',
      desc: '',
      args: [],
    );
  }

  /// `Classification Saving`
  String get classificationSaving {
    return Intl.message(
      'Classification Saving',
      name: 'classificationSaving',
      desc: '',
      args: [],
    );
  }

  /// `Enabling category saving will create category directories in the download path.`
  String get classificationSavingInfo {
    return Intl.message(
      'Enabling category saving will create category directories in the download path.',
      name: 'classificationSavingInfo',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Compressed-Files`
  String get compressedFiles {
    return Intl.message(
      'Compressed-Files',
      name: 'compressedFiles',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message(
      'Documents',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Programs`
  String get programs {
    return Intl.message(
      'Programs',
      name: 'programs',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get videos {
    return Intl.message(
      'Videos',
      name: 'videos',
      desc: '',
      args: [],
    );
  }

  /// `Classification Saving Rules`
  String get classificationSavingRules {
    return Intl.message(
      'Classification Saving Rules',
      name: 'classificationSavingRules',
      desc: '',
      args: [],
    );
  }

  /// `Customization of classification saving rules`
  String get classificationSavingRulesInfo {
    return Intl.message(
      'Customization of classification saving rules',
      name: 'classificationSavingRulesInfo',
      desc: '',
      args: [],
    );
  }

  /// `Task Management`
  String get taskManagement {
    return Intl.message(
      'Task Management',
      name: 'taskManagement',
      desc: '',
      args: [],
    );
  }

  /// `Download task related settings`
  String get taskManagementInfo {
    return Intl.message(
      'Download task related settings',
      name: 'taskManagementInfo',
      desc: '',
      args: [],
    );
  }

  /// `Max Concurrent Downloads`
  String get maxConcurrentDownloads {
    return Intl.message(
      'Max Concurrent Downloads',
      name: 'maxConcurrentDownloads',
      desc: '',
      args: [],
    );
  }

  /// `Max Connection Per Server`
  String get maxConnectionPerServer {
    return Intl.message(
      'Max Connection Per Server',
      name: 'maxConnectionPerServer',
      desc: '',
      args: [],
    );
  }

  /// `Remove Task`
  String get removeTask {
    return Intl.message(
      'Remove Task',
      name: 'removeTask',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this download task?`
  String get removeTaskInfo {
    return Intl.message(
      'Are you sure you want to remove this download task?',
      name: 'removeTaskInfo',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete files when removing tasks`
  String get deleteFile {
    return Intl.message(
      'Delete files when removing tasks',
      name: 'deleteFile',
      desc: '',
      args: [],
    );
  }

  /// `Show Window`
  String get showWindow {
    return Intl.message(
      'Show Window',
      name: 'showWindow',
      desc: '',
      args: [],
    );
  }

  /// `Exit App`
  String get exitApp {
    return Intl.message(
      'Exit App',
      name: 'exitApp',
      desc: '',
      args: [],
    );
  }

  /// `Open Directory`
  String get openDirectory {
    return Intl.message(
      'Open Directory',
      name: 'openDirectory',
      desc: '',
      args: [],
    );
  }

  /// `Open File`
  String get openFile {
    return Intl.message(
      'Open File',
      name: 'openFile',
      desc: '',
      args: [],
    );
  }

  /// `Drag the torrent/metalink file here or click here to open it`
  String get dropTorrent {
    return Intl.message(
      'Drag the torrent/metalink file here or click here to open it',
      name: 'dropTorrent',
      desc: '',
      args: [],
    );
  }

  /// `Lowest Download Limit`
  String get lowestDownloadLimit {
    return Intl.message(
      'Lowest Download Limit',
      name: 'lowestDownloadLimit',
      desc: '',
      args: [],
    );
  }

  /// `Close connection if download speed is lower than or equal to this value.`
  String get lowestDownloadLimitInfo {
    return Intl.message(
      'Close connection if download speed is lower than or equal to this value.',
      name: 'lowestDownloadLimitInfo',
      desc: '',
      args: [],
    );
  }

  /// `Tracker Servers`
  String get trackerServers {
    return Intl.message(
      'Tracker Servers',
      name: 'trackerServers',
      desc: '',
      args: [],
    );
  }

  /// `Tracker Servers List`
  String get trackerServersList {
    return Intl.message(
      'Tracker Servers List',
      name: 'trackerServersList',
      desc: '',
      args: [],
    );
  }

  /// `Tracker servers,one per line`
  String get trackerServersListInfo {
    return Intl.message(
      'Tracker servers,one per line',
      name: 'trackerServersListInfo',
      desc: '',
      args: [],
    );
  }

  /// `Set the Bt Tracker server address`
  String get trackerServersInfo {
    return Intl.message(
      'Set the Bt Tracker server address',
      name: 'trackerServersInfo',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Address`
  String get subscriptionAddress {
    return Intl.message(
      'Subscription Address',
      name: 'subscriptionAddress',
      desc: '',
      args: [],
    );
  }

  /// `Separate links with commas(,)`
  String get subscriptionAddressInfo {
    return Intl.message(
      'Separate links with commas(,)',
      name: 'subscriptionAddressInfo',
      desc: '',
      args: [],
    );
  }

  /// `Update tracker list every day automatically`
  String get autoUpdateTrackerList {
    return Intl.message(
      'Update tracker list every day automatically',
      name: 'autoUpdateTrackerList',
      desc: '',
      args: [],
    );
  }

  /// `There are no current tasks`
  String get noTaskDownloaded {
    return Intl.message(
      'There are no current tasks',
      name: 'noTaskDownloaded',
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
