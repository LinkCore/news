import 'package:intl/intl.dart';

typedef _C = _DateTimeConstants;

extension DateTimeExtension on DateTime {
  String get convertDate => DateFormat(_C.formatDate).format(this);

  String get convertTime => DateFormat(_C.formatTime).format(this);

  String get convertDateTime => DateFormat(_C.formatDateTime).format(this);
}

abstract class _DateTimeConstants {
  static const String formatDate = 'dd.MM.yyyy';
  static const String formatTime = 'kk:mm';
  static const String formatDateTime = 'dd.MM.yyyy, kk:mm';
}
