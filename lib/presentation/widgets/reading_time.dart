import 'package:flutter/material.dart';

import '../../common/app_strings.dart';
import '../../common/helper_methods.dart';

typedef _S = AppStrings;
typedef _H = HelperMethods;

class ReadingTime extends StatelessWidget {
  final String title;
  final String content;
  final String description;

  const ReadingTime(
      {super.key,
      required this.title,
      required this.content,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          _S.someReadingTime,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
        ),
        const Spacer(),
        Text(_H.readingTime(title + content + description),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12,
            )),
      ],
    );
  }
}
