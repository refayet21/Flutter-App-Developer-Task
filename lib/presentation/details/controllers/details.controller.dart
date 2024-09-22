import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popularmemes/model/meme.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';



class DetailsController extends GetxController {
  late Meme meme;

  void setMeme(Meme meme) {
    this.meme = meme;
  }

  Future<void> cropAndSaveImage(BuildContext context) async {
    try {
    
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/${meme.name}.jpg';
      final response = await http.get(Uri.parse(meme.url));

    
      final file = File(imagePath);
      await file.writeAsBytes(response.bodyBytes);

     
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path, 
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
       
        final result = await ImageGallerySaverPlus.saveImage(
          await croppedFile.readAsBytes(),
          quality: 60,
          name: 'cropped_${meme.name.replaceAll(" ", "_")}',
        );

        if (result['isSuccess'] == true) {
          Get.snackbar('Success', 'Image saved to gallery!',
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar('Error', 'Failed to save image.',
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Cancelled', 'Image cropping was cancelled.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to process image: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }


}


