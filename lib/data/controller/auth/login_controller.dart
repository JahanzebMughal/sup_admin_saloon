// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/views/dashboard.dart';
import 'package:saloon_app/views/login/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool loading = false.obs;

  // Future<UserCredential?> signIn(String email, String password) async {
  //   loading.value = true; // set loading flag to true
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       Get.snackbar('Error', 'No user found for that email');
  //     } else if (e.code == 'wrong-password') {
  //       Get.snackbar('Error', 'Wrong password provided for that user');
  //     }
  //     return null;
  //   } finally {
  //     loading.value = false; // set loading flag back to false
  //   }
  // }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    loading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Login Successful'),
        ),
      );
      // Navigate to the next screen
      Get.to(Dashboard());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('No user found for that email'),
          ),
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Wrong password provided for that user.'),
          ),
        );
        print('Wrong password provided for that user.');
      }
    } finally {
      loading.value = false; // set loading flag back to false
    }
  }

  Future<UserCredential?> signUp(String email, String password) async {
    loading.value = true; // set loading flag to true
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    } finally {
      loading.value = false; // set loading flag back to false
    }
  }

  void signOut() async {
    await _auth.signOut();
    Get.offAll(() => LoginScreen());
  }
}
