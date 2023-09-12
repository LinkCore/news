import 'package:flutter/material.dart';
import 'package:news/common/extensions/build_context.dart';
import 'package:news/common/extensions/text_style.dart';
import 'package:news/generated/l10n.dart';

import '../../common/app_utilities.dart';

class ReadingTimeWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool disabled;

  const ReadingTimeWidget({
    this.disabled = false,
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = context.colors.disabledColor(disabled);
    final TextStyle style =
        context.textTheme.bodySmall!.bold.withColor(textColor);
    return Row(
      children: [
        Text(
          S.current.someReadingTime,
          style: style,
        ),
        const Spacer(),
        Text(
          AppUtilities.readingTime(title + content),
          style: style,
        ),
      ],
    );
  }
}
