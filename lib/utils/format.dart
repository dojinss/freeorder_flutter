import 'package:intl/intl.dart';

class CustomFormat {
  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}
