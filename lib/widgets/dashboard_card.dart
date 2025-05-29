import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_nikas/view/customer_due_screen/customer_due_screen.dart';
import 'package:hisab_nikas/view/ocr_screen/ocr_screen.dart';
import 'package:hisab_nikas/view/stock_screen/stock_screen.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const DashboardCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.green.shade50,
      child: InkWell(
        onTap: () {
          if (title == 'বাকির হিসাব') {
            Get.to(() => CustomerDueScreen());
          }
          if (title == 'হিসাব স্ক্যান') {
            Get.to(() => OCRScreen());
          }
          if (title == 'স্টক') {
            Get.to(() => StockScreen());
          }
        }, // Screen navigation later
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36, color: Colors.green.shade800),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
