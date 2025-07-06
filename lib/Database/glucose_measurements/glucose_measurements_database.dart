import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GlucoseMeasurementsDatabase {
  // Database -> glucose_measurements table
  final database = Supabase.instance.client.from("glucose_measurements");

  // Create
  Future createUserHealthData(GlucoseMeasurements newData) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    final dataWithUserId = GlucoseMeasurements(
      userid: userId,
      created_at: newData.created_at,
      glucose: newData.glucose,
      voltage: newData.voltage,
      agree: AuthService().getCurrentItemBool("agree"),
      feedback: newData.feedback,
    );
    await database.insert(dataWithUserId.toMap());
  }

  // Read - Get latest user health data
  Future<GlucoseMeasurements?> getLatestUserHealthData() async {
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
      return GlucoseMeasurements.fromMap(response.first);
    }
    return null; // Return null if no data found
  }

  // Read - Stream - Descending
  Stream<List<GlucoseMeasurements>> get stream {
    final bool isPartner = AuthService().getCurrentItemBool("isPartner");

    if (!isPartner) {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('No user logged in');
      return Supabase.instance.client
          .from("glucose_measurements")
          .stream(primaryKey: ["userid", "created_at"])
          .eq('userid', userId)
          .order('created_at', ascending: false)
          .map((data) {
            return data
                .map((dataMap) => GlucoseMeasurements.fromMap(dataMap))
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
                .from('glucose_measurements')
                .select()
                .eq('userid', patientId)
                .order('created_at', ascending: false);

            return healthData
                .map((dataMap) => GlucoseMeasurements.fromMap(dataMap))
                .toList();
          });
    }
  }

  // Update
  Future updateUserHealthData(
    GlucoseMeasurements oldData,
    GlucoseMeasurements newData,
  ) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    await database
        .update(newData.toMap())
        .eq("id", oldData.id!)
        .eq('userid', userId);
  }

  // Delete
  Future deleteUserHealthData(GlucoseMeasurements data) async {
    try {
      final bool isPartner = AuthService().getCurrentItemBool("isPartner");
      String? userId;

      if (!isPartner) {
        userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId == null) throw Exception('No user logged in');
      } else {
        final partnerId = AuthService().getCurrentId();
        if (partnerId == null) throw Exception('No user logged in');

        print('partnerId: $partnerId');

        final response =
            await Supabase.instance.client
                .from('partners')
                .select('patient_id')
                .eq('partner_id', partnerId)
                .single();

        print('partners response: $response'); 

        if (response.isEmpty) {
          throw Exception('No patient ID found for partner');
        }

        userId = response['patient_id'] as String;
      }

      await database
          .delete()
          .eq('userid', userId)
          .eq('created_at', data.created_at.toIso8601String());
    } catch (e) {
      throw Exception('Failed to delete health data: $e');
    }
  }

  // Get number of readings for the last 7 days
  Future<int> getReadingsCountLast7Days() async {
    try {
      final bool isPartner = AuthService().getCurrentItemBool("isPartner");
      String? userId;

      print('isPartner: $isPartner');

      if (!isPartner) {
        userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId == null) throw Exception('No user logged in');
      } else {
        final partnerId = AuthService().getCurrentId();
        if (partnerId == null) throw Exception('No user logged in');

        print('partnerId: $partnerId');

        final response =
            await Supabase.instance.client
                .from('partners')
                .select('patient_id')
                .eq('partner_id', partnerId)
                .single();

        print('partners response: $response');

        if (response.isEmpty) {
          throw Exception('No patient ID found for partner');
        }

        userId = response['patient_id'] as String;
      }

      final startDate = DateTime.now().subtract(Duration(days: 7));
      final response =
          await database
              .select()
              .eq('userid', userId)
              .gte('created_at', startDate.toIso8601String())
              .count();

      return response.count;
    } catch (e) {
      throw Exception('Failed to fetch readings count: $e');
    }
  }

  // Get average glucose for the last 7 days
  Future<double> getAverageGlucoseLast7Days() async {
    final bool isPartner = AuthService().getCurrentItemBool("isPartner");
    String? userId;

    if (!isPartner) {
      userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('No user logged in');
    } else {
      final partnerId = AuthService().getCurrentId();
      if (partnerId == null) throw Exception('No user logged in');

      final response =
          await Supabase.instance.client
              .from('partners')
              .select('patient_id')
              .eq('partner_id', partnerId)
              .single();

      if (response.isEmpty) {
        throw Exception('No patient ID found for partner');
      }

      userId = response['patient_id'] as String;
    }

    final startDate = DateTime.now().subtract(Duration(days: 7));
    final response = await database
        .select('glucose')
        .eq('userid', userId)
        .gte('created_at', startDate.toIso8601String());

    if (response.isEmpty) {
      return 0.0;
    }

    final total = response
        .map((row) => (row['glucose'] as num).toDouble())
        .fold(0.0, (sum, value) => sum + value);
    return total / response.length;
  }
}
