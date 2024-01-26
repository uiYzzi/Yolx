import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';

Future<File> getLocalFile(String filename) async {
  final directory = await getApplicationCacheDirectory();
  return File('${directory.path}${Global.pathSeparator}$filename');
}

getPlugAssetsDir(String plugName) async {
  if (Platform.isWindows || Platform.isLinux) {
    String plugDir =
        'data${Global.pathSeparator}plugin${Global.pathSeparator}$plugName';
    String exePath = Platform.resolvedExecutable;
    List<String> pathList = exePath.split(Global.pathSeparator);
    // String basename = path.basename(exePath);
    pathList[pathList.length - 1] = plugDir;
    return pathList.join(Global.pathSeparator);
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
  createFolderIfNotExists(
      "${Global.downloadPath}${Global.pathSeparator}${S.current.general}");
  createFolderIfNotExists(
      "${Global.downloadPath}${Global.pathSeparator}${S.current.compressedFiles}");
  createFolderIfNotExists(
      "${Global.downloadPath}${Global.pathSeparator}${S.current.documents}");
  createFolderIfNotExists(
      "${Global.downloadPath}${Global.pathSeparator}${S.current.music}");
  createFolderIfNotExists(
      "${Global.downloadPath}${Global.pathSeparator}${S.current.programs}");
  createFolderIfNotExists(
      "${Global.downloadPath}${Global.pathSeparator}${S.current.videos}");
}

int getDownloadDirectory(String fileType) {
  List<String> fileTypeRules = [
    Global.compressedFilesRule,
    Global.documentsRule,
    Global.musicRule,
    Global.programsRule,
    Global.videosRule,
  ];

  for (int i = 0; i < fileTypeRules.length; i++) {
    List<String> extensions = fileTypeRules[i].split(',');
    if (extensions.contains(fileType)) {
      return i;
    }
  }

  return 5;
}
