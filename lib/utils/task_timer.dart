import '../services/logger.dart';

class TaskTimer {
  final String taskName;

  late DateTime _startTime;
  DateTime? _endTime;

  TaskTimer({this.taskName = 'Unnamed Task'}); // default name if not provided

  void start() {
    _startTime = DateTime.now();
    _endTime = null;
  }

  void stop() {
    _endTime = DateTime.now();
  }

  Duration get duration {
    if (_endTime != null) {
      return _endTime!.difference(_startTime);
    } else {
      return DateTime.now().difference(_startTime);
    }
  }

  // Returns duration in mm:ss format
  String get durationString {
    final d = duration;
    return '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  // Returns elapsed time in seconds as int
  int get elapsedSeconds {
    return duration.inSeconds;
  }

  void stopAndLog() {
    stop();
    LoggerService.logEvent(
      'Task "$taskName" completed in $durationString (mm:ss)',
    );
  }
}
