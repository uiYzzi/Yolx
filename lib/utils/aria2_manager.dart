import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:yolx/common/const.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/utils/common_utils.dart';
import 'package:yolx/utils/file_utils.dart';
import 'package:yolx/utils/log.dart';
import 'package:yolx/utils/native_channel_utils.dart';
import 'ariar2_http_utils.dart' as Aria2Http;

class Aria2Manager {
  late Future<Process> cmdProcess;
  late int processPid = 0;

  getAria2ExePath() async {
    if (Platform.isWindows || Platform.isLinux) {
      String dir = await getPlugAssetsDir('aria2');
      String ariaName = 'yolx_aria2c';
      if (Platform.isWindows) {
        ariaName = 'yolx_aria2c.exe';
      }
      return '$dir/$ariaName';
    } else if (Platform.isAndroid) {
      final libDir = await nativeLibraryDir();
      var libPath = '$libDir/libaria2c.so';
      File file = File(libPath);
      if (!file.existsSync()) {
        Log.e("aria2 not found:$libPath");
      }
      return libPath;
    }
  }

  getAria2ConfPath() async {
    Directory dir = await getApplicationSupportDirectory();
    String confName = 'yolx_aria2.conf';
    return '${dir.path}${Global.pathSeparator}$confName';
  }

  getAria2Session() async {
    Directory appDocumentsCacheDirectory = await getApplicationCacheDirectory();
    return '${appDocumentsCacheDirectory.path}${Global.pathSeparator}download.session';
  }

  initAria2Conf() async {
    String confPath = await getAria2ConfPath();
    if (!await File(confPath).exists()) {
      List<String> aria2ConfLines = await readDefAria2Conf();
      await writeLinesToFile(confPath, aria2ConfLines.join("\n"));
    }
  }

  void startServer() async {
    closeServer();
    Global.rpcUrl = rpcURLValue.replaceAll('{port}', Global.rpcPort.toString());
    var exe = await getAria2ExePath();
    var conf = await getAria2ConfPath();
    // print(File(conf).existsSync());
    if (Platform.isLinux) {
      permission777(exe);
      permission777(conf);
    }
    int port = Global.rpcPort;
    String secret = Global.rpcSecret;
    String session = await getAria2Session();
    File file = File(session);
    bool fileExists = await file.exists();

    if (!fileExists) {
      await file.create(recursive: true);
    }
    List<String> arguments = [
      '--conf-path=$conf',
      '--rpc-listen-port=$port',
      '--input-file=$session',
      '--save-session=$session'
    ];
    if (secret.isNotEmpty) {
      arguments.add('--rpc-secret=$secret');
    }
    cmdProcess = Process.start(exe, arguments);
    cmdProcess.then((processResult) {
      processPid = processResult.pid;
      processResult.exitCode.then((value) => Log.i(value));
      processResult.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen((event) {
        if (event.trim().isNotEmpty) {
          Log.i(event);
        }
      });
      processResult.stderr
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen((event) {
        if (event.trim().isNotEmpty) {
          Log.e("Error: $event");
        }
      });
    });
    Aria2Http.changeGlobalOption(
        {'dir': Global.downloadPath, 'user-agent': Global.ua}, Global.rpcUrl);
    if (Global.proxy.isNotEmpty) {
      Aria2Http.changeGlobalOption({'all-proxy': Global.proxy}, Global.rpcUrl);
    }
    if (Global.bypassProxy.isNotEmpty) {
      Aria2Http.changeGlobalOption(
          {'no-proxy': Global.bypassProxy}, Global.rpcUrl);
    }
    Aria2Http.changeGlobalOption({
      'max-concurrent-downloads': Global.maxConcurrentDownloads.toString(),
      'max-connection-per-server': Global.maxConnectionPerServer.toString()
    }, Global.rpcUrl);
  }

  closeServer() {
    bool killSuccess = false;
    if (Platform.isWindows) {
      final processResult =
          Process.runSync('taskkill', ['/F', '/T', '/IM', 'yolx_aria2c.exe']);
      killSuccess = processResult.exitCode == 0;
    } else if (Platform.isLinux || Platform.isAndroid) {
      final processResult = Process.runSync('killall', ['yolx_aria2c']);
      killSuccess = processResult.exitCode == 0;
    }
    Log.i(killSuccess
        ? "Successfully killed aria2 service"
        : "Killing Aria2 service failed");
  }
}
