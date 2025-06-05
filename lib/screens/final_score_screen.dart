import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/user_data.dart';
import '../services/csv_exporter.dart';
import '../services/logger.dart';

class FinalScoreScreen extends StatefulWidget {
  final UserData userData;
  final VoidCallback onRestart;
  final VoidCallback onExit;

  const FinalScoreScreen({
    Key? key,
    required this.userData,
    required this.onRestart,
    required this.onExit,
  }) : super(key: key);

  @override
  State<FinalScoreScreen> createState() => _FinalScoreScreenState();
}

class _FinalScoreScreenState extends State<FinalScoreScreen> {
  bool _isExporting = false;
  String? _csvFilePath;
  String _exportMessage = '';

  @override
  void initState() {
    super.initState();
    LoggerService.logEvent("Reached Final Score Screen");
  }

  Future<void> _exportCSV() async {
    setState(() {
      _isExporting = true;
      _exportMessage = '';
    });

    final path = await CSVExporter.exportUserLogsToCSV(widget.userData);

    setState(() {
      _isExporting = false;
      if (path != null) {
        _csvFilePath = path;
        _exportMessage = 'CSV exported successfully!';
      } else {
        _exportMessage = 'CSV export failed.';
      }
    });
  }

  void _shareCSV() {
    if (_csvFilePath != null) {
      Share.shareFiles([_csvFilePath!], text: 'User logs from Digital Literacy App');
    } else {
      setState(() {
        _exportMessage = 'Please export CSV first.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.userData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 3 of 3: Summary'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 8,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Center(
                  child: Icon(Icons.check_circle,
                      size: 80, color: Colors.green.shade700),
                );
              case 1:
                return Center(
                  child: Text(
                    'Thank you, ${data.name}!',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                );
              case 2:
                return Center(
                  child: const Text('You have completed all tasks.',
                      style: TextStyle(fontSize: 18)),
                );
              case 3:
                return Text('Age: ${data.age}');
              case 4:
                return Text('Digital Experience: ${data.digitalExperience}');
              case 5:
                return Text('Device Use Frequency: ${data.deviceUseFrequency}');
              case 6:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isExporting ? null : _exportCSV,
                      icon: const Icon(Icons.download),
                      label: Text(_isExporting ? 'Exporting...' : 'Export Logs as CSV'),
                    ),
                    if (_exportMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _exportMessage,
                          style: TextStyle(
                              color: _exportMessage.contains('failed')
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (_csvFilePath != null)
                      ElevatedButton.icon(
                        onPressed: _shareCSV,
                        icon: const Icon(Icons.share),
                        label: const Text('Share CSV'),
                      ),
                  ],
                );
              case 7:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Restart'),
                      onPressed: widget.onRestart,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text('Exit'),
                      onPressed: widget.onExit,
                    ),
                  ],
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
