import 'package:fluent_ui/fluent_ui.dart';

import '../widgets/page.dart';

class DownloadingPage extends StatefulWidget {
  const DownloadingPage({super.key});

  @override
  State<DownloadingPage> createState() => _DownloadingPageState();
}

class _DownloadingPageState extends State<DownloadingPage> with PageMixin {
  bool selected = true;
  String? comboboxValue;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('Downloading'),
        commandBar: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Tooltip(
            message: 'Delete Selected Tasks',
            displayHorizontally: true,
            useMousePosition: false,
            style: const TooltipThemeData(preferBelow: true),
            child: IconButton(
              icon: const Icon(FluentIcons.delete, size: 18.0),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: 'Refresh Task List',
            displayHorizontally: true,
            useMousePosition: false,
            style: const TooltipThemeData(preferBelow: true),
            child: IconButton(
              icon: const Icon(FluentIcons.refresh, size: 18.0),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: 'Resume All Tasks',
            displayHorizontally: true,
            useMousePosition: false,
            style: const TooltipThemeData(preferBelow: true),
            child: IconButton(
              icon: const Icon(FluentIcons.play, size: 18.0),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: 'Pause All Tasks',
            displayHorizontally: true,
            useMousePosition: false,
            style: const TooltipThemeData(preferBelow: true),
            child: IconButton(
              icon: const Icon(FluentIcons.pause, size: 18.0),
              onPressed: () {},
            ),
          ),
        ]),
      ),
      children: [],
    );
  }
}
