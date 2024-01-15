import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:yolx/common/global.dart';
import 'package:yolx/generated/l10n.dart';
import 'package:yolx/utils/ariar2_http_utils.dart' as Aria2Http;

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
  @override
  void initState() {
    super.initState();
    _urlEditingController = TextEditingController(text: "");
    _downloadPathEditingController =
        TextEditingController(text: Global.downloadPath);
    _downloadLimitEditingController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _urlEditingController.dispose();
    _downloadPathEditingController.dispose();
    super.dispose();
  }

  int currentIndex = 0; // Initialize currentIndex with default value

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
          child: Text(S.of(context).submit),
          onPressed: () async {
            if (currentIndex == 0) {
              var params = {"dir": _downloadPathEditingController.text};
              if (_downloadLimitEditingController.text.isNotEmpty) {
                params['max-download-limit'] =
                    (double.parse(_downloadLimitEditingController.text) *
                            1048576)
                        .toInt()
                        .toString();
              }
              await Aria2Http.addUrl(
                  [_urlEditingController.text.split("\n"), params],
                  Global.rpcUrl);
            }

            // ignore: use_build_context_synchronously
            Navigator.pop(context, 'ok');
          },
        ),
      ],
      content: SizedBox(
        height: 400,
        child: TabView(
          tabs: [
            Tab(
                text: Text(S.current.URL),
                icon: const Icon(FluentIcons.link),
                semanticLabel: S.current.URL,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBox(
                      placeholder: S.current.URLTextBox,
                      placeholderStyle: const TextStyle(
                        overflow: TextOverflow.visible,
                      ),
                      controller: _urlEditingController,
                      minLines: 3,
                      maxLines: null,
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
                            icon: const Icon(FluentIcons.fabric_folder,
                                size: 20.0),
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
                )),
            Tab(
                text: Text(S.current.torrent),
                icon: const Icon(FluentIcons.classroom_logo),
                semanticLabel: S.current.torrent,
                body: Text(S.current.torrent)),
          ],
          closeButtonVisibility: CloseButtonVisibilityMode.never,
          currentIndex: currentIndex,
          onChanged: (index) {
            setState(() {
              currentIndex = index; // Update the currentIndex using setState
            });
          },
        ),
      ),
    );
  }
}
