import 'package:flutter/material.dart';

class TypingTaskScreen extends StatefulWidget {
  final void Function(int errors, int wpm) onComplete;

  const TypingTaskScreen({Key? key, required this.onComplete}) : super(key: key);

  @override
  State<TypingTaskScreen> createState() => _TypingTaskScreenState();
}

class _TypingTaskScreenState extends State<TypingTaskScreen> {
  final _controller = TextEditingController();
  final String _targetText = "The quick brown fox jumps over the lazy dog";
  int _errors = 0;
  bool _completed = false;

  void _checkTyping() {
    final input = _controller.text.trim();
    int errors = 0;

    final minLen = input.length < _targetText.length ? input.length : _targetText.length;

    for (int i = 0; i < minLen; i++) {
      if (input[i].toLowerCase() != _targetText[i].toLowerCase()) errors++;
    }
    errors += (_targetText.length - input.length).abs();

    setState(() {
      _errors = errors;
      _completed = true;
    });

    // Fake WPM calculation (for example)
    final wpm = (_targetText.split(' ').length * 2) ~/ 1; // 2x words per minute arbitrarily

    widget.onComplete(_errors, wpm);
  }

  void _retry() {
    setState(() {
      _controller.clear();
      _errors = 0;
      _completed = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typing Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Type the following sentence:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(_targetText, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Start typing here...',
              ),
              enabled: !_completed,
            ),
            const SizedBox(height: 16),
            if (!_completed)
              ElevatedButton(
                onPressed: _checkTyping,
                child: const Text('Submit'),
              )
            else ...[
              Text('Errors: $_errors'),
              ElevatedButton(
                onPressed: _retry,
                child: const Text('Retry'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Next Task'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
