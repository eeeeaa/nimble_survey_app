import 'package:intl/intl.dart';

String getCurrentDateDisplay() {
  final now = DateTime.now();
  final formatter = DateFormat('EEEE, MMMM d');
  return formatter.format(now).toUpperCase();
}
