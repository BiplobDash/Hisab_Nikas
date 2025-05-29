import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/customer_due_controller.dart';

class CustomerDueScreen extends StatelessWidget {
  const CustomerDueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDueController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'কাস্টমার বকেয়া হিসাব',
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
      body: Obx(() => ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: controller.customers.length,
        itemBuilder: (context, index) {
          final c = controller.customers[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                c.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    c.phone,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'বকেয়া: ৳${c.due.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: c.due > 0 ? Colors.red[700] : Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => controller.sendSMS(c.phone, c.due),
                      icon: Icon(Icons.sms, color: Colors.green[700], size: 22),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    SizedBox(width: 4),
                    IconButton(
                      onPressed: () => controller.markAsPaid(index),
                      icon: Icon(Icons.done, color: Colors.blue[700], size: 22),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, controller),
        backgroundColor: theme.primaryColor,
        elevation: 4,
        child: Icon(Icons.add, size: 28),
      ),
    );
  }

  void _showAddDialog(BuildContext context, CustomerDueController controller) {
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
                "নতুন বকেয়া এন্ট্রি",
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
                  labelText: "নাম",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  labelText: "মোবাইল নম্বর",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.amountController,
                decoration: InputDecoration(
                  labelText: "বকেয়া টাকা",
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
                      bool success = controller.addCustomerDue();
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
