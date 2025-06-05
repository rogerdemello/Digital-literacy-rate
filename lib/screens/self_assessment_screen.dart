import 'package:flutter/material.dart';
import '../models/user_data.dart';

class SelfAssessmentScreen extends StatefulWidget {
  final void Function(UserData data) onComplete;

  const SelfAssessmentScreen({Key? key, required this.onComplete})
      : super(key: key);

  @override
  State<SelfAssessmentScreen> createState() => _SelfAssessmentScreenState();
}

class _SelfAssessmentScreenState extends State<SelfAssessmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _digitalExpController = TextEditingController();
  final _deviceUseController = TextEditingController();

  @override
  void dispose() {
    _digitalExpController.dispose();
    _deviceUseController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final data = UserData(
        name: '', // will be merged upstream
        age: 0,
        digitalExperience: _digitalExpController.text.trim(),
        deviceUseFrequency: _deviceUseController.text.trim(),
      );
      widget.onComplete(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 2 of 3: Self Assessment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return TextFormField(
                  controller: _digitalExpController,
                  decoration: const InputDecoration(
                    labelText: 'Describe your digital experience',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your digital experience';
                    }
                    return null;
                  },
                );
              } else {
                return TextFormField(
                  controller: _deviceUseController,
                  decoration: const InputDecoration(
                    labelText: 'How often do you use digital devices?',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter device use frequency';
                    }
                    return null;
                  },
                );
              }
            },
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemCount: 2,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Next'),
        ),
      ),
    );
  }
}
