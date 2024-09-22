import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:popularmemes/presentation/details/controllers/details.controller.dart';
import 'package:popularmemes/presentation/details/details.screen.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
 const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.searchMeme(value),
              decoration: InputDecoration(
                hintText: "Search Memes",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(
                    'Error: ${controller.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.searchMemes.length,
                itemBuilder: (context, index) {
                  final meme = controller.searchMemes[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.network(meme.url, width: 50.w, height: 50.h),
                      title: Text(meme.name),
                      onTap: () {
                        Get.put(DetailsController()).setMeme(meme);
                        Get.to(() => DetailsScreen(),
                            transition: Transition.fadeIn);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
