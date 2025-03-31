import 'package:intl/intl.dart';

String formatDOP(double amount) {
  final format = NumberFormat.currency(locale: 'es_DO', symbol: 'RD\$');
  return format.format(amount);
}
