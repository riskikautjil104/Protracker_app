// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// // import 'package:productivity_tracker_app/app/modules/home/widget/cart_project.dart';
// import 'package:productivity_tracker_app/app/data/models/projects_model.dart';
// import 'package:productivity_tracker_app/app/modules/home/widget/cart_project.dart';
// import 'package:productivity_tracker_app/app/modules/project/controllers/project2_controller.dart';
// import 'package:productivity_tracker_app/app/modules/project/views/add_project_view.dart';
// // import 'package:productivity_tracker_app/app/modules/project/views/detail_project.dart';
// import 'package:productivity_tracker_app/app/widgets/navbarAppBar.dart';
// import 'package:sp_util/sp_util.dart';

// // import '../controllers/project_controller.dart';

// // ignore: must_be_immutable
// class ProjectView extends GetView<Project2Controller> {
//   ProjectView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // ProjectController controller = Get.put(ProjectController());
//     // final mediaQueryHeight = MediaQuery.of(context).size.height;
//     final appBar = GradientAppBar(
//       centerText: true,
//       title: Text('Project'),
//       gradient: LinearGradient(
//         colors: [
//           Color(0xFF197391),
//           Color(0xFF0F9EEA),
//         ],
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//       ),
//     );

//     // final bodyHeight = mediaQueryHeight -
//     //     appBar.preferredSize.height -
//     //     MediaQuery.of(context).padding.top;

//     return Scaffold(
//       appBar: appBar,
//       body: Obx(
//         () => controller.isLoading.value == false
//             ? SingleChildScrollView(
//                 padding: EdgeInsets.only(top: 31),
//                 physics: BouncingScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   children: [
//                     GetBuilder<ProjectController>(
//                       builder: (controller) {
//                         return ListView.builder(
//                           itemCount: controller.project.value.data.length,
//                           shrinkWrap: true, // Menggunakan shrinkWrap
//                           physics: ClampingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             Projects data =
//                                 controller.project.value.data[index];
//                             return Column(
//                               children: [
//                                 (data.status == false)
//                                     ? CartProject(
//                                         onTap: () => controller
//                                             .fetchDetailProjectData(data.id),
//                                         namaProject: data.name.toString(),
//                                         date: data.endDate
//                                             .toString()
//                                             .substring(0, 10),
//                                         progress:
//                                             data.progress.toString() + ' %',
//                                         percent: data.progress.toDouble() / 100,
//                                         // percent: 75.5 / 100,
//                                       )
//                                     : Container(),
//                                 SizedBox(height: 11)
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                     SizedBox(height: 11),
//                     (controller.project.value.data.length <= 0)
//                         ? Column(
//                             children: [
//                               Text(
//                                 'Tidak Ada Project',
//                                 style: TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w700),
//                               ),
//                               Lottie.asset('assets/lottie/notfound.json'),
//                             ],
//                           )
//                         : Text(
//                             'Completed',
//                             style: TextStyle(
//                                 fontSize: 13, fontWeight: FontWeight.w700),
//                           ),
//                     SizedBox(height: 11),
//                     GetBuilder<ProjectController>(
//                       builder: (controller) {
//                         return ListView.builder(
//                           itemCount: controller.project.value.data.length,
//                           shrinkWrap: true, // Menggunakan shrinkWrap
//                           physics: ClampingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             Projects data =
//                                 controller.project.value.data[index];
//                             return Column(
//                               children: [
//                                 (data.status == true)
//                                     ? CartProject(
//                                         onTap: () => controller
//                                             .fetchDetailProjectData(data.id),
//                                         namaProject: data.name.toString(),
//                                         date: data.endDate
//                                             .toString()
//                                             .substring(0, 10),
//                                         progress:
//                                             data.progress.toString() + ' %',
//                                         percent: data.progress.toDouble() / 100,
//                                         // percent: 75.5 / 100,
//                                       )
//                                     : Container(),
//                                 SizedBox(height: 11)
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               )
//             : Center(
//                 child: CircularProgressIndicator(),
//               ),
//       ),
//       floatingActionButton: (SpUtil.getString('userType') == 'Crew')
//           ? Container()
//           : FloatingActionButton(
//               onPressed: () {
//                 Get.to(AddProjectView());
//               },
//               // foregroundColor: customizations[index].$1,
//               backgroundColor: Color(0xFF0F9EEA),
//               // shape: customizations[index].$3,
//               child: const Icon(
//                 Icons.add,
//                 size: 40,
//               ),
//             ),
//     );
//   }
// }
