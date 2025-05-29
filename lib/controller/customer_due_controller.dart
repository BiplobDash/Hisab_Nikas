import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/customer_due_model.dart';


class CustomerDueController extends GetxController {
  RxList<Customer> customers = <Customer>[
    Customer(name: 'রাহুল', phone: '01700000001', due: 250.0),
    Customer(name: 'সুমন', phone: '01700000002', due: 100.0),
  ].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool addCustomerDue() {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final amount = double.tryParse(amountController.text) ?? 0;

    if (name.isEmpty || phone.isEmpty || amount <= 0) {
      Get.snackbar('ত্রুটি', 'সঠিকভাবে সব তথ্য দিন');
      return false;
    }

    customers.add(Customer(name: name, phone: phone, due: amount));
    nameController.clear();
    phoneController.clear();
    amountController.clear();
    return true;
  }

  void sendSMS(String phone, double due) {
    Get.snackbar('SMS পাঠানো হয়েছে', '$phone নম্বরে ৳$due বকেয়া জানানো হয়েছে।');
  }

  void markAsPaid(int index) {
    customers[index].due = 0;
    customers.refresh();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
