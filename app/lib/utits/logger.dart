import 'package:flutter/foundation.dart';

class Logger {
  static void logInfo(String message) {
    if (!kReleaseMode) {
      if (kDebugMode) {
        print('[INFO] $message');
      }
    }
  }

  static void logError(String message, dynamic error) {
    if (!kReleaseMode) {
      if (kDebugMode) {
        print('[ERROR] $message: $error');
      }
    }
  }

  static void logWarning(String message) {
    if (!kReleaseMode) {
      if (kDebugMode) {
        print('[WARNING] $message');
      }
    }
  }
}