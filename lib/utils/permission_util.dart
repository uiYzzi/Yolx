import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'native_channel_utils.dart';

Future<bool> checkStoragePermission() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  if (androidInfo.version.sdkInt >= 30) {
    bool isGranted = await requestPermission();
    return isGranted;
  } else {
    PermissionStatus storageStatus = await Permission.storage.status;
    if (storageStatus.isDenied) {
      return true;
    }
    if ((await Permission.storage.request()).isGranted) {
      return true;
    }
  }
  return false;
}
