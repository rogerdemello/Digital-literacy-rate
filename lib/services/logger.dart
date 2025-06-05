import 'dart:developer';

class LoggerService {
  static final List<String> _logs = [];

  static String _escapeForCSV(String input) {
    if (input.contains(',') || input.contains('"') || input.contains('\n')) {
      return '"${input.replaceAll('"', '""')}"';
    }
    return input;
  }

  static void logEvent(String message, {Map<String, dynamic>? data}) {
    final timestamp = DateTime.now().toIso8601String();
    String logEntry = '$timestamp - ${_escapeForCSV(message)}';

    if (data != null && data.isNotEmpty) {
      logEntry += ' | data: ${_escapeForCSV(data.toString())}';
    }

    _logs.add(logEntry);
    log('[LoggerService] $logEntry');
  }

  static List<String> get logs => _logs;

  static void clearLogs() {
    _logs.clear();
  }
}
