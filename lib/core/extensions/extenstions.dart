import 'package:intl/intl.dart';

extension StringExtension on String? {
  String capitalize() {
    if (this == null) {
      return '';
    }
    return this!.substring(0, 1).toUpperCase() +
        this!.substring(1, this!.length);
  }

  String? nameShortForm() {
    if (this == null) {
      return null;
    }
    final name = this!.trim().split(' ');
    if (name.length > 1) {
      return name.first.substring(0, 1).toUpperCase() +
          name.last.substring(0, 1).toUpperCase();
    } else if (name.first.length > 1) {
      return name.first.substring(0, 2).toUpperCase();
    } else {
      return name.first.toUpperCase();
    }
  }
}

extension DateTimeExtension on DateTime? {
  String? getFormattedDate() {
    if (this == null) {
      return null;
    }

    return DateFormat.MMMd().format(this!);
  }

  String? getFormattedDateTime() {
    if (this == null) {
      return null;
    }

    return DateFormat.yMMMEd().format(this!);
  }
}
