// import 'package:aq_iot/login.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   String _errorMessage = '';
//   bool _isLoading = false;

//   Future<void> onRegister() async {
//     setState(() {
//       _errorMessage = '';
//       _isLoading = true;
//     });

//     try {
//       final userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       // Register user in database or perform any other actions here
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = 'The password provided is too weak.';
//         });
//       } else if (e.code == 'email-already-in-use') {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = 'The account already exists for that email.';
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = 'An undefined error happened.';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = 'An undefined error happened.';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   hintText: 'Enter your email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   hintText: 'Enter your password',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 32.0),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       onRegister();
//                     }
//                   },
//                   child: const Text('Register'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
