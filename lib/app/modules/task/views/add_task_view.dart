import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/data/models/Week.dart';
import 'package:productivity_tracker_app/app/modules/task/controllers/task_controller.dart';

class AddTaskView extends GetView<TasksController> {
  final String idProject;
  AddTaskView({required this.idProject});
  @override
  Widget build(BuildContext context) {
    TasksController controller = Get.put(TasksController());
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Add Task',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Container(
                width: 41,
                height: 41,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(12),
                  // color: Colors.amber,
                  border: Border.all(color: Color(0xFFE8ECF4)),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.createTask(idProject);
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(23),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  TextFormField(
                    controller: controller.taskName,
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() => DropdownButton<Week>(
                        value: controller.selectedWeek.value,
                        items: controller.weeks.map((Week value) {
                          return DropdownMenuItem<Week>(
                              value: value,
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Center(
                                    child: Text(
                                      "Week ${value.week}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey
                                              .shade600), // Ubah ukuran teks sesuai keinginan Anda
                                    ),
                                  )));
                        }).toList(),
                        onChanged: (Week? newValue) {
                          if (newValue != null) {
                            controller.selectedWeek.value = newValue;
                          }
                        },
                      )),
                  SizedBox(height: 20),
                  Obx(() => Text(
                        'Minggu yang Dipilih: ${controller.selectedWeek.value.week}',
                        style: TextStyle(fontSize: 16),
                      )),
                ]),
              ),
            ),
          )),
    );
  }
}
