// // import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:productivity_tracker_app/app/data/models/detail_project.dart';
// import 'package:productivity_tracker_app/app/data/models/projects_model.dart';
// import 'package:productivity_tracker_app/app/data/providers/project_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:productivity_tracker_app/app/modules/home/views/home_view.dart';
// import 'package:productivity_tracker_app/app/modules/project/views/detail_project.dart';
// // import 'package:sp_util/sp_util.dart';
// // import 'package:productivity_tracker_app/app/data/providers/project_provider.dart';
// // import 'package:sp_util/sp_util.dart';

// class ProjectController extends GetxController {
//   TextEditingController projectName = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController emails = TextEditingController();

//   final ProjectProvider _apiService = ProjectProvider();
//   final project = Project(code: 0, data: []).obs;
//   var detailProject = DetailProject(
//       code: 0,
//       data: DetailProjectData(
//         id: '',
//         name: '',
//         description: '',
//         pmName: '',
//         createdAt: DateTime.now(),
//         startDate: DateTime.now(),
//         endDate: DateTime.now(),
//         status: false,
//       )).obs;
//   RxBool isLoading = true.obs;
//   RxInt tabIndex = 0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDataFromApi();
//     // update();
//   }

//   Future fetchDataFromApi() async {
//     print(isLoading);
//     try {
//       final data = await _apiService.fetchData();
//       project.value = data;

//       // print(project.value.data);
//       if (data.data.length == 0) {
//         print('data kosong');
//       } else {
//         print('data ada');
//       }
//       isLoading = false.obs;
//       print(isLoading);
//     } catch (e) {
//       // Handle error
//       print(e.toString());
//     } finally {
//       isLoading = false.obs;
//     }
//     // print(isLoading);
//   }

// //  task
//   var taskIsChecked = false.obs;

//   void taskToggleCheckbox(var value) {
//     taskIsChecked.value = value;
//   }

// // add project
//   var selectedEndDate = ''.obs;
//   var selectedStartDate = ''.obs;

//   void pickStartDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2121),
//     );

//     if (pickedDate != null) {
//       selectedStartDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
//     }
//   }

//   void pickEndDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2121),
//     );

//     if (pickedDate != null) {
//       selectedEndDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
//     }
//   }

//   // void post() {
//   //   // List<String> removeSpace = emails.text.split(' ');
//   //   // print('Slicing by space: $splittedBySpace');
//   // List<String> x = emails.text.split(RegExp(r'\s|,'));
//   //   // Memotong string berdasarkan koma
//   //   // List<String> removeKoma = emails.text.split(',');
//   //   // var s = removeSpace;
//   //   // var s = removeKoma;
//   //   // print('Slicing by comma: $splittedByComma');
//   //   // print(s);
//   //   // print(selectedStartDate.value);
//   //   // print(selectedEndDate.value);
//   // }

//   // create project
//   void post() {
//     if (projectName.text.isEmpty) {
//       Get.snackbar(
//         'Failed',
//         'Project name cannot be empty',
//         backgroundColor: Colors.red.shade500,
//         colorText: Colors.white,
//       );
//     } else if (emails.text.isEmpty) {
//       Get.snackbar(
//         'Failed',
//         'Emails cannot be empty',
//         backgroundColor: Colors.red.shade500,
//         colorText: Colors.white,
//       );
//     } else if (selectedStartDate.value.isEmpty) {
//       Get.snackbar(
//         'Failed',
//         'Start Date cannot be empty',
//         backgroundColor: Colors.red.shade500,
//         colorText: Colors.white,
//       );
//     } else if (selectedEndDate.value.isEmpty) {
//       Get.snackbar(
//         'Failed',
//         'End Date cannot be empty',
//         backgroundColor: Colors.red.shade500,
//         colorText: Colors.white,
//       );
//     } else {
//       EasyLoading.show(status: 'loading...');
//       List<String> listEmail = emails.text.split(RegExp(r'\s|,'));
//       var data = {
//         "name": projectName.text,
//         "description": description.text,
//         "startDate": selectedStartDate.value,
//         "endDate": selectedEndDate.value,
//         "emails": listEmail,
//       };

//       ProjectProvider().createProject(data).then((value) {
//         // final data = jsonDecode(value.body) as Map<String, dynamic>;
//         print(value.body);
//         if (value.statusCode == 200) {
//           Get.snackbar('Successful', value.body['data'],
//               backgroundColor: Colors.green.shade500,
//               colorText: Colors.white,
//               duration: Duration(seconds: 3));
//           projectName.clear();
//           emails.clear();
//           description.clear();
//           selectedStartDate.value = '';
//           selectedEndDate.value = '';
//           EasyLoading.dismiss();
//           update();
//           // (SpUtil.getString('userType') == 'Crew')
//           //     ? Get.offAll(HomeViewCrew())
//           //     : Get.offAll(HomePm());
//           Get.offAll(HomeView());
//         } else if (value.statusCode == 400) {
//           print(value.body['Errors']);
//           EasyLoading.dismiss();
//           Get.snackbar(
//             'Failed',
//             value.body['Errors'],
//             backgroundColor: Colors.red.shade500,
//             colorText: Colors.white,
//           );
//         }
//       });
//       // EasyLoading.dismiss();
//     }
//     update();
//   }

//   // detail projects
//   void fetchDetailProjectData(var id) {
//     EasyLoading.show(status: 'loading...');
//     ProjectProvider().detailProject(id).then((value) {
//       // print(value.code);
//       // print(value.data.name);
//       // print(value.data.pmName);
//       // print(value.data.status);
//       // print(value.data.startDate);
//       // print(value.data.endDate);
//       // print(value.data.createdAt);
//       // print(value.data.description);
//       if (value.code == 200) {
//         var data = {
//           "code": 200,
//           "data": {
//             "id": value.data.id,
//             "name": value.data.name,
//             "description": value.data.description,
//             "pmName": value.data.pmName,
//             "createdAt": DateFormat('yyyy-MM-dd').format(value.data.createdAt),
//             "startDate": DateFormat('yyyy-MM-dd').format(value.data.startDate),
//             "endDate": DateFormat('yyyy-MM-dd').format(value.data.endDate),
//             "status": value.data.status
//           }
//         };
//         // print(data);
//         DetailProject projectData = DetailProject.fromJson(data);
//         detailProject.value = projectData;
//         Get.to(DetailProjectView());
//         EasyLoading.dismiss();
//       }
//     });
//     // Method ini seharusnya mengambil data dari API (misalnya dengan http.get) dan mengatur nilai project
//     // Di sini kita hanya membuat contoh data untuk simulasi
//   }

//   // hapus project
//   void deleteProject(var id) {
//     ProjectProvider().deleteProject(id);
//   }
// }

// // {
// //   "name": "Create Project 3",
// //   "description": "Tes Create Project 3",
// //   "startDate": "2023-11-22T10:48:37.399Z",
// //   "endDate": "2023-11-22T10:48:37.399Z",
// //   "emails": [
// //     "haidilisnaini@gmail.com"
// //   ]
// // }
