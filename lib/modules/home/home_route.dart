import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/models/product.dart';
import 'package:project/modules/home/controller/home_controller.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: FutureBuilder(
        future: controller.getProducts(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No hay datos rey'),);
          }

          final List<Product> productList = snapshot.data!;


          return GridView.builder(
            itemCount: productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
              ),
              itemBuilder: (context, index) { 
                log('index $index');
                final Product product = productList[index];
                return Column(
                  children: [
                    Image.network(
                      product.attributes.imageUrl,
                      height:80,
                      width: 80,
                    ),
                    Text(product.attributes.name)
                  ],
                );
            }
          );
        }
      )
    );
  }
}