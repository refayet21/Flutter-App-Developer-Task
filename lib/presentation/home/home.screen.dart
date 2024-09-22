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
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme List',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              onChanged: (value) => controller.searchMeme(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: "Search Memes",
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.h),
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
                    style: TextStyle(color: Colors.red, fontSize: 18.sp),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.searchMemes.length,
                itemBuilder: (context, index) {
                  final meme = controller.searchMemes[index];
                  return Card(
                    elevation: 5,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.put(DetailsController()).setMeme(meme);
                        Get.to(() => DetailsScreen(),
                            transition: Transition.fadeIn);
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Image.network(
                              meme.url,
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Text(
                              meme.name,
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
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
