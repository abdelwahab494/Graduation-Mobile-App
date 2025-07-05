import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/database/user_health_data/user_health_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserHealthDatabase {
  // Database -> user_health_data table
  final database = Supabase.instance.client.from("user_health_data");

  // Create
  Future createUserHealthData(UserHealthData newData) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    final dataWithUserId = UserHealthData(
      userId: userId,
      highbp: newData.highbp,
      highcol: newData.highcol,
      bmi: newData.bmi,
      stroke: newData.stroke,
      heartattack: newData.heartattack,
      physactivity: newData.physactivity,
      genhealth: newData.genhealth,
      physhealth: newData.physhealth,
      diffwalk: newData.diffwalk,
      age: newData.age,
      education: newData.education,
      income: newData.income,
      predictionStatus: newData.predictionStatus,
      feedback: newData.feedback,
      createdAt: newData.createdAt,
      agree: AuthService().getCurrentItemBool("agree"),
    );
    await database.insert(dataWithUserId.toMap());
  }

  // Read - Get latest user health data
  Future<UserHealthData?> getLatestUserHealthData() async {
    final bool isPartner = AuthService().getCurrentItemBool("isPartner");
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');

    String targetUserId = userId;
    if (isPartner) {
      // Fetch patient_id from partners table
      final partnerData =
          await Supabase.instance.client
              .from('partners')
              .select('patient_id')
              .eq('partner_id', userId)
              .single();
      if (partnerData.isEmpty)
        throw Exception('No patient ID found for partner');
      targetUserId = partnerData['patient_id'] as String;
    }

    final response = await database
        .select()
        .eq('userid', targetUserId)
        .order('created_at', ascending: false)
        .limit(1);

    if (response.isNotEmpty) {
      return UserHealthData.fromMap(response.first);
    }
    return null; // Return null if no data found
  }

  // Read - Stream - Ascending
  // Stream<List<UserHealthData>> get stream {
  //   final bool isPartner = AuthService().getCurrentItemBool("isPartner");

  //   if (!isPartner) {
  //     final userId = Supabase.instance.client.auth.currentUser?.id;
  //     if (userId == null) throw Exception('No user logged in');
  //     return Supabase.instance.client
  //         .from("user_health_data")
  //         .stream(primaryKey: ["id"])
  //         .eq('userid', userId)
  //         .map((data) {
  //           return data
  //               .map((dataMap) => UserHealthData.fromMap(dataMap))
  //               .toList();
  //         });
  //   } else {
  //     final partnerId = AuthService().getCurrentId();
  //     if (partnerId == null) throw Exception('No user logged in');

  //     return Supabase.instance.client
  //         .from('partners')
  //         .stream(primaryKey: ['partner_id'])
  //         .eq('partner_id', partnerId)
  //         .asyncMap((partnerData) async {
  //           if (partnerData.isEmpty) {
  //             throw Exception('No patient ID found for partner');
  //           }

  //           final patientId = partnerData.first['patient_id'];

  //           final healthData = await Supabase.instance.client
  //               .from('user_health_data')
  //               .select()
  //               .eq('userid', patientId);

  //           return healthData
  //               .map((dataMap) => UserHealthData.fromMap(dataMap))
  //               .toList();
  //         });
  //   }
  // }

  // Read - Stream - Descending
  Stream<List<UserHealthData>> get stream {
    final bool isPartner = AuthService().getCurrentItemBool("isPartner");

    if (!isPartner) {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('No user logged in');
      return Supabase.instance.client
          .from("user_health_data")
          .stream(primaryKey: ["id"])
          .eq('userid', userId)
          .order('created_at', ascending: false)
          .map((data) {
            return data
                .map((dataMap) => UserHealthData.fromMap(dataMap))
                .toList();
          });
    } else {
      final partnerId = AuthService().getCurrentId();
      if (partnerId == null) throw Exception('No user logged in');

      return Supabase.instance.client
          .from('partners')
          .stream(primaryKey: ['partner_id'])
          .eq('partner_id', partnerId)
          .asyncMap((partnerData) async {
            if (partnerData.isEmpty) {
              throw Exception('No patient ID found for partner');
            }

            final patientId = partnerData.first['patient_id'];

            final healthData = await Supabase.instance.client
                .from('user_health_data')
                .select()
                .eq('userid', patientId)
                .order('created_at', ascending: false);

            return healthData
                .map((dataMap) => UserHealthData.fromMap(dataMap))
                .toList();
          });
    }
  }

  // Update
  Future updateUserHealthData(
    UserHealthData oldData,
    UserHealthData newData,
  ) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    await database
        .update(newData.toMap())
        .eq("id", oldData.id!)
        .eq('userid', userId);
  }

  // Delete
  Future deleteUserHealthData(UserHealthData data) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    await database.delete().eq("id", data.id!).eq('userid', userId);
  }
}
