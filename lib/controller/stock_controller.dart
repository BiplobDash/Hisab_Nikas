import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hisab_nikas/model/product_model.dart';
import 'package:uuid/uuid.dart';

class StockController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool addProduct() {
    final name = nameController.text;
    final quantity = int.tryParse(quantityController.text) ?? 0;
    final price = int.tryParse(priceController.text) ?? 0;
    if (name.isEmpty || quantity <= 0 || price <= 0) {
      Get.snackbar('ত্রুটি', 'সঠিকভাবে সব তথ্য দিন');
      return false;
    }
    products.add(Product(
      id: Uuid().v4(),
      name: name,
      quantity: quantity,
      price: price,
    ));
    return true;
  }

  void updateStock(String id, int quantityChange) {
    final index = products.indexWhere((p) => p.id == id);
    if (index != -1) {
      products[index].quantity += quantityChange;
      products.refresh();
    }
  }

  void deleteProduct(String id) {
    products.removeWhere((p) => p.id == id);
  }
}
