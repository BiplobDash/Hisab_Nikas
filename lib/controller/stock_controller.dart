import 'package:get/get.dart';
import 'package:hisab_nikas/model/product_model.dart';
import 'package:uuid/uuid.dart';

class StockController extends GetxController {
  RxList<Product> products = <Product>[].obs;

  void addProduct(String name, int quantity, int price) {
    products.add(Product(
      id: Uuid().v4(),
      name: name,
      quantity: quantity,
      price: price,
    ));
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
