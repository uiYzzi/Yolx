import 'dart:io';

getPlugAssetsDir(String plugName) async {
  String pathSeparator = Platform.pathSeparator;
  if (Platform.isWindows || Platform.isLinux) {
    String plugDir = 'data${pathSeparator}plugin$pathSeparator$plugName';
    String exePath = Platform.resolvedExecutable;
    List<String> pathList = exePath.split(pathSeparator);
    // String basename = path.basename(exePath);
    pathList[pathList.length - 1] = plugDir;
    return pathList.join(pathSeparator);
  }
  return null;
}
