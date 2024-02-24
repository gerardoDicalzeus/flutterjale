import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project/models/product.dart';
import 'package:project/models/user_credential.dart';

class ApiService {
    static const String baseUrl = "https://polar-plains-89142-ae7bf2bd796a.herokuapp.com/";
    static const String path = "api/auth/local";
    static const String productsPath = 'api/products';

    Future<UserCredential?> signIn({
      required String email,
      required String password,
    }) async {
      try {
      final result = await Dio().post(
        "$baseUrl$path",
        data: {
          "identifier": email,
          "password": password,
        },
      );
      final userCredential = UserCredential.fromJson(result.data);
      return userCredential;
      } catch (e) {
        log(
          e.toString()
        );
        
        return null;
      }
    }

  Future <List<Product>?> getProducts({
        required String token,
  }) async {
    try {

      final Map<String,String> headers = {
        'Authorization' : 'Bearer $token'
      };

      final result = await Dio().get(
        '$baseUrl$productsPath',
        options: Options(
          headers:headers,
        )
      );

      final list = result.data['data'];

      final productResult = productFromJson(list);

      return productResult;
    } catch (e) {
        log(
          e.toString()
        );
        
        return null;
      }
  }


}