import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
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
  late TextEditingController _maxDownloadLimitEditingController;
  late TextEditingController _lowestDownloadLimitEditingController;
  late TextEditingController _maxUploadLimitEditingController;
  late TextEditingController _uaEditingController;
  late ValueNotifier<String> _filePathNotifier;
  late ValueNotifier<int> _currentIndexNotifier;
  bool _isFilledButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    _urlEditingController = TextEditingController(text: "");
    _uaEditingController = TextEditingController(text: Global.ua);
    _urlEditingController.addListener(_updateButtonState);
    _currentIndexNotifier = ValueNotifier<int>(0);
    _currentIndexNotifier.addListener(_updateButtonState);
    _filePathNotifier = ValueNotifier<String>('');
    _filePathNotifier.addListener(_updateButtonState);
    _downloadPathEditingController =
        TextEditingController(text: Global.downloadPath);
    _maxDownloadLimitEditingController = TextEditingController(text: "");
    _lowestDownloadLimitEditingController = TextEditingController(text: "");
    _maxUploadLimitEditingController = TextEditingController(text: "");
    _getUrlFromClipboard();
  }

  void _getUrlFromClipboard() async {
    var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && Uri.parse(clipboardData.text!).hasScheme) {
      setState(() {
        _urlEditingController.text = clipboardData.text!;
      });
    }
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
    _uaEditingController.dispose();
    _currentIndexNotifier.dispose();
    _filePathNotifier.dispose();
    _downloadPathEditingController.dispose();
    _maxDownloadLimitEditingController.dispose();
    _lowestDownloadLimitEditingController.dispose();
    _maxUploadLimitEditingController.dispose();
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
                    if (_maxDownloadLimitEditingController.text.isNotEmpty) {
                      params['max-download-limit'] = (double.parse(
                                  _maxDownloadLimitEditingController.text) *
                              1048576)
                          .toInt()
                          .toString();
                    }
                    if (_currentIndexNotifier.value == 0) {
                      if (_uaEditingController.text.isNotEmpty) {
                        params['user-agent'] = _uaEditingController.text;
                      }
                      if (_lowestDownloadLimitEditingController
                          .text.isNotEmpty) {
                        params['lowest-speed-limit'] = (double.parse(
                                    _lowestDownloadLimitEditingController
                                        .text) *
                                1048576)
                            .toInt()
                            .toString();
                      }
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
                          if (urls[i].toLowerCase().startsWith("thunder://")) {
                            urls[i] = getURLFromThunder(urls[i]);
                          } else if (urls[i]
                              .toLowerCase()
                              .startsWith("flashget://")) {
                            urls[i] = getURLFromFlashget(urls[i]);
                          } else if (urls[i]
                              .toLowerCase()
                              .startsWith("qqdl://")) {
                            urls[i] = getURLFromQQDL(urls[i]);
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
                            if (urls[i]
                                .toLowerCase()
                                .startsWith("thunder://")) {
                              urls[i] = getURLFromThunder(urls[i]);
                            } else if (urls[i]
                                .toLowerCase()
                                .startsWith("flashget://")) {
                              urls[i] = getURLFromFlashget(urls[i]);
                            } else if (urls[i]
                                .toLowerCase()
                                .startsWith("qqdl://")) {
                              urls[i] = getURLFromQQDL(urls[i]);
                            }
                            await Aria2Http.addUrl([
                              [urls[i]],
                              params
                            ], Global.rpcUrl);
                          }
                        }
                      }
                    } else if (_currentIndexNotifier.value == 1) {
                      if (_maxUploadLimitEditingController.text.isNotEmpty) {
                        params['max-upload-limit'] = (double.parse(
                                    _maxUploadLimitEditingController.text) *
                                1048576)
                            .toInt()
                            .toString();
                      }
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
                    controller: _maxDownloadLimitEditingController,
                  ),
                ),
                const Text("MB/s"),
              ],
            ),
            if (_currentIndexNotifier.value == 1) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      placeholder: S.current.maxUploadLimit,
                      controller: _maxUploadLimitEditingController,
                    ),
                  ),
                  const Text("MB/s"),
                ],
              ),
            ],
            if (_currentIndexNotifier.value == 0) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: S.of(context).lowestDownloadLimitInfo,
                      displayHorizontally: true,
                      useMousePosition: false,
                      style: const TooltipThemeData(preferBelow: true),
                      child: TextBox(
                        placeholder: S.current.lowestDownloadLimit,
                        controller: _lowestDownloadLimitEditingController,
                      ),
                    ),
                  ),
                  const Text("MB/s"),
                ],
              ),
              const SizedBox(height: 4),
              Text(S.of(context).UA),
              Row(
                children: [
                  Expanded(
                    child: TextBox(
                      controller: _uaEditingController,
                      maxLines: null,
                    ),
                  ),
                ],
              ),
            ]
          ],
        ));
  }
}
