import 'dart:io';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class OCRController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  RxString scannedText = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      _performOCR(imageFile.value!);
    }
  }

  Future<void> _performOCR(File file) async {
    final inputImage = InputImage.fromFile(file);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textDetector.processImage(inputImage);
    scannedText.value = recognizedText.text;
    await textDetector.close();
  }

  void clear() {
    imageFile.value = null;
    scannedText.value = '';
  }
}
