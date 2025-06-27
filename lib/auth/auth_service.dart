import 'package:supabase_flutter/supabase_flutter.dart';

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
  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password,
    String username,
    bool agree,
  ) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data: {"name": username, "agree" : agree},
    );
  }

  // Sign out
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Get user info
  String getCurrentItem(String item) {
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
