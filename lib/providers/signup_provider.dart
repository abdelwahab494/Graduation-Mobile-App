// import 'package:flutter/material.dart';
// import 'package:grad_project/Auth/auth_service.dart';
// import 'package:grad_project/screens/collect_info.dart';
// import 'package:grad_project/screens/signup.dart';

// class SignupProvider extends ChangeNotifier {
//   int _currentIndex = 0;
//   List<Widget> _pages = [Signup(), CollectInfo()];

//   final _usernamecontroller = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   // get auth service
//   final _authService = AuthService();

//   // checkbox value
//   bool _isTermsAccepted = false;

//   int get currentIndex => _currentIndex;
//   List<Widget> get pages => _pages;

//   TextEditingController get usernamecontroller => _usernamecontroller;
//   TextEditingController get emailController => _emailController;
//   TextEditingController get passwordController => _passwordController;
//   TextEditingController get confirmPasswordController =>
//       _confirmPasswordController;

//   get authService => _authService;
//   bool get isTermsAccepted => _isTermsAccepted;

//   void nextPage() {
//     if (_currentIndex < 1) {
//       _currentIndex = _currentIndex + 1;
//     }
//     notifyListeners();
//   }

//   void lastPage() {
//     if (_currentIndex > 0) {
//       _currentIndex = _currentIndex - 1;
//     }
//     notifyListeners();
//   }

//   void add(context, name, email, pass, cPass, onTap) {
//     _usernamecontroller.text = name;
//     _emailController.text = email;
//     _passwordController.text = pass;
//     _confirmPasswordController.text = cPass;
//     onTap;
//     notifyListeners();
//   }

//   void toggleCheck(newValue) {
//     _isTermsAccepted = newValue!;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _usernamecontroller.dispose();
//     super.dispose();
//   }

//   void signup(context) async {
//     // prepare data
//     final email = _emailController.text;
//     final username = _usernamecontroller.text;
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;

//     if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: const Color.fromARGB(220, 255, 17, 0),
//           content: Text(
//             "Error: \nPassword doesn't match! \nPlease try again.",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       );
//       return;
//     }

//     // checkbox approve
//     if (!_isTermsAccepted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: const Color.fromARGB(220, 255, 17, 0),
//           content: Text(
//             "Please accept the Terms and Conditions to proceed.",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       );
//       return;
//     }

//     // attempt sign up
//     try {
//       await authService.signUpWithEmailPassword(email, password, username);
//       // if (mounted) {
//       //   Navigator.pushAndRemoveUntil(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => const AuthGate()),
//       //     (route) => false,
//       //   );
//       // }
//     } catch (e) {
//       // if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text(
//             "Please fill all fields with correct intormations!",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       );
//       // }
//     }
//   }

//   // void signUp(context) async{
//   //   // prepare data
//   //   final email = _emailController.text;
//   //   final username = _usernamecontroller.text;
//   //   final password = _passwordController.text;

//   //   try {
//   //     await authService.signUpWithEmailPassword(email, password, username);
//   //     if (mounted) {
//   //       Navigator.pushAndRemoveUntil(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => const AuthGate()),
//   //         (route) => false,
//   //       );
//   //     }
//   //   } catch (e) {
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           backgroundColor: Colors.red,
//   //           content: Text(
//   //             "Please fill all fields with correct data!",
//   //             style: TextStyle(
//   //               color: Colors.white,
//   //               fontSize: 16,
//   //               fontWeight: FontWeight.w600,
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   }
//   // }
// }
