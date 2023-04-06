// // ignore_for_file: use_build_context_synchronously, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:saloon_app/data/controller/auth/login_controller.dart';
// import 'package:saloon_app/widgets/custom_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:saloon_app/widgets/custom_textfield.dart';

// class LoginScreen extends StatelessWidget {
//   var emailController = TextEditingController();
//   var passController = TextEditingController();
//   var authController = Get.put(AuthController());

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(113, 120, 128, 1),
//         title: const Text("Login"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//           const SizedBox(
//             height: 60,
//           ),
//           Image.asset(
//             "assets/images/login.png",
//             height: 150,
//             width: 150,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
//             child: CustomOutlineTextField(
//               labelText: "Enter Email",
//               obscureText: false,
//               controller: emailController,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your email';
//                 }
//                 if (!value.contains('@')) {
//                   return 'Please enter a valid email address';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
//             child: CustomOutlineTextField(
//               obscureText: true,
//               labelText: "Enter Passward",
//               controller: passController,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a password';
//                 }
//                 if (value.length < 6) {
//                   return 'Password must be at least 6 characters long';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Obx(() => CustomElevatedButton(
//               buttonText: "Login",
//               loading: authController.loading.value,
//               onPressed: () {
//                 authController.loginUser(
//                     context, emailController.text, passController.text);
//                 // Get.to(() => Dashboard());
//                 // if (Form.of(context).validate()) {
//                 //   loginUser(context, emailController.text, passController.text);
//                 //  }
//               }))
//         ]),
//       ),
//     );
//   }
// }
