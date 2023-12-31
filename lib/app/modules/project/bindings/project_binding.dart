import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/modules/project/controllers/project2_controller.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Project2Controller>(
      () => Project2Controller(),
    );
  }
}
