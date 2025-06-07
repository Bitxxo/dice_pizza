import 'package:intl/intl.dart';

extension LastModifiedFormat on DateTime {
  String lastModifiedFormat() {
    return (DateFormat('d MMM, yyyy').format(this));
  }
}
