import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_nikas/controller/stock_controller.dart';

class StockScreen extends StatelessWidget {
  StockScreen({super.key});

  final controller = Get.put(StockController());
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();


  void _showAddProductDialog() {
    Get.defaultDialog(
      title: 'নতুন পণ্য যোগ করুন',
      content: Column(
        children: [
          TextField(controller: nameController, decoration: InputDecoration(hintText: 'পণ্যের নাম')),
          TextField(controller: quantityController, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: 'পরিমাণ')),
          TextField(controller: priceController, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: 'দাম')),
        ],
      ),
      textConfirm: "যোগ করুন",
      onConfirm: () {
        final name = nameController.text;
        final quantity = int.tryParse(quantityController.text) ?? 0;
        final price = int.tryParse(priceController.text) ?? 0;
        controller.addProduct(name, quantity, price);
        nameController.clear();
        quantityController.clear();
        priceController.clear();
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
          "পণ্যের স্টক",
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.products.isEmpty) {
          return Center(child: Text("কোনো পণ্য নেই"));
        }
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (_, index) {
            final product = controller.products[index];
            return Card(
              child: ListTile(
                title: Text(product.name),
                subtitle: Text("পরিমাণ: ${product.quantity} | দাম: ${product.price}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => controller.updateStock(product.id, 1),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => controller.updateStock(product.id, -1),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteProduct(product.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
