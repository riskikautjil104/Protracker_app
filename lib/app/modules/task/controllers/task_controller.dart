// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/data/models/Week.dart';
import 'package:productivity_tracker_app/app/data/providers/project_provider.dart';
import 'package:productivity_tracker_app/app/modules/project/views/detail_project.dart';
import 'package:productivity_tracker_app/core/utils/EndPoints.dart';
// import 'package:productivity_tracker_app/app/data/providers/project_provider.dart';
import 'package:sp_util/sp_util.dart';

class TasksController extends GetxController {
  TextEditingController taskName = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getWeek();
  }

  var weeks = <Week>[].obs;
  var selectedWeek = Week(week: 0).obs;

  Future<void> getWeek() async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');
    try {
      final response = await GetConnect()
          .get(EndPoints.baseUrl + 'week-target/$name/get-all-target', query: {
        'projectId': SpUtil.getString('idProject')
      }, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      print(response);

      if (response.status.isOk) {
        // Mendapatkan list objek Week dari data respons JSON
        weeks.value = (response.body['data'] as List<dynamic>)
            .map((weekJson) => Week.fromJson(weekJson))
            .toList();

        // Memastikan bahwa selectedWeek ada di dalam list weeks
        if (!weeks.contains(selectedWeek.value)) {
          selectedWeek.value = weeks.isNotEmpty ? weeks.first : Week(week: 0);
        }
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  void createTask(String idProject) {
    if (taskName.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Task Name cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (selectedWeek.value == 0) {
      Get.snackbar(
        'Failed',
        'Week cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show(status: 'loading...');
      var data = {
        "name": taskName.text,
        "week": selectedWeek.value.week,
      };

      ProjectProvider().createTask(data, idProject).then((value) {
        // final data = jsonDecode(value.body) as Map<String, dynamic>;
        print(value.body);
        if (value.statusCode == 200) {
          Get.snackbar('Successful', value.body['data'],
              backgroundColor: Colors.green.shade500,
              colorText: Colors.white,
              duration: Duration(seconds: 3));
          taskName.clear();

          EasyLoading.dismiss();
          update();
          Get.off(DetailProjectView());
        } else if (value.statusCode == 400) {
          print(value.body['Errors']);
          EasyLoading.dismiss();
          Get.snackbar(
            'Failed',
            value.body['Errors'],
            backgroundColor: Colors.red.shade500,
            colorText: Colors.white,
          );
        }
      });
      print(taskName.text);
      print(selectedWeek.value.week);
    }
    update();
  }
}
