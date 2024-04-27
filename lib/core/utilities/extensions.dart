import 'package:intl/intl.dart';

extension DateExtension on String? {
  // create extension to convert date string to DateTime
  String toNamedDate() {
    return DateFormat.yMMMMd().format(DateTime.parse(this ?? ""));
  }
}
