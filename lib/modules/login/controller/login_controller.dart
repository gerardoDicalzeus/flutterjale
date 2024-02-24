import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/models/user_credential.dart';
import 'package:project/modules/home/home_route.dart';
import 'package:project/services/api_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userCredentialBox = GetStorage();

  RxBool isLoading = false.obs;

  UserCredential? get userCredential {
    return userCredentialBox.read<UserCredential>('userCredential');
  }

  Future<void> signIn(BuildContext context) async {
    isLoading.value = true;
    // validar los datos
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      log("email o password no recibidos");
      isLoading = false.obs;
      return;
    }

    // hacer la peticion
    try {
      final UserCredential? userCredential = await ApiService().signIn(
        email:email,
        password:password
      );

      if (userCredential != null) {
        
        // ignore: use_build_context_synchronously
        Get.off(const HomeRoute());
        await userCredentialBox.write('userCredential', userCredential);
      }
    } catch (e,stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      } finally {
        isLoading.value = false;
      }
  }
}