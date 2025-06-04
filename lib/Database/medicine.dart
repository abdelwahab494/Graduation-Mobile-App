class Medicine {
  int? id;
  String userId;
  String name;
  String dosage;
  int? frequency;
  List<String> doseTimes;
  DateTime? startDate;
  DateTime? endDate;
  String? mealTiming;

  Medicine({
    this.id,
    required this.userId,
    required this.name,
    required this.dosage,
    this.frequency,
    required this.doseTimes,
    this.startDate,
    this.endDate,
    this.mealTiming,
  });

  // Map -> Medicine
  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'] as int?,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      dosage: map['dosage'] as String,
      frequency: map['frequency'] as int?,
      doseTimes: List<String>.from(map['dose_times'] as List),
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date'] as String)
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date'] as String)
          : null,
      mealTiming: map['meal_timing'] as String?,
    );
  }

  // Medicine -> Map
  Map<String, dynamic> toMap() {
    final map = {
      'user_id': userId,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'dose_times': doseTimes,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'meal_timing': mealTiming,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}