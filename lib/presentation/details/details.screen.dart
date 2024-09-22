import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/details.controller.dart';
class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  final DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.meme.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.network(
                        controller.meme.url,
                        width: double.infinity,
                        height: 400.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          onPressed: () {
                            controller.cropAndSaveImage(context);
                          },
                          tooltip: 'Edit Image',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h), 
              
              // Additional meme details section
              Text(
                'Details:',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.straighten, color: Colors.grey, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Width: ${controller.meme.width} px',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.height, color: Colors.grey, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Height: ${controller.meme.height} px',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.view_comfy, color: Colors.grey, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Box Count: ${controller.meme.boxCount}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),

              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.text_fields, color: Colors.grey, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Captions: ${controller.meme.captions}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
