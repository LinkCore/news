import 'package:flutter/material.dart';

import '../../common/app_strings.dart';
import '../../common/helper_methods.dart';

typedef _S = AppStrings;
typedef _H = HelperMethods;

class Publication extends StatelessWidget {
  final String author;
  final DateTime publishedAt;

  String dateToString(DateTime dateTime) {
    String currentDateTime = _H.convertDate(dateTime);
    String nowDateTime = _H.convertDate(DateTime.now());
    String yesterday =
        _H.convertDate(DateTime.now().subtract(const Duration(days: 1)));

    if (currentDateTime == nowDateTime) {
      return '${_S.todayAt}${_H.convertTime(dateTime)}';
    } else if (currentDateTime == yesterday) {
      return '${_S.yesterdayIn}${_H.convertTime(dateTime)}';
    } else {
      return _H.convertDateTime(dateTime);
    }
  }

  const Publication(
      {super.key, required this.author, required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(author,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            )),
        const Spacer(),
        Text(dateToString(publishedAt),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            )),
      ],
    );
  }
}
