import 'package:flutter/material.dart';
import 'screens/task_form.dart';
import 'screens/self_assessment_screen.dart';
import 'screens/final_score_screen.dart';
import 'models/user_data.dart';

void main() {
  runApp(const DigitalLiteracyApp());
}

class DigitalLiteracyApp extends StatelessWidget {
  const DigitalLiteracyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Literacy App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const FlowController(),
    );
  }
}

class FlowController extends StatefulWidget {
  const FlowController({super.key});

  @override
  State<FlowController> createState() => _FlowControllerState();
}

class _FlowControllerState extends State<FlowController> {
  int _step = 0;
  UserData? _userData;

  void _goToNextStep(UserData? data) {
    setState(() {
      if (data != null) _userData = data;
      _step++;
    });
  }

  void _restartApp() {
    setState(() {
      _userData = null;
      _step = 0;
    });
  }

  void _exitApp() {
    // Use SystemNavigator.pop or similar in real app, or just Navigator.pop
    Navigator.of(context).maybePop();
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return TaskFormScreen(
          onComplete: (name, age) {
            // Initialize with name and age, pass partial UserData
            _goToNextStep(UserData(
              name: name,
              age: age,
              digitalExperience: '',
              deviceUseFrequency: '',
            ));
          },
        );
      case 1:
        return SelfAssessmentScreen(
          onComplete: (data) {
            // Merge previous data with assessment data
            if (_userData != null) {
              _userData = UserData(
                name: _userData!.name,
                age: _userData!.age,
                digitalExperience: data.digitalExperience,
                deviceUseFrequency: data.deviceUseFrequency,
              );
            } else {
              _userData = data;
            }
            _goToNextStep(_userData);
          },
        );
      case 2:
        return FinalScoreScreen(
          userData: _userData!,
          onRestart: _restartApp,
          onExit: _exitApp,
        );
      default:
        return Center(child: Text('Unknown Step'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _buildStep(),
    );
  }
}
