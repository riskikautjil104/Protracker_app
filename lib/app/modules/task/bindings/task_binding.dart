import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/modules/task/controllers/task_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksController>(
      () => TasksController(),
    );
  }
}
