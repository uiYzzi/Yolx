import 'dart:convert';
import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:path/path.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';
import 'package:yolx/utils/ariar2_http_utils.dart' as Aria2Http;
import 'package:yolx/utils/file_utils.dart';
import 'package:yolx/utils/url_utils.dart';
import 'package:yolx/widgets/upload_torrent.dart';

class NewDownloadDialog extends StatefulWidget {
  const NewDownloadDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewDownloadDialogState createState() => _NewDownloadDialogState();
}

class _NewDownloadDialogState extends State<NewDownloadDialog> {
  late TextEditingController _urlEditingController;
  late TextEditingController _downloadPathEditingController;
  late TextEditingController _downloadLimitEditingController;
  late ValueNotifier<String> _filePathNotifier;
  late ValueNotifier<int> _currentIndexNotifier;
  bool _isFilledButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    _urlEditingController = TextEditingController(text: "");
    _urlEditingController.addListener(_updateButtonState);
    _currentIndexNotifier = ValueNotifier<int>(0);
    _currentIndexNotifier.addListener(_updateButtonState);
    _filePathNotifier = ValueNotifier<String>('');
    _filePathNotifier.addListener(_updateButtonState);
    _downloadPathEditingController =
        TextEditingController(text: Global.downloadPath);
    _downloadLimitEditingController = TextEditingController(text: "");
  }

  void _updateButtonState() {
    setState(() {
      _isFilledButtonEnabled = _currentIndexNotifier.value == 0 &&
              _urlEditingController.text.isNotEmpty ||
          _currentIndexNotifier.value == 1 &&
              _filePathNotifier.value.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _urlEditingController.dispose();
    _downloadPathEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
        actions: [
          Button(
            child: Text(S.of(context).cancel),
            onPressed: () {
              Navigator.pop(context, 'cancel');
            },
          ),
          FilledButton(
            onPressed: !_isFilledButtonEnabled
                ? null
                : () async {
                    var params = {};
                    if (_downloadLimitEditingController.text.isNotEmpty) {
                      params['max-download-limit'] =
                          (double.parse(_downloadLimitEditingController.text) *
                                  1048576)
                              .toInt()
                              .toString();
                    }
                    if (_currentIndexNotifier.value == 0) {
                      String downloadPath;
                      var urls = _urlEditingController.text.split("\n");
                      if (Global.classificationSaving &&
                          _downloadPathEditingController.text ==
                              Global.downloadPath) {
                        createClassificationFolder();
                        List<String> ruleNames = [
                          S.current.compressedFiles,
                          S.current.documents,
                          S.current.music,
                          S.current.programs,
                          S.current.videos,
                          S.current.general
                        ];
                        for (int i = 0; i < urls.length; i++) {
                          if (urls[i].startsWith("thunder://")) {
                            urls[i] = getURLFromThunder(urls[i]);
                          }
                          var j =
                              getDownloadDirectory(await getFileType(urls[i]));
                          params["dir"] =
                              '${Global.downloadPath}${Global.pathSeparator}${ruleNames[j]}';
                          await Aria2Http.addUrl([
                            [urls[i]],
                            params
                          ], Global.rpcUrl);
                        }
                      } else {
                        downloadPath = _downloadPathEditingController.text;
                        params["dir"] = downloadPath;
                        for (int i = 0; i < urls.length; i++) {
                          if (urls[i].isNotEmpty) {
                            if (urls[i].startsWith("thunder://")) {
                              urls[i] = getURLFromThunder(urls[i]);
                            }
                            await Aria2Http.addUrl([
                              [urls[i]],
                              params
                            ], Global.rpcUrl);
                          }
                        }
                      }
                    } else if (_currentIndexNotifier.value == 1) {
                      params["dir"] = _downloadPathEditingController.text;
                      List<int> fileBytes =
                          File(_filePathNotifier.value).readAsBytesSync();
                      String base64Encoded = base64Encode(fileBytes);
                      if (_filePathNotifier.value.endsWith('.torrent')) {
                        await Aria2Http.addTorrent(
                            [base64Encoded, [], params], Global.rpcUrl);
                      } else {
                        await Aria2Http.addMetalink(
                            [base64Encoded, params], Global.rpcUrl);
                      }
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, 'ok');
                  },
            child: Text(S.of(context).submit),
          ),
        ],
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              child: TabView(
                tabs: [
                  Tab(
                    text: Text(S.current.URL),
                    icon: const Icon(FluentIcons.link),
                    semanticLabel: S.current.URL,
                    body: TextBox(
                      placeholder: S.current.URLTextBox,
                      placeholderStyle: const TextStyle(
                        overflow: TextOverflow.visible,
                      ),
                      controller: _urlEditingController,
                      minLines: 6,
                      maxLines: null,
                    ),
                  ),
                  Tab(
                      text: Text(S.current.torrent),
                      icon: const Icon(FluentIcons.classroom_logo),
                      semanticLabel: S.current.torrent,
                      body: DropTarget(
                          onDragDone: (DropDoneDetails details) {
                            final filePath = details.files.last.path;
                            if (filePath.endsWith('.torrent') ||
                                filePath.endsWith('.meta4') ||
                                filePath.endsWith('.metalink')) {
                              setState(() {
                                _filePathNotifier.value = filePath;
                              });
                            }
                          },
                          child: GestureDetector(
                              onTap: () async {
                                const xType = XTypeGroup(extensions: [
                                  'torrent',
                                  'meta4',
                                  'metalink'
                                ]);
                                final XFile? file =
                                    await openFile(acceptedTypeGroups: [xType]);

                                if (file != null) {
                                  setState(() {
                                    _filePathNotifier.value = file.path;
                                  });
                                }
                              },
                              child: uploadTorrent(
                                  context,
                                  (_filePathNotifier.value.isNotEmpty
                                      ? basename(_filePathNotifier.value)
                                      : S.of(context).dropTorrent))))),
                ],
                closeButtonVisibility: CloseButtonVisibilityMode.never,
                currentIndex: _currentIndexNotifier.value,
                onChanged: (index) {
                  setState(() {
                    _currentIndexNotifier.value =
                        index; // Update the _currentIndexNotifier.value using setState
                  });
                },
              ),
            ),
            const SizedBox(height: 4),
            Text(S.of(context).path),
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    enabled: false,
                    controller: _downloadPathEditingController,
                    expands: false,
                  ),
                ),
                IconButton(
                    icon: const Icon(FluentIcons.fabric_folder, size: 20.0),
                    onPressed: () async {
                      final String? path = await getDirectoryPath();
                      if (path != null) {
                        setState(() {
                          _downloadPathEditingController.text = path;
                        });
                      }
                    })
              ],
            ),
            const SizedBox(height: 4),
            Text(S.of(context).speedLimit),
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    placeholder: S.current.maxDownloadLimit,
                    controller: _downloadLimitEditingController,
                  ),
                ),
                const Text("MB/s"),
              ],
            ),
          ],
        ));
  }
}
