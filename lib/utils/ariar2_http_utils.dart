import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:yolx/common/global.dart';
import 'package:yolx/utils/log.dart';

var uuid = const Uuid();

getVersion(aria2url) async {
  String aria2Version = '0';
  try {
    var res = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.getVersion",
          "id": 'getVersion',
          "params": []
        }));
    if (res.statusCode == 200) {
      var resJson = json.decode(res.body);
      aria2Version = resJson['result']['version'];
    }
  } catch (e) {
    Log.e(e);
  }
  //{"id":1,"jsonrpc":"2.0","result":{"enabledFeatures":["Async DNS","BitTorrent","Firefox3 Cookie","GZip","HTTPS","Message Digest","Metalink","XML-RPC","SFTP"],"version":"1.36.0"}}
  // print(aria2Version);
  return aria2Version;
}

changeGlobalOption(params, aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;

    var res = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.changeGlobalOption",
          "id": "changeGlobalOption",
          "params": ['token:$rpcSecret', params]
        }));
    if (res.statusCode == 200) {
      var resJson = json.decode(res.body);
      return resJson['result'];
    }
  } catch (e) {
    Log.e(e);
  }
}

addUrl(params, aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;
    var res = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.addUri",
          "id": uuid.v4(),
          "params": ['token:$rpcSecret', ...params]
        }));
    if (res.statusCode == 200) {
      var resJson = json.decode(res.body);
      return resJson['result'];
    }
  } catch (e) {
    Log.e(e);
  }
}

addTorrent(params, aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;
    var res = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.addTorrent",
          "id": uuid.v4(),
          "params": ['token:$rpcSecret', ...params]
        }));
    if (res.statusCode == 200) {
      var resJson = json.decode(res.body);
      return resJson['result'];
    }
  } catch (e) {
    Log.e(e);
  }
}

tellStopped(String aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;
    var res = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.tellStopped",
          "id": 'tellStopped',
          "params": [
            'token:$rpcSecret',
            -1,
            1000,
            [
              "gid",
              "files",
              "totalLength",
              "completedLength",
              "uploadSpeed",
              "downloadSpeed",
              "connections",
              "numSeeders",
              "seeder",
              "status",
              "errorCode",
              "verifiedLength",
              "verifyIntegrityPending"
            ]
          ]
        }));
    if (res.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(res.bodyBytes));
      var result = jsonResponse['result'];
      return result;
    } else {
      Log.e('${res.reasonPhrase}');
    }
  } catch (e) {
    Log.e(e);
  }
}

tellWaiting(String aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;
    var res = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.tellWaiting",
          "id": 'tellWaiting',
          "params": [
            'token:$rpcSecret',
            0,
            100,
            [
              "gid",
              "files",
              "totalLength",
              "completedLength",
              "uploadSpeed",
              "downloadSpeed",
              "connections",
              "numSeeders",
              "seeder",
              "status",
              "errorCode",
              "verifiedLength",
              "verifyIntegrityPending"
            ]
          ]
        }));
    if (res.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(res.bodyBytes));
      var result = jsonResponse['result'];
      return result;
    } else {
      Log.e('${res.reasonPhrase}');
    }
  } catch (e) {
    Log.e(e);
  }
}

tellActive(String aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;
    var res = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.tellActive",
          "id": 'tellActive',
          "params": [
            'token:$rpcSecret',
            [
              "gid",
              "files",
              "totalLength",
              "completedLength",
              "uploadSpeed",
              "downloadSpeed",
              "connections",
              "numSeeders",
              "seeder",
              "status",
              "errorCode",
              "verifiedLength",
              "verifyIntegrityPending"
            ]
          ]
        }));
    if (res.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(res.bodyBytes));
      var result = jsonResponse['result'];
      return result;
    } else {
      Log.e('${res.reasonPhrase}');
    }
  } catch (e) {
    Log.e(e);
  }
}

unpauseAll(String aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;
    await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.forcePauseAll",
          "id": 'forcePauseAll',
          "params": ['token:$rpcSecret']
        }));
  } catch (e) {
    Log.e(e);
  }
}

forcePauseAll(String aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;
    await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.forcePauseAll",
          "id": 'forcePauseAll',
          "params": ['token:$rpcSecret']
        }));
  } catch (e) {
    Log.e(e);
  }
}

purgeDownloadResult(String aria2url) async {
  try {
    var rpcSecret = Global.rpcSecret;
    await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.purgeDownloadResult",
          "id": 'purgeDownloadResult',
          "params": ['token:$rpcSecret']
        }));
  } catch (e) {
    Log.e(e);
  }
}

forcePause(String aria2url, String gid) async {
  try {
    var rpcSecret = Global.rpcSecret;
    await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.forcePause",
          "id": 'forcePause',
          "params": ['token:$rpcSecret', gid]
        }));
  } catch (e) {
    Log.e(e);
  }
}

unpause(String aria2url, String gid) async {
  try {
    var rpcSecret = Global.rpcSecret;
    await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.unpause",
          "id": 'unpause',
          "params": ['token:$rpcSecret', gid]
        }));
  } catch (e) {
    Log.e(e);
  }
}

forceRemove(String aria2url, String gid) async {
  try {
    var rpcSecret = Global.rpcSecret;
    var r = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.forceRemove",
          "id": 'forceRemove',
          "params": ['token:$rpcSecret', gid]
        }));
    Log.i(r.body);
  } catch (e) {
    Log.e(e);
  }
}

removeDownloadResult(String aria2url, String gid) async {
  try {
    var rpcSecret = Global.rpcSecret;
    var r = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.removeDownloadResult",
          "id": 'removeDownloadResult',
          "params": ['token:$rpcSecret', gid]
        }));
    Log.i(r.body);
  } catch (e) {
    Log.e(e);
  }
}

changePosition(String aria2url, String gid, int pos, String how) async {
  try {
    var rpcSecret = Global.rpcSecret;
    var r = await http.post(Uri.parse(aria2url),
        body: json.encode({
          "jsonrpc": "2.0",
          "method": "aria2.changePosition",
          "id": 'changePosition',
          "params": ['token:$rpcSecret', gid, pos, how]
        }));
    Log.i(r.body);
  } catch (e) {
    Log.e(e);
  }
}
