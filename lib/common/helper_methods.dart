import 'package:intl/intl.dart';

import 'app_strings.dart';

typedef _S = AppStrings;

abstract class HelperMethods {
  static String convertDate(DateTime dateTime) =>
      DateFormat(_S.formatDate).format(dateTime);

  static String convertTime(DateTime dateTime) =>
      DateFormat(_S.formatTime).format(dateTime);

  static String convertDateTime(DateTime dateTime) =>
      DateFormat(_S.formatDateTime).format(dateTime);

  static String readingTime(String text) {
    const int readingSpeed = 70;
    if (' '.allMatches(text).length < readingSpeed) {
      return _S.oneMinute;
    } else if (readingSpeed <= ' '.allMatches(text).length &&
        ' '.allMatches(text).length < readingSpeed * 2) {
      return _S.twoMinutes;
    } else if (readingSpeed <= ' '.allMatches(text).length &&
        ' '.allMatches(text).length < readingSpeed * 3) {
      return _S.threeMinutes;
    } else {
      return _S.moreThanThreeMinutes;
    }
  }
}
