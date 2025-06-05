
// lib/screens/task_tap_swipe.dart
import 'package:flutter/material.dart';
import '../services/logger.dart';
import '../utils/task_timer.dart';

class TaskTapSwipeScreen extends StatefulWidget {
  final int selfAssessmentScore;

  const TaskTapSwipeScreen({super.key, required this.selfAssessmentScore});

  @override
  State<TaskTapSwipeScreen> createState() => _TaskTapSwipeScreenState();
}

class _TaskTapSwipeScreenState extends State<TaskTapSwipeScreen> {
  final TaskTimer _timer = TaskTimer();
  int _tapCount = 0;
  int _swipeCount = 0;

  @override
  void initState() {
    super.initState();
    _timer.start();
  }

  void _onTap() {
    setState(() {
      _tapCount++;
    });
    LoggerService.logEvent('Tap detected');
  }

  void _onSwipe(String direction) {
    setState(() {
      _swipeCount++;
    });
    LoggerService.logEvent('Swipe $direction');
  }

  void _finishTask() {
    _timer.stop();
    LoggerService.logEvent(
      'TaskTapSwipe completed in ${_timer.duration.inSeconds} seconds with $_tapCount taps and $_swipeCount swipes',
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap & Swipe Task')),
      body: GestureDetector(
        onTap: _onTap,
        onHorizontalDragEnd: (_) => _onSwipe('horizontal'),
        onVerticalDragEnd: (_) => _onSwipe('vertical'),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Taps: $_tapCount'),
              Text('Swipes: $_swipeCount'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _finishTask,
                child: const Text('Finish Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
