// import 'package:aq_iot/dashboard.dart';
// import 'package:aq_iot/register.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   String _errorMessage = '';
//   bool _isLoading = false;

//   Future<void> _handleSignIn() async {
//     setState(() {
//       _errorMessage = '';
//       _isLoading = true;
//     });

//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const Dashboard()),
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//         setState(() {
//           _errorMessage = 'Invalid email or password';
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'An error occurred, please try again later';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'An error occurred, please try again later';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _handleRegister() {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (context) => const RegisterPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: SingleChildScrollView(
//           child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               if (_isLoading)
//                 const CircularProgressIndicator()
//               else
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _handleSignIn();
//                     }
//                   },
//                   child: const Text('Login'),
//                 ),
//               const SizedBox(height: 10),
//               if (_errorMessage.isNotEmpty)
//                 Text(
//                   _errorMessage,
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               const SizedBox(height: 10),
//               TextButton(
//                 onPressed: _handleRegister,
//                 child: const Text('Create an account'),
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
