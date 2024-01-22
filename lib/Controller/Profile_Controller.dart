import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_chat/Controller/API/Apis.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final nameCtr = TextEditingController();
  final aboutCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final localImage = "".obs;

  changeNameCtr(String val) {
    nameCtr.text = val;
  }

  changeAboutCtr(String val) {
    aboutCtr.text = val;
  }

  changeUrl(String val) {
    localImage.value = val;
  }

  pickGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (image != null) {
      changeUrl(image.path);
      // toast(image.path);
      APIs.uploadProfileImage(File(image.path));
      Nav.pop();
    }
  }

  pickCameraImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (image != null) {
      changeUrl(image.path);
      // toast(image.path);
      APIs.uploadProfileImage(File(image.path));
      Nav.pop();
    }
  }
}
