import 'package:get/get.dart';
import 'package:hisab_nikas/controller/stock_controller.dart';
import 'package:uuid/uuid.dart';

import '../model/sales_ model.dart';

class SalesController extends GetxController {
  RxList<Sale> sales = <Sale>[].obs;

  void recordSale(String productId, int quantity) {
    final stockController = Get.find<StockController>();
    final product = stockController.products.firstWhere((p) => p.id == productId);

    if (product.quantity >= quantity) {
      final totalPrice = quantity * product.price;
      sales.add(Sale(
        id: Uuid().v4(),
        productName: product.name,
        quantity: quantity,
        totalPrice: totalPrice,
        date: DateTime.now(),
      ));

      stockController.updateStock(productId, -quantity); // স্টক কমাও
    } else {
      Get.snackbar("ভুল", "পর্যাপ্ত স্টক নেই");
    }
  }
}
