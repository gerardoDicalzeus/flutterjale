import 'dart:developer';

import 'package:get/get.dart';
import 'package:project/models/product.dart';
import 'package:project/modules/login/controller/login_controller.dart';
import 'package:project/services/api_service.dart';

class HomeController extends GetxController {
  

  final apiService = ApiService();
  final LoginController loginController = Get.find<LoginController>();

  Future<List<Product>?> getProducts() async {
    final token = loginController.userCredential?.jwt;
  try{ 

    if( token == null ) {
      throw Exception('El usuario no esta autenticado');
    }
    return await apiService.getProducts(token: token);
  } catch(e) {
    log(e.toString());
    return null;
  }
}


}