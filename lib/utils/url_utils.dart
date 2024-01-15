import 'package:http/http.dart' as http;

Future<String> getFileTypeFromHeader(String url) async {
  var response = await http.head(Uri.parse(url));
  // 获取文件名
  var filename = response.headers['content-disposition'];
  if (filename != null) {
    filename = filename.split('filename=')[1];
    int dotPos = filename.lastIndexOf('.');
    if (dotPos != -1 && dotPos < filename.length - 1) {
      // extract and return the file extension
      return filename.substring(dotPos + 1);
    } else {
      return '';
    }
  }
  return '';
}

Future<String> getFileTypeFromURL(String url) async {
  try {
    Uri uri = Uri.parse(url);
    String host = uri.host;

    if (host.isNotEmpty && url.endsWith(host)) {
      // handle ...example.com
      return '';
    }
  } catch (e) {
    return '';
  }
  int lastSlashPos = url.lastIndexOf('/');
  int startIndex = (lastSlashPos != -1) ? lastSlashPos + 1 : 0;
  int length = url.length;
  // find end index for ?
  int lastQMPos = url.lastIndexOf('?');
  if (lastQMPos == -1) {
    lastQMPos = length;
  }
  // find end index for #
  int lastHashPos = url.lastIndexOf('#');
  if (lastHashPos == -1) {
    lastHashPos = length;
  }
  // calculate the end index
  int endIndex = (lastQMPos < lastHashPos) ? lastQMPos : lastHashPos;
  String fileName = url.substring(startIndex, endIndex);

  int dotPos = fileName.lastIndexOf('.');
  if (dotPos != -1 && dotPos < fileName.length - 1) {
    // extract and return the file extension
    return fileName.substring(dotPos + 1);
  } else {
    return '';
  }
}

Future<String> getFileType(String url) async {
  String? fileType = await getFileTypeFromURL(url);
  if (fileType.isEmpty) {
    return getFileTypeFromHeader(url);
  } else {
    return fileType;
  }
}
