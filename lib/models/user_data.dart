class UserData {
  String name;
  int age;
  String digitalExperience;
  String deviceUseFrequency;

  // Store results from tasks
  int typingErrors;
  int typingWPM;
  int tapCount;
  int swipeCount;
  int scrollTaskDurationSeconds;

  UserData({
    required this.name,
    required this.age,
    required this.digitalExperience,
    required this.deviceUseFrequency,
    this.typingErrors = 0,
    this.typingWPM = 0,
    this.tapCount = 0,
    this.swipeCount = 0,
    this.scrollTaskDurationSeconds = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'digitalExperience': digitalExperience,
      'deviceUseFrequency': deviceUseFrequency,
      'typingErrors': typingErrors,
      'typingWPM': typingWPM,
      'tapCount': tapCount,
      'swipeCount': swipeCount,
      'scrollTaskDurationSeconds': scrollTaskDurationSeconds,
    };
  }
}
