import 'package:http/http.dart' as http;
import 'package:yolx/common/global.dart';
import 'package:yolx/utils/log.dart';

getTrackerServersList(String subscriptionAddress) async {
  try {
    Set<String> serversList = Set.from(Global.trackerServersList.split('\n'));
    for (String address in subscriptionAddress.split(',')) {
      var res = await http.get(Uri.parse(address));
      if (res.statusCode == 200) {
        serversList.addAll(res.body
            .replaceAll(RegExp(r'\s+$', multiLine: true), '')
            .split('\n'));
      } else {
        Log.e('${res.reasonPhrase}');
      }
    }
    serversList.remove('');
    return serversList.join('\n');
  } catch (e) {
    Log.e(e);
  }
}
