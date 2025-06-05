import 'package:flutter/material.dart';
import '../services/logger.dart';
import '../utils/task_timer.dart';

class TaskScrollScreen extends StatefulWidget {
  final VoidCallback onNext;

  const TaskScrollScreen({super.key, required this.onNext});

  @override
  _TaskScrollScreenState createState() => _TaskScrollScreenState();
}

class _TaskScrollScreenState extends State<TaskScrollScreen> {
  final ScrollController _scrollController = ScrollController();
  late TaskTimer _timer;

  @override
  void initState() {
    super.initState();
    _timer = TaskTimer(
      taskName: 'Scroll Task',
    ); // This works if TaskTimer has constructor with taskName
    _timer.start();

    _scrollController.addListener(() {
      LoggerService.logEvent(
        'Scroll position: ${_scrollController.position.pixels} at ${DateTime.now().toIso8601String()}',
      );
      // Or use LoggerService.log(...) if your service supports it
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer.stopAndLog(); // Use stopAndLog to stop and log duration
    super.dispose();
  }

  void _onTaskComplete() {
    _timer.stopAndLog();
    LoggerService.logEvent('TaskComplete: Scroll Task');
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scroll Task')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 50,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Item ${index + 1}'));
              },
            ),
          ),
          ElevatedButton(onPressed: _onTaskComplete, child: Text('Done')),
        ],
      ),
    );
  }
}
