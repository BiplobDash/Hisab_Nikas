import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_nikas/controller/stock_controller.dart';

class StockScreen extends StatelessWidget {
  StockScreen({super.key});

  final controller = Get.put(StockController());


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
        onPressed: (){
          _showAddDialog(context, controller);
        },
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

  void _showAddDialog(BuildContext context, StockController controller) {
    final theme = Theme.of(context);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "নতুন পণ্য যোগ করুন",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "পণ্যের নাম",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.quantityController,
                decoration: InputDecoration(
                  labelText: "পরিমাণ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.priceController,
                decoration: InputDecoration(
                  labelText: "দাম",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "বাতিল",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      bool success = controller.addProduct();
                      if (success) {
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("যোগ করুন", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
