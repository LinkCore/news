import 'package:news/generated/l10n.dart';

abstract class AppUtilities {
  static String readingTime(String text) {
    const int readingSpeed = 70;
    final int timeInMinutes = text.split(' ').length ~/ readingSpeed;
    return S.current.pageNotificationsCount(timeInMinutes);
  }
}
