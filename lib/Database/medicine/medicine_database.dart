import 'package:grad_project/auth/auth_service.dart';
import 'package:grad_project/database/medicine/medicine.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicineDatabase {
  // Database -> medicines table
  final database = Supabase.instance.client.from("medicines");

  // Create
  Future createMedicine(Medicine newMedicine) async {
    bool isPartner = AuthService().getCurrentItemBool("isPartner");
    Medicine? medicineWithUserId;

    if (!isPartner) {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('No user logged in');
      medicineWithUserId = Medicine(
        userId: userId,
        name: newMedicine.name,
        dosage: newMedicine.dosage,
        frequency: newMedicine.frequency,
        doseTimes: newMedicine.doseTimes,
        startDate: newMedicine.startDate,
        endDate: newMedicine.endDate,
        mealTiming: newMedicine.mealTiming,
      );
    } else {
      final partnerId = AuthService().getCurrentId();
      if (partnerId == null) throw Exception('No user logged in');

      // Fetch patient_id from partners table
      final response =
          await Supabase.instance.client
              .from('partners')
              .select('patient_id')
              .eq('partner_id', partnerId)
              .single();

      if (response.isEmpty) {
        throw Exception('No patient ID found for partner');
      }

      final patientId = response['patient_id'];

      medicineWithUserId = Medicine(
        userId: patientId,
        name: newMedicine.name,
        dosage: newMedicine.dosage,
        frequency: newMedicine.frequency,
        doseTimes: newMedicine.doseTimes,
        startDate: newMedicine.startDate,
        endDate: newMedicine.endDate,
        mealTiming: newMedicine.mealTiming,
      );
    }

    await database.insert(medicineWithUserId.toMap());
  }

  // Read
  Stream<List<Medicine>> get stream {
    final bool isPartner = AuthService().getCurrentItemBool("isPartner");

    if (!isPartner) {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('No user logged in');
      return Supabase.instance.client
          .from("medicines")
          .stream(primaryKey: ["id"])
          .eq('user_id', userId)
          .map((data) {
            return data
                .map((medicineMap) => Medicine.fromMap(medicineMap))
                .toList();
          });
    } else {
      final partnerId = AuthService().getCurrentId();
      if (partnerId == null) throw Exception('No user logged in');

      // Fetch patient_id from partners table
      return Supabase.instance.client
          .from('partners')
          .stream(primaryKey: ['partner_id'])
          .eq('partner_id', partnerId)
          .asyncMap((partnerData) async {
            if (partnerData.isEmpty) {
              throw Exception('No patient ID found for partner');
            }

            final patientId = partnerData.first['patient_id'];

            // Fetch medicines for patient_id
            final medicineData = await Supabase.instance.client
                .from('medicines')
                .select()
                .eq('user_id', patientId);

            return medicineData
                .map((medicineMap) => Medicine.fromMap(medicineMap))
                .toList();
          });
    }
  }

  // Update
  Future updateMedicine(Medicine oldMedicine, Medicine newMedicine) async {
    bool isPartner = AuthService().getCurrentItemBool("isPartner");
    String? userId;

    if (!isPartner) {
      userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('No user logged in');
    } else {
      final partnerId = AuthService().getCurrentId();
      if (partnerId == null) throw Exception('No user logged in');

      // Fetch patient_id from partners table
      final response =
          await Supabase.instance.client
              .from('partners')
              .select('patient_id')
              .eq('partner_id', partnerId)
              .single();

      if (response.isEmpty) {
        throw Exception('No patient ID found for partner');
      }

      userId = response['patient_id'];
    }

    if (userId == null)
      throw Exception(
        'User ID is null',
      ); // Extra check to ensure userId is not null

    await database
        .update(newMedicine.toMap())
        .eq("id", oldMedicine.id!)
        .eq('user_id', userId);
  }

  // Delete
  Future deleteMedicine(Medicine medicine) async {
    bool isPartner = AuthService().getCurrentItemBool("isPartner");
    String? userId;

    if (!isPartner) {
      userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) throw Exception('No user logged in');
    } else {
      final partnerId = AuthService().getCurrentId();
      if (partnerId == null) throw Exception('No user logged in');

      // Fetch patient_id from partners table
      final response =
          await Supabase.instance.client
              .from('partners')
              .select('patient_id')
              .eq('partner_id', partnerId)
              .single();

      if (response.isEmpty) {
        throw Exception('No patient ID found for partner');
      }

      userId = response['patient_id'];
    }

    if (userId == null)
      throw Exception(
        'User ID is null',
      ); // Extra check to ensure userId is not null

    await database.delete().eq("id", medicine.id!).eq('user_id', userId);
  }
}
