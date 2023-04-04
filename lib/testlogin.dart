import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saloon_app/widgets/mybutton.dart';
import 'package:saloon_app/widgets/mytextfield.dart';

import 'data/controller/auth/login_controller.dart';

class LoginBodyScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var authController = Get.put(AuthController());
  LoginBodyScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  final String _errorMessage = "";
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SizedBox(
              height: h * 100,
              child: Image.asset('assets/loginbg.png', fit: BoxFit.fitHeight),
            ),
            Transform.translate(
              offset: Offset(20 * w, 30),
              child: Image.asset(
                'assets/Logo.png',
                scale: 1.5,
                width: w * 60,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 64 * h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor("#ffffff"),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log In",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#4f4f4f"),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            emailController.text = 'zebi.biit@gmail.com';
                            passwordController.text = 'test1234';
                          },
                          child: const Text('AutoFill')),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyTextField(
                                onChanged: (() {}),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }

                                  return null;
                                },
                                controller: emailController,
                                hintText: "hello@gmail.com",
                                obscureText: false,
                                prefixIcon: const Icon(Icons.mail_outline),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  _errorMessage,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Password",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: HexColor("#8d8d8d"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(() => MyTextField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field is required';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters long';
                                      }
                                      return null;
                                    },
                                    hintText: "*******",
                                    obscureText:
                                        authController.passvisible.value
                                            ? false
                                            : true,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          authController.passvisible.value =
                                              !authController.passvisible.value;
                                        },
                                        icon: Icon(authController
                                                .passvisible.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined)),
                                    prefixIcon: const Icon(Icons.lock_outline),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => MyButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      authController.loginUser(
                                          context,
                                          emailController.text,
                                          passwordController.text);
                                    }
                                  },
                                  loading: authController.loading.value,
                                  buttonText: 'Submit',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
