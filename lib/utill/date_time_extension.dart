import 'package:intl/intl.dart';

extension DateTimeX on DateTime?{
  String get simpleDate {
    if(this == null) return '---- -- --';
    return DateFormat.yMMMMd().format(this!);
  }
}