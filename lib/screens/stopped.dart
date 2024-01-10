import 'package:fluent_ui/fluent_ui.dart';

import '../widgets/page.dart';

class StoppedPage extends StatefulWidget {
  const StoppedPage({super.key});

  @override
  State<StoppedPage> createState() => _StoppedPageState();
}

class _StoppedPageState extends State<StoppedPage> with PageMixin {
  bool selected = true;
  String? comboboxValue;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('Stopped'),
        commandBar: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Tooltip(
            message: 'Purge Task Record',
            displayHorizontally: true,
            useMousePosition: false,
            style: const TooltipThemeData(preferBelow: true),
            child: IconButton(
              icon: const Icon(FluentIcons.delete_table, size: 18.0),
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
