import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fluent_ui/fluent_ui.dart';

Widget uploadTorrent(BuildContext context, String text) {
  return Container(
    decoration: DottedDecoration(
      shape: Shape.box,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(FluentIcons.bulk_upload, size: 40),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}
