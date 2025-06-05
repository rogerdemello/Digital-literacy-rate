import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'logger.dart';
import '../models/user_data.dart';

class CSVExporter {
  static Future<String?> exportUserLogsToCSV(UserData userData) async {
    try {
      final logs = LoggerService.logs;
      final csvContent = StringBuffer();

      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/user_log.csv';
      final file = File(path);
      final fileExists = await file.exists();

      if (!fileExists) {
        csvContent.writeln(
            'Name,Age,DigitalExperience,DeviceUseFrequency,TypingErrors,TypingWPM,TapCount,SwipeCount,ScrollTaskDurationSeconds,Timestamp,Event');
      }

      for (var log in logs) {
        final parts = log.split(' - ');
        if (parts.length >= 2) {
          final timestamp = parts[0];
          final event = parts.sublist(1).join(' - ').replaceAll(',', '');
          csvContent.writeln(
              '${_escape(userData.name)},${userData.age},${_escape(userData.digitalExperience)},${_escape(userData.deviceUseFrequency)},${userData.typingErrors},${userData.typingWPM},${userData.tapCount},${userData.swipeCount},${userData.scrollTaskDurationSeconds},$timestamp,$event');
        }
      }

      final sink = file.openWrite(mode: FileMode.append);
      sink.write(csvContent.toString());
      await sink.flush();
      await sink.close();

      print('CSV Exported/Appended to: $path');
      return path;
    } catch (e) {
      print('CSV export failed: $e');
      return null;
    }
  }

  static String _escape(String input) {
    if (input.contains(',') || input.contains('"') || input.contains('\n')) {
      return '"${input.replaceAll('"', '""')}"';
    }
    return input;
  }
}
