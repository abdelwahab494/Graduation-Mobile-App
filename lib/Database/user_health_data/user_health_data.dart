class UserHealthData {
  int? id;
  String userId;
  num highbp;
  num highcol;
  num bmi;
  num stroke;
  num heartattack;
  num physactivity;
  num genhealth;
  num physhealth;
  num diffwalk;
  num age;
  num education;
  num income;
  int predictionStatus;
  String? feedback;
  bool agree;
  DateTime createdAt;

  UserHealthData({
    this.id,
    required this.userId,
    required this.highbp,
    required this.highcol,
    required this.bmi,
    required this.stroke,
    required this.heartattack,
    required this.physactivity,
    required this.genhealth,
    required this.physhealth,
    required this.diffwalk,
    required this.age,
    required this.education,
    required this.income,
    required this.predictionStatus,
    this.feedback,
    required this.agree,
    required this.createdAt,
  });

  // Map -> UserHealthData
  factory UserHealthData.fromMap(Map<String, dynamic> map) {
    return UserHealthData(
      id: map['id'] as int?,
      userId: map['userid'] as String,
      highbp: map['highbp'] as num,
      highcol: map['highcol'] as num,
      bmi: map['bmi'] as num,
      stroke: map['stroke'] as num,
      heartattack: map['heartattack'] as num,
      physactivity: map['physactivity'] as num,
      genhealth: map['genhealth'] as num,
      physhealth: map['physhealth'] as num,
      diffwalk: map['diffwalk'] as num,
      age: map['age'] as num,
      education: map['education'] as num,
      income: map['income'] as num,
      predictionStatus: map['prediction_status'] as int,
      feedback: map['feedback'] as String?,
      agree: map['agree'],
      createdAt: DateTime.parse(map['created_at'] as String), 
    );
  }

  // UserHealthData -> Map
  Map<String, dynamic> toMap() {
    final map = {
      'userid': userId,
      'highbp': highbp,
      'highcol': highcol,
      'bmi': bmi,
      'stroke': stroke,
      'heartattack': heartattack,
      'physactivity': physactivity,
      'genhealth': genhealth,
      'physhealth': physhealth,
      'diffwalk': diffwalk,
      'age': age,
      'education': education,
      'income': income,
      'prediction_status': predictionStatus,
      'feedback': feedback,
      'agree' : agree,
      'created_at': createdAt.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
