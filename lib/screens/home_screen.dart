// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'self_assessment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Literacy Study')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome! This app will help assess your digital literacy through interactive tasks.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelfAssessmentScreen(
                        onComplete: (userData) {
                          // Handle the result and navigate
                          Navigator.pushNamed(context, '/final-score');
                        },
                      ),
                    ),
                  );
                },
                child: Text('Start Self-Assessment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
