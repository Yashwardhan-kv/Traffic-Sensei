// utils.dart
import 'package:intl/intl.dart';
import 'dart:math';

class Utils {
  /// Formats a given DateTime to a readable string
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  /// Generates a random number within a given range
  static int generateRandomNumber(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  /// Capitalizes the first letter of a given string
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}