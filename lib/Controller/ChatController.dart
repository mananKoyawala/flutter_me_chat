import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_chat/Controller/API/Apis.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:image_picker/image_picker.dart';

import '../models/ChatUserModel.dart';

class ChatController extends GetxController {
  final chatTextCtr = TextEditingController();
  var showEmoji = false.obs;
  final localImage = "".obs;
  var isUploading = false.obs;

  changeShowEmoji() {
    showEmoji.toggle();
  }

  changeUrl(String val) {
    localImage.value = val;
  }

  pickGalleryImage(ChatUser user) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final List<XFile> images = await picker.pickMultiImage(imageQuality: 70);
    isUploading.value = true;
    for (var i in images) {
      changeUrl(i.path);
      await APIs.sendChatImage(user, File(i.path));
    }
    isUploading.value = false;
  }

  pickCameraImage(ChatUser user) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);

    if (image != null) {
      changeUrl(image.path);
      // toast(image.path);
      await APIs.sendChatImage(user, File(image.path));
    }
  }
}
