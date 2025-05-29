import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/ocr_controller.dart';

class OCRScreen extends StatelessWidget {

  const OCRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(OCRController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'হিসাব স্ক্যান করুন',
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
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => controller.pickImage(ImageSource.camera),
                    icon: Icon(Icons.camera),
                    label: Text("ক্যামেরা"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => controller.pickImage(ImageSource.gallery),
                    icon: Icon(Icons.photo_library),
                    label: Text("গ্যালারি"),
                  ),
                  IconButton(
                    onPressed: controller.clear,
                    icon: Icon(Icons.clear, color: Colors.red),
                  )
                ],
              ),
              SizedBox(height: 10),
              controller.imageFile.value != null
                  ? Image.file(controller.imageFile.value!, height: 200)
                  : Text("কোনো ছবি নির্বাচন করা হয়নি"),
              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    controller.scannedText.value.isNotEmpty
                        ? controller.scannedText.value
                        : "স্ক্যান করা টেক্সট এখানে দেখাবে",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (controller.scannedText.value.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: () {
                    // এখানে হিসাব ডাটাবেজে সেভ করা যেতে পারে
                    Get.snackbar("সাফল্য", "স্ক্যানকৃত হিসাব সেভ করা হয়েছে!");
                  },
                  icon: Icon(Icons.save),
                  label: Text("হিসাবে যোগ করুন"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
            ],
          ),
        );
      }),
    );
  }
}
