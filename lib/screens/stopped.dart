import 'package:fluent_ui/fluent_ui.dart';
import 'package:yolx/generated/l10n.dart';

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
        title: Text(S.of(context).stopped),
        commandBar: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Tooltip(
            message: S.of(context).purgeTaskRecord,
            displayHorizontally: true,
            useMousePosition: false,
            style: const TooltipThemeData(preferBelow: true),
            child: IconButton(
              icon: const Icon(FluentIcons.delete, size: 18.0),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: S.of(context).refreshTaskList,
            displayHorizontally: true,
            useMousePosition: false,
            style: const TooltipThemeData(preferBelow: true),
            child: IconButton(
              icon: const Icon(FluentIcons.refresh, size: 18.0),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: S.of(context).resumeAllTasks,
            displayHorizontally: true,
            useMousePosition: false,
            style: const TooltipThemeData(preferBelow: true),
            child: IconButton(
              icon: const Icon(FluentIcons.play, size: 18.0),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: S.of(context).pauseAllTasks,
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
