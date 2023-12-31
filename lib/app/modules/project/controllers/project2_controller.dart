// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
// import 'package:productivity_tracker_app_fix/app/data/models/home_model.dart';
import 'package:productivity_tracker_app/app/data/models/target.dart';
import 'package:productivity_tracker_app/app/data/models/tasks.dart';
import 'package:productivity_tracker_app/app/data/models/detail_project.dart';
import 'package:productivity_tracker_app/app/data/models/projects_model.dart';
import 'package:productivity_tracker_app/app/data/models/team.dart';
// import 'package:productivity_tracker_app/app/data/providers/project_api_random.dart';
import 'package:productivity_tracker_app/app/data/providers/project_provider.dart';
import 'package:intl/intl.dart';
import 'package:productivity_tracker_app/app/modules/home/models/project1.dart';
// import 'package:productivity_tracker_app/app/modules/home/models/project1.dart';
import 'package:productivity_tracker_app/app/modules/home/views/home_view.dart';
import 'package:productivity_tracker_app/app/modules/project/views/detail_project.dart';
// import 'package:productivity_tracker_app/app/modules/project/views/projects2_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sp_util/sp_util.dart';
// import 'package:sp_util/sp_util.dart';
// import 'package:productivity_tracker_app/app/data/providers/project_provider.dart';
// import 'package:sp_util/sp_util.dart';

// import '../../../data/providers/home_provider.dart';
import '../../../data/providers/project_api_random.dart';

class Project2Controller extends GetxController {
  TextEditingController projectName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController emails = TextEditingController();
  // target
  TextEditingController targetTask = TextEditingController();
  TextEditingController label = TextEditingController();
  TextEditingController week = TextEditingController();

  final ProjectProvider _apiService = ProjectProvider();
  final project = Project(code: 0, data: []).obs;
  final task = <Tasks>[].obs;
  var detailProject = DetailProject(
      code: 0,
      data: DetailProjectData(
        id: '',
        name: '',
        description: '',
        pmName: '',
        createdAt: DateTime.now(),
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: false,
      )).obs;
  RxBool isLoading = true.obs;
  RxInt tabIndex = 0.obs;
  RxBool isRefreshing = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataFromApi();
    // update();
  }

  Future fetchDataFromApi() async {
    print(SpUtil.getString('jwtToken'));
    try {
      final data = await _apiService.fetchData();
      project.value = data;

      // print(project.value.data);
      if (data.data.length == 0) {
        print('data kosong');
      } else {
        print('data ada');
      }
      isLoading = false.obs;
      print(isLoading);
    } catch (e) {
      // Handle error
      print(e.toString());
    } finally {
      isLoading = false.obs;
    }
    // print(isLoading);
  }

//  task

  void taskToggleStatus(var id) {
    // EasyLoading.show(status: 'loading...');
    // Future.delayed(Duration(milliseconds: 5000));
    print("Id Task" + id);
    ProjectProvider().changeStatusTask(id);
    Get.back();
    Get.snackbar('Successful', 'Task status successfully changed',
        backgroundColor: Colors.green.shade500,
        colorText: Colors.white,
        duration: Duration(seconds: 3));
    // Get.off(DetailProjectView());
    update();
    // EasyLoading.dismiss();
  }

// add project
  var selectedEndDate = ''.obs;
  var selectedStartDate = ''.obs;

  void pickStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2121),
    );

    if (pickedDate != null) {
      selectedStartDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void pickEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2121),
    );

    if (pickedDate != null) {
      selectedEndDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  // void post() {
  //   // List<String> removeSpace = emails.text.split(' ');
  //   // print('Slicing by space: $splittedBySpace');
  // List<String> x = emails.text.split(RegExp(r'\s|,'));
  //   // Memotong string berdasarkan koma
  //   // List<String> removeKoma = emails.text.split(',');
  //   // var s = removeSpace;
  //   // var s = removeKoma;
  //   // print('Slicing by comma: $splittedByComma');
  //   // print(s);
  //   // print(selectedStartDate.value);
  //   // print(selectedEndDate.value);
  // }

  // create project
  void post() {
    if (projectName.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Project name cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (emails.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Emails cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (selectedStartDate.value.isEmpty) {
      Get.snackbar(
        'Failed',
        'Start Date cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (selectedEndDate.value.isEmpty) {
      Get.snackbar(
        'Failed',
        'End Date cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show(status: 'loading...');
      List<String> listEmail = emails.text.split(RegExp(r'\s|,'));
      var data = {
        "name": projectName.text,
        "description": description.text,
        "startDate": selectedStartDate.value,
        "endDate": selectedEndDate.value,
        "emails": listEmail,
      };

      ProjectProvider().createProject(data).then((value) {
        // final data = jsonDecode(value.body) as Map<String, dynamic>;
        print(value.body);
        if (value.statusCode == 200) {
          Get.snackbar('Successful', value.body['data'],
              backgroundColor: Colors.green.shade500,
              colorText: Colors.white,
              duration: Duration(seconds: 3));
          projectName.clear();
          emails.clear();
          description.clear();
          selectedStartDate.value = '';
          selectedEndDate.value = '';
          EasyLoading.dismiss();
          update();
          // (SpUtil.getString('userType') == 'Crew')
          //     ? Get.offAll(HomeViewCrew())
          //     : Get.offAll(HomePm());
          Get.offAll(HomeView());
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
      // EasyLoading.dismiss();
    }
    update();
  }

  // create project
  void createTarget(var projectId, var nameCrew) {
    if (targetTask.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Target cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (label.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Label cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (selectedStartDate.value.isEmpty) {
      Get.snackbar(
        'Failed',
        'Start Date cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (selectedEndDate.value.isEmpty) {
    } else if (week.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Start Date cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (selectedEndDate.value.isEmpty) {
      Get.snackbar(
        'Failed',
        'End Date cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show(status: 'loading...');
      var data = {
        "week": week.text,
        "labels": label.text,
        "startDate": selectedStartDate.value,
        "endDate": selectedEndDate.value,
        "target": targetTask.text,
      };

      ProjectProvider().createTarget(data, projectId, nameCrew).then((value) {
        // final data = jsonDecode(value.body) as Map<String, dynamic>;
        print(value.body);
        if (value.statusCode == 200) {
          Get.snackbar('Successful', value.body['data'],
              backgroundColor: Colors.green.shade500,
              colorText: Colors.white,
              duration: Duration(seconds: 3));
          week.clear();
          targetTask.clear();
          label.clear();
          selectedStartDate.value = '';
          selectedEndDate.value = '';
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
        } else {
          EasyLoading.dismiss();
          Get.snackbar(
            'Failed',
            'Something Wrong',
            backgroundColor: Colors.red.shade500,
            colorText: Colors.white,
          );
        }
      });
      // EasyLoading.dismiss();
    }
    update();
  }

  void updateProject(var id) {
    print(id);
    if (projectName.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Project name cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (emails.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Emails cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (selectedStartDate.value.isEmpty) {
      Get.snackbar(
        'Failed',
        'Start Date cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (selectedEndDate.value.isEmpty) {
      Get.snackbar(
        'Failed',
        'End Date cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show(status: 'loading...');
      List<String> listEmail = emails.text.split(RegExp(r'\s|,'));
      var data = {
        "name": projectName.text,
        "description": description.text,
        "startDate": selectedStartDate.value,
        "endDate": selectedEndDate.value,
        "emails": listEmail,
      };

      ProjectProvider().updateProject(data, id).then((value) {
        // final data = jsonDecode(value.body) as Map<String, dynamic>;
        print(value.body);
        if (value.statusCode == 200) {
          Get.snackbar('Successful', value.body['data'],
              backgroundColor: Colors.green.shade500,
              colorText: Colors.white,
              duration: Duration(seconds: 3));
          projectName.clear();
          emails.clear();
          description.clear();
          selectedStartDate.value = '';
          selectedEndDate.value = '';
          EasyLoading.dismiss();
          update();
          // (SpUtil.getString('userType') == 'Crew')
          //     ? Get.offAll(HomeViewCrew())
          //     : Get.offAll(HomePm());
          Get.offAll(HomeView());
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
      // EasyLoading.dismiss();
    }
    update();
  }

// // tasks
  Future<List<Tasks>> getAllPmTasks(var id) async {
    print("id :" + id);
    try {
      var data = await _apiService.getPmTasks(id);
      // print(data);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

// get crew tasks
  Future<List<Tasks>> getAllCrewTasks(var id) async {
    print("id :" + id);
    try {
      var data = await _apiService.getCrewTasks(id);
      // print(data);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

// get team project
  Future<List<Team>> getAllTeamProject(var id) async {
    try {
      var data = await _apiService.getTeamProject(id);
      print(data);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

// get team project
  Future<List<Target>> getAllCrewTarget(var id, var name) async {
    try {
      var data = await _apiService.getTargetCrew(id, name);
      print(data);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  // detail projects
  void fetchDetailProjectData(var id) {
    print(id);
    SpUtil.putString('idProject', id);
    print(SpUtil.getString('jwtToken'));
    EasyLoading.show(status: 'loading...');
    ProjectProvider().detailProject(id).then((value) {
      if (value.code == 200) {
        var data = {
          "code": 200,
          "data": {
            "id": value.data.id,
            "name": value.data.name,
            "description": value.data.description,
            "pmName": value.data.pmName,
            "createdAt": DateFormat('yyyy-MM-dd').format(value.data.createdAt),
            "startDate": DateFormat('yyyy-MM-dd').format(value.data.startDate),
            "endDate": DateFormat('yyyy-MM-dd').format(value.data.endDate),
            "status": value.data.status
          }
        };

        // print(data);
        DetailProject projectData = DetailProject.fromJson(data);
        // getAllTasks(projectData.data.id);
        // print(projectData.data.id);
        detailProject.value = projectData;
        // ProjectProvider().getTasks(id);
        Get.to(DetailProjectView());
        EasyLoading.dismiss();
      }
    });

    // Method ini seharusnya mengambil data dari API (misalnya dengan http.get) dan mengatur nilai project
    // Di sini kita hanya membuat contoh data untuk simulasi
  }

  // hapus project
  void deleteProject(var id) {
    EasyLoading.show(status: 'loading...');
    ProjectProvider().deleteProject(id);
    // arahkan ke halaman project saja
    Get.offAll(HomeView());
    EasyLoading.dismiss();
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ApiServices apiService = ApiServices();
  final RxList<Project1> projects = <Project1>[].obs;

  Future<List<Project1>> loadData() async {
    List<Project1> data = await apiService.fetchData1();
    projects.assignAll(data);
    refreshController.refreshCompleted();
    return data;
  }

  //
}

// {
//   "name": "Create Project 3",
//   "description": "Tes Create Project 3",
//   "startDate": "2023-11-22T10:48:37.399Z",
//   "endDate": "2023-11-22T10:48:37.399Z",
//   "emails": [
//     "haidilisnaini@gmail.com"
//   ]
// }
