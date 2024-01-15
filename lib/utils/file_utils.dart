import 'dart:io';

import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';

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

void createFolderIfNotExists(String folderPath) {
  Directory directory = Directory(folderPath);

  if (!directory.existsSync()) {
    // 文件夹不存在，创建文件夹
    directory.createSync(recursive: true);
  }
}

void createClassificationFolder() {
  String pathSeparator = Platform.pathSeparator;
  createFolderIfNotExists(
      "${Global.downloadPath}$pathSeparator${S.current.general}");
  createFolderIfNotExists(
      "${Global.downloadPath}$pathSeparator${S.current.compressedFiles}");
  createFolderIfNotExists(
      "${Global.downloadPath}$pathSeparator${S.current.documents}");
  createFolderIfNotExists(
      "${Global.downloadPath}$pathSeparator${S.current.music}");
  createFolderIfNotExists(
      "${Global.downloadPath}$pathSeparator${S.current.programs}");
  createFolderIfNotExists(
      "${Global.downloadPath}$pathSeparator${S.current.videos}");
}

String getDownloadDirectory(String fileType) {
  String pathSeparator = Platform.pathSeparator;

  List<String> fileTypeRules = [
    Global.compressedFilesRule,
    Global.documentsRule,
    Global.musicRule,
    Global.programsRule,
    Global.videosRule,
  ];

  List<String> ruleNames = [
    S.current.compressedFiles,
    S.current.documents,
    S.current.music,
    S.current.programs,
    S.current.videos,
  ];

  for (int i = 0; i < fileTypeRules.length; i++) {
    List<String> extensions = fileTypeRules[i].split(',');
    if (extensions.contains(fileType)) {
      return '${Global.downloadPath}$pathSeparator${ruleNames[i]}';
    }
  }

  return '${Global.downloadPath}$pathSeparator${S.current.general}';
}
