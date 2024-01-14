import 'dart:io';
import 'dart:math';

import 'package:yolx/common/const.dart';

permission777(filePath) {
  Process.runSync('chmod', ['-R', '777', filePath]);
}

String formatFileSize(int size) {
  if (size <= 0) return '0 B';
  final int index = (log(size) / log(1024)).floor();
  return '${(size / pow(1024, index)).toStringAsFixed(2)} ${sizeUnits[index]}';
}

parseProxyString(String proxyString) {
  String proxyType;
  String proxyHost;
  String proxyUsername = '';
  String proxyPassword = '';
  var params = {};

  // Check if the proxy string starts with "http://" or "https://"
  if (proxyString.startsWith('http://')) {
    proxyType = 'http';
    proxyString = proxyString.substring(7); // Remove "http://" from the string
  } else if (proxyString.startsWith('https://')) {
    proxyType = 'https';
    proxyString = proxyString.substring(8); // Remove "https://" from the string
  } else {
    // Invalid proxy string format
    print('Invalid proxy string format');
    return;
  }

  // Check if the proxy string contains username and password
  if (proxyString.contains('@')) {
    int atIndex = proxyString.indexOf('@');
    String credentials = proxyString.substring(0, atIndex);
    proxyString = proxyString
        .substring(atIndex + 1); // Remove credentials from the string

    // Extract username and password
    int colonIndex = credentials.indexOf(':');
    if (colonIndex == -1) {
      proxyUsername = credentials.substring(0);
    } else {
      proxyUsername = credentials.substring(0, colonIndex);
      proxyPassword = credentials.substring(colonIndex + 1);
    }
  }

  proxyHost = proxyString.substring(0);
  if (proxyType == 'http') {
    params['http-proxy'] = proxyHost;
    if (proxyUsername.isNotEmpty) {
      params['http-proxy-user'] = proxyUsername;
    }
    if (proxyPassword.isNotEmpty) {
      params['http-proxy-passwd'] = proxyPassword;
    }
  }
  if (proxyType == 'https') {
    params['https-proxy'] = proxyHost;
    if (proxyUsername.isNotEmpty) {
      params['https-proxy-user'] = proxyUsername;
    }
    if (proxyPassword.isNotEmpty) {
      params['https-proxy-passwd'] = proxyPassword;
    }
  }
  return params;
}
