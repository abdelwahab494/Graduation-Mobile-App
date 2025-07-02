import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password
  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    String username,
    bool agree,
    bool isPartner,
    String patientID,
  ) async {
    try {
      // Sign up the user
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': username,
          'agree': agree,
          'isPartner': isPartner,
          'patientID': patientID,
        },
      );

      final user = response.user;
      if (user == null) {
        throw Exception('Failed to create user');
      }

      // If the user is a partner, add entry to the partners table
      if (isPartner) {
        if (patientID.isEmpty) {
          throw Exception('Patient ID is required for partner accounts');
        }

        // Validate patientID as UUID
        try {
          Uuid.parse(patientID);
        } catch (e) {
          throw Exception('Invalid Patient ID format: $patientID');
        }

        // Insert into partners table
        await Supabase.instance.client.from('partners').insert({
          'partner_id': user.id,
          'patient_id': patientID,
        });
      }
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Get user info
  String getCurrentItemString(String item) {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata?[item];
  }

  bool getCurrentItemBool(String item) {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata?[item];
  }

  // Get user id
  String? getCurrentId() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

  // Get user Email
  String? getCurrentEmail() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
