import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
import 'package:productivity_tracker_app/app/modules/home/models/project1.dart';
// import 'package:lottie/lottie.dart';
// import 'package:productivity_tracker_app/app/modules/home/widget/cart_project.dart';
// import 'package:productivity_tracker_app/app/modules/home/models/project1.dart';
import 'package:productivity_tracker_app/app/modules/home/widget/cart_project.dart';
import 'package:productivity_tracker_app/app/modules/project/controllers/project2_controller.dart';
import 'package:productivity_tracker_app/app/modules/project/views/add_project_view.dart';
// import 'package:productivity_tracker_app/app/modules/project/views/detail_project.dart';
import 'package:productivity_tracker_app/app/widgets/navbarAppBar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sp_util/sp_util.dart';

// import '../../../data/models/home_model.dart';

// ignore: must_be_immutable
class Project2View extends GetView<Project2Controller> {
  Project2View({super.key});

  @override
  Widget build(BuildContext context) {
    Project2Controller controller = Get.put(Project2Controller());
    // final mediaQueryHeight = MediaQuery.of(context).size.height;
    final appBar = GradientAppBar(
      centerText: true,
      title: Text(
        'Project',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      gradient: LinearGradient(
        colors: [
          Color(0xFF197391),
          Color(0xFF0F9EEA),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );

    // final bodyHeight = mediaQueryHeight -
    //     appBar.preferredSize.height -
    //     MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SmartRefresher(
        controller: controller.refreshController,
        enablePullDown: true,
        header: ClassicHeader(
          refreshingText: 'Memuat...',
          completeText: 'Selesai',
          failedText: 'Gagal',
          idleText: 'Tarik ke bawah untuk refresh',
        ),

        // onRefresh: () async {
        //   await Future.delayed(Duration(milliseconds: 1000));
        //   await ConnectionState.waiting;
        //   await controller.loadData();

        //   // await apiService.fetchData1();
        // },
        onRefresh: () async {
          controller.loadData();
          controller.isRefreshing.value = true;
          await Future.delayed(Duration(milliseconds: 1000));
          await controller.loadData();
          controller.isRefreshing.value = false;
        },
        child: FutureBuilder<List<Project1>?>(
          future: controller.loadData(),
          // future:
          // apiService.fetchData1(),
          builder: (context, snapshot) {
            if (controller.isRefreshing.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0XFF0F9EEA),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color(0XFF0F9EEA),
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error1: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('Tidak ada data'),
              );
            } else {
              List<Project1> projects = snapshot.data!;
              // target selesai
              projects.sort((a, b) => b.endDate.compareTo(a.endDate));

              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 35),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        Text(
                          'Uncompleted Projects',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: projects
                              .where((project) => !project.status)
                              .length,
                          itemBuilder: (context, index) {
                            Project1 project = projects
                                .where((project) => !project.status)
                                .toList()[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              child: CartProject(
                                onTap: () => controller
                                    .fetchDetailProjectData(project.id),
                                namaProject: project.name,
                                date: DateFormat('yyyy-MM-dd')
                                    .format(project.endDate),
                                progress: '${project.progress}%',
                                percent: project.progress is int
                                    ? project.progress.toDouble() / 100
                                    : project.progress.toDouble() / 100,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Completed Projects',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: projects
                              .where((project) => project.status)
                              .length,
                          itemBuilder: (context, index) {
                            Project1 project = projects
                                .where((project) => project.status)
                                .toList()[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              child: CartProject(
                                onTap: () => controller
                                    .fetchDetailProjectData(project.id),
                                namaProject: project.name,
                                date: DateFormat('yyyy-MM-dd')
                                    .format(project.endDate),
                                progress: '${project.progress}%\t✅',
                                percent: project.progress.toDouble() / 100,
                              ),
                            );
                          },
                        ),

                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: ClampingScrollPhysics(),
                        //   itemCount: projects.length,
                        //   itemBuilder: (context, index) {
                        //     Project1 project = projects[index];
                        //     return Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 9),
                        //         child: project.status == false
                        //             ? CartProject(
                        // onTap: () => controller
                        //     .fetchDetailProjectData(project.id),
                        //                 namaProject:
                        //                     project.name, // Ganti properti
                        //                 date: DateFormat('yyyy-MM-dd').format(
                        //                     project
                        //                         .endDate), // Konversi DateTime ke String
                        //                 progress:
                        //                     '${project.progress}%', // Ganti properti
                        //                 percent: project.progress /
                        //                     100, // Ganti properti
                        //               )
                        //             : Container());
                        //   },
                        // ),
                        // SizedBox(height: 11),
                        // (projects.length <= 0)
                        //     ? Column(
                        //         children: [
                        //           Text(
                        //             'Tidak Ada Project',
                        //             style: TextStyle(
                        //                 fontSize: 13,
                        //                 fontWeight: FontWeight.w700),
                        //           ),
                        //           Lottie.asset('assets/lottie/notfound.json'),
                        //         ],
                        //       )
                        //     : Text(
                        //         'Completed',
                        // style: TextStyle(
                        //     fontSize: 13, fontWeight: FontWeight.w700),
                        //       ),
                        // SizedBox(height: 11),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: ClampingScrollPhysics(),
                        //   itemCount: projects.length,
                        //   itemBuilder: (context, index) {
                        //     Project1 project = projects[index];
                        //     return Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 9),
                        //       child: project.status == true
                        //           ? CartProject(
                        //               onTap: () => controller
                        //                   .fetchDetailProjectData(project.id),
                        //               namaProject:
                        //                   project.name, // Ganti properti
                        //               date: DateFormat('yyyy-MM-dd').format(project
                        //                   .endDate), // Konversi DateTime ke String
                        //               progress:
                        //                   '${project.progress}%', // Ganti properti
                        //               percent: project.progress /
                        //                   100, // Ganti properti
                        //             )
                        //           : Container(),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: (SpUtil.getString('userType') == 'Crew')
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Get.to(AddProjectView());
              },
              // foregroundColor: customizations[index].$1,
              backgroundColor: Color(0xFF0F9EEA),
              // shape: customizations[index].$3,
              child: const Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
            ),
    );
  }
}
