import 'package:grad_project/database/medicine/medicine.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicineDatabase {
  // Database -> medicines table
  final database = Supabase.instance.client.from("medicines");

  // Create
  Future createMedicine(Medicine newMedicine) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    final medicineWithUserId = Medicine(
      userId: userId,
      name: newMedicine.name,
      dosage: newMedicine.dosage,
      frequency: newMedicine.frequency,
      doseTimes: newMedicine.doseTimes,
      startDate: newMedicine.startDate,
      endDate: newMedicine.endDate,
      mealTiming: newMedicine.mealTiming,
    );
    await database.insert(medicineWithUserId.toMap());
  }

  // Read
  Stream<List<Medicine>> get stream {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    return Supabase.instance.client
        .from("medicines")
        .stream(primaryKey: ["id"])
        .eq('user_id', userId)
        .map(
          (data) =>
              data.map((medicineMap) => Medicine.fromMap(medicineMap)).toList(),
        );
  }

  // Update
  Future updateMedicine(Medicine oldMedicine, Medicine newMedicine) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    await database
        .update(newMedicine.toMap())
        .eq("id", oldMedicine.id!)
        .eq('user_id', userId);
  }

  // Delete
  Future deleteMedicine(Medicine medicine) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');
    await database.delete().eq("id", medicine.id!).eq('user_id', userId);
  }
}
