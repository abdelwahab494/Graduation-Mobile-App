class GlucoseMeasurements {
  int? id;
  String userid;
  DateTime created_at;
  double glucose;
  double voltage;
  bool agree;
  String? feedback;

  GlucoseMeasurements({
    this.id,
    required this.userid,
    required this.created_at,
    required this.glucose,
    required this.voltage,
    required this.agree,
    this.feedback,
  });

  factory GlucoseMeasurements.fromMap(Map<String, dynamic> map) {
    return GlucoseMeasurements(
      id: map['id'] as int?,
      userid: map['userid'] as String,
      created_at: DateTime.parse(map['created_at'] as String),
      glucose: (map['glucose'] as num).toDouble(),
      voltage: (map['voltage'] as num).toDouble(),
      agree: map['agree'] as bool,
      feedback: map['feedback'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'userid': userid,
      'created_at': created_at.toIso8601String(), // يحفظ كـ TIMESTAMP
      'glucose': glucose,
      'voltage': voltage,
      'agree': agree,
      'feedback': feedback,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
