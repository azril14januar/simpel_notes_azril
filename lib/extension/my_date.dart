import 'package:intl/intl.dart';

extension MyDate on DateTime{
  String formatDate () {
    final DateFormat formatter = DateFormat("EE, MMMM yyyy");
    return formatter.format(this);
  }

}