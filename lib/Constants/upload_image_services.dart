import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

class PickImageService {
  final images = Rxn<XFile>();

  //Return Type XFile
  Future<XFile> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.value = XFile(pickedFile.path);
      if (images != null) {
        return XFile(pickedFile.path);
      } else {
        return XFile(pickedFile.path);
      }
    }
    return XFile(pickedFile!.path);
  }

  //Return Type File
  Future<File> pickfileImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.value = XFile(pickedFile.path);
      if (images != null) {
        return File(pickedFile.path);
      } else {
        return File(pickedFile.path);
      }
    }
    return File(pickedFile!.path);
  }
}
