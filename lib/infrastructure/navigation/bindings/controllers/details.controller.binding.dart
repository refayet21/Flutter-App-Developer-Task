import 'package:get/get.dart';

import '../../../../presentation/details/controllers/details.controller.dart';

class DetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(
      () => DetailsController(),
    );
  }
}
