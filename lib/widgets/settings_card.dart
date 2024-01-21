import 'package:fluent_ui/fluent_ui.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final bool isExpander;

  const SettingsCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content,
    this.isExpander = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(
      height: 10.0,
      width: 10.0,
    );
    if (isExpander == false) {
      return Card(
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        child: Row(
          children: [
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(subtitle),
              ],
            ),
            const Spacer(),
            content,
          ],
        ),
      );
    } else {
      return Expander(
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacer,
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(subtitle),
            spacer,
          ],
        ),
        content: content,
      );
    }
  }
}
