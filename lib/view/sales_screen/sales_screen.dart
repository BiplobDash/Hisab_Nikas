import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sales_controller.dart';
import '../../controller/stock_controller.dart';

class SalesScreen extends StatelessWidget {
  final stockController = Get.put(StockController());
  final salesController = Get.put(SalesController());

  final quantityController = TextEditingController();

  SalesScreen({super.key});

  void _showSaleDialog(String productId, String productName) {
    quantityController.clear();
    Get.defaultDialog(
      title: "বিক্রির পরিমাণ লিখুন",
      content: Column(
        children: [
          Text("পণ্য: $productName"),
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'পরিমাণ'),
          ),
        ],
      ),
      textConfirm: "বিক্রি",
      onConfirm: () {
        final qty = int.tryParse(quantityController.text) ?? 0;
        if (qty > 0) {
          salesController.recordSale(productId, qty);
        }
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "বিক্রির হিসাব",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: Obx(() {
        if (stockController.products.isEmpty) {
          return Center(child: Text("কোনো পণ্য নেই"));
        }
        return ListView.builder(
          itemCount: stockController.products.length,
          itemBuilder: (_, index) {
            final product = stockController.products[index];
            return Card(
              child: ListTile(
                title: Text(product.name),
                subtitle: Text("স্টক: ${product.quantity} | দাম: ${product.price}"),
                trailing: IconButton(
                  icon: Icon(Icons.sell),
                  onPressed: () => _showSaleDialog(product.id, product.name),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
