import 'dart:convert';
import 'dart:io';

import 'package:yolx/common/global.dart';
import 'package:yolx/utils/common_utils.dart';
import 'package:yolx/utils/file_utils.dart';
import 'package:yolx/utils/log.dart';
import 'ariar2_http_utils.dart' as Aria2Http;

class Aria2Manager {
  late Future<Process> cmdProcess;
  late int processPid = 0;
  getAria2rootPath() async {
    return await getPlugAssetsDir('aria2');
  }

  getAria2ExePath() async {
    if (Platform.isWindows || Platform.isLinux) {
      String dir = await getPlugAssetsDir('aria2');
      String ariaName = 'yolx_aria2c';
      if (Platform.isWindows) {
        ariaName = 'yolx_aria2c.exe';
      }
      return '$dir/$ariaName';
    }
  }

  getAria2ConfPath() async {
    if (Platform.isWindows || Platform.isLinux) {
      String dir = await getPlugAssetsDir('aria2');
      String confName = 'yolx_aria2.conf';
      return '$dir/$confName';
    }
  }

  void startServer() async {
    closeServer();
    var exe = await getAria2ExePath();
    var conf = await getAria2ConfPath();
    // print(File(conf).existsSync());
    if (Platform.isLinux) {
      permission777(exe);
      permission777(conf);
    }
    int port = Global.rpcPort;
    String secret = Global.rpcSecret;
    List<String> arguments = [
      '--conf-path=$conf',
      '--rpc-listen-port=$port',
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
    Aria2Http.changeGlobalOption({'dir': Global.downloadPath}, Global.rpcUrl);
  }

  closeServer() {
    bool killSuccess = false;
    if (Platform.isWindows) {
      final processResult =
          Process.runSync('taskkill', ['/F', '/T', '/IM', 'yolx_aria2c.exe']);
      killSuccess = processResult.exitCode == 0;
    } else if (Platform.isLinux) {
      final processResult = Process.runSync('killall', ['yolx_aria2c']);
      killSuccess = processResult.exitCode == 0;
    }
    Log.i(killSuccess
        ? "Successfully killed aria2 service"
        : "Killing Aria2 service failed");
  }
}
