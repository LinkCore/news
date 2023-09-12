import 'package:flutter/material.dart';
import 'package:news/common/extensions/build_context.dart';
import 'package:news/common/extensions/date_time.dart';
import 'package:news/common/extensions/text_style.dart';
import 'package:news/generated/l10n.dart';

class PublicationWidget extends StatefulWidget {
  final String author;
  final DateTime publishedAt;
  final bool disabled;

  const PublicationWidget({
    required this.author,
    required this.publishedAt,
    this.disabled = false,
    super.key,
  });

  @override
  State<PublicationWidget> createState() => _PublicationWidgetState();
}

class _PublicationWidgetState extends State<PublicationWidget> {
  String dateToString(DateTime dateTime) {
    String currentDateTime = dateTime.convertDate;
    String nowDateTime = DateTime.now().convertDate;
    String yesterday =
        DateTime.now().subtract(const Duration(days: 1)).convertDate;

    if (currentDateTime == nowDateTime) {
      return '${S.of(context).todayAt}${dateTime.convertTime}';
    } else if (currentDateTime == yesterday) {
      return '${S.of(context).yesterdayIn}${dateTime.convertTime}';
    } else {
      return dateTime.convertDateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor =
        widget.disabled ? context.colors.textDisabledColor : Colors.black;
    final TextStyle style =
        context.textTheme.bodySmall!.medium.withColor(textColor);
    return Row(
      children: [
        Text(
          widget.author,
          style: style,
        ),
        const Spacer(),
        Text(
          dateToString(widget.publishedAt),
          style: style,
        ),
      ],
    );
  }
}
