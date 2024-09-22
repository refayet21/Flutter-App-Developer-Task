import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/details.controller.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  final DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.meme.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                controller.meme.url,
                height: 200, 
                fit: BoxFit.cover, 
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Width: ${controller.meme.width.toString()} ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Height: ${controller.meme.height}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              'Box Count: ${controller.meme.boxCount.toString()} ',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'Captions: ${controller.meme.captions} ',
              style: TextStyle(fontSize: 16, color: Colors.yellow.shade900),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.cropAndSaveImage(context); // Pass context here
                },
                child: Text('Crop and Save Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
