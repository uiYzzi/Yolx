import 'package:flutter/services.dart';

const MethodChannel _channel =
    MethodChannel('com.yoyo.flutter_native_channel/native_methods');

Future<String> nativeLibraryDir() async {
  return await _channel.invokeMethod('nativeLibraryDir');
}

requestPermission() async {
  return await _channel.invokeMethod('requestPermission');
}
