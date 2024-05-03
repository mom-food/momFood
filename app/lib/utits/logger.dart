import 'package:flutter/foundation.dart';

class Logger {
  static void logInfo(String message) {
    if (!kReleaseMode) {
      print('[INFO] $message');
    }
  }

  static void logError(String message, dynamic error) {
    if (!kReleaseMode) {
      print('[ERROR] $message: $error');
    }
  }

  static void logWarning(String message) {
    if (!kReleaseMode) {
      print('[WARNING] $message');
    }
  }
}