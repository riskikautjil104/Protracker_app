import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:productivity_tracker_app/app/data/models/target.dart';
import 'package:productivity_tracker_app/app/data/models/tasks.dart';
import 'package:productivity_tracker_app/app/data/models/team.dart';
import 'package:productivity_tracker_app/app/modules/project/controllers/project2_controller.dart';
import 'package:productivity_tracker_app/app/modules/project/views/update_project_view.dart';
import 'package:productivity_tracker_app/app/modules/project/widgets/card_target.dart';
import 'package:productivity_tracker_app/app/modules/project/widgets/card_team.dart';
import 'package:productivity_tracker_app/app/modules/project/widgets/list_text_project.dart';
import 'package:productivity_tracker_app/app/modules/task/views/add_task_view.dart';
import 'package:productivity_tracker_app/app/widgets/card_nama_task.dart';
// import 'package:productivity_tracker_app/app/modules/home/widget/cart_project.dart';
import 'package:productivity_tracker_app/app/widgets/navbarAppBar.dart';
import 'package:sp_util/sp_util.dart';

// import '../controllers/project_controller.dart';

// ignore: must_be_immutable
class DetailProjectView extends GetView<Project2Controller> {
  // Project2Controller detailProjectcontroller = Get.find<Project2Controller>().refresh();

  @override
  Widget build(BuildContext context) {
    Project2Controller controller = Get.put(Project2Controller());
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQuerywidth = MediaQuery.of(context).size.width;
    final appBar = GradientAppBar(
      centerText: true,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          )),
      title: Text(
        controller.detailProject.value.data.name,
        style: TextStyle(
          fontSize: 15,
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
      actions: (SpUtil.getString('userType') == 'Crew')
          ? []
          : <Widget>[
              PopupMenuButton(
                  // add icon, by default "3 dot" icon
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            Text(
                              'Edit',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      Get.to(UpdateProjectView(
                          projectId: controller.detailProject.value.data.id,
                          projectName: controller.detailProject.value.data.name,
                          description:
                              controller.detailProject.value.data.description,
                          startDate:
                              controller.detailProject.value.data.startDate,
                          endDate:
                              controller.detailProject.value.data.endDate));
                    } else if (value == 1) {
                      Get.dialog(
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            width: mediaQuerywidth * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'This project will be permanently deleted'),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back(); // Menutup modal
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.deleteProject(controller
                                            .detailProject.value.data.id);
                                        Get.offAllNamed('/home');
                                      },
                                      child: Text(
                                        'Accept',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ],
    );

    final bodyHeight = mediaQueryHeight -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: bodyHeight,
        width: mediaQuerywidth,
        child: Column(
          children: [
            // ListText(
            //   bodyHeight: bodyHeight,
            //   mediaQuerywidth: mediaQuerywidth,
            //   text1: 'Added by',
            //   text2: controller.detailProject.value.data.pmName,
            // ),
            // ListText(
            //   bodyHeight: bodyHeight,
            //   mediaQuerywidth: mediaQuerywidth,
            //   text1: 'Assigned to',
            //   text2: "${SpUtil.getString('username')}",
            // ),
            ListText(
              bodyHeight: bodyHeight,
              mediaQuerywidth: mediaQuerywidth,
              text1: 'Runs from',
              text2:
                  "${DateFormat('yyyy-MM-dd').format(controller.detailProject.value.data.startDate)} - ${DateFormat('yyyy-MM-dd').format(controller.detailProject.value.data.endDate)}",
            ),
            ListText(
              bodyHeight: bodyHeight,
              mediaQuerywidth: mediaQuerywidth,
              text1: 'Status',
              text2: (controller.detailProject.value.data.status == false)
                  ? 'On-Progress'
                  : 'Finish',
            ),
            SizedBox(
              height: mediaQueryHeight * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => controller.tabIndex.value = 0,
                          child: Obx(() {
                            return Text(
                              'Tasks',
                              style: TextStyle(
                                color: (controller.tabIndex.value == 0)
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            );
                          }),
                        ),
                        (SpUtil.getString('userType') == 'Crew')
                            ? TextButton(
                                onPressed: () => controller.tabIndex.value = 1,
                                child: Obx(() {
                                  return Text(
                                    'Target',
                                    style: TextStyle(
                                        color: (controller.tabIndex.value == 1)
                                            ? Colors.blue
                                            : Colors.black),
                                  );
                                }),
                              )
                            : TextButton(
                                onPressed: () => controller.tabIndex.value = 2,
                                child: Obx(() {
                                  return Text(
                                    'Teams',
                                    style: TextStyle(
                                        color: (controller.tabIndex.value == 2)
                                            ? Colors.blue
                                            : Colors.black),
                                  );
                                }),
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      switch (controller.tabIndex.value) {
                        // tasks
                        case 0:
                          // tasks
                          return (SpUtil.getString('userType') == 'Crew')
                              ?
                              // Crew
                              GetBuilder<Project2Controller>(
                                  builder: (controler) {
                                  return Container(
                                    height: mediaQueryHeight * 0.6,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            'On-Progress',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 11),
                                          Container(
                                            height: mediaQueryHeight * 0.3,
                                            width: mediaQuerywidth * 0.9,
                                            child: FutureBuilder<List<Tasks>>(
                                              future: controller
                                                  .getAllCrewTasks(controller
                                                      .detailProject
                                                      .value
                                                      .data
                                                      .id),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text('No Tasks'));
                                                } else if (!snapshot.hasData ||
                                                    snapshot.data!.isEmpty) {
                                                  return Center(
                                                      child: Text('No Tasks'));
                                                } else {
                                                  return ListView.builder(
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Tasks task =
                                                          snapshot.data![index];
                                                      return (task.status ==
                                                              false)
                                                          ? CardTask(
                                                              namaProject:
                                                                  task.name,
                                                              toDos: 'toDos',
                                                              date: DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(task
                                                                      .createdAt),
                                                              progress:
                                                                  'progress',
                                                              chekBox:
                                                                  IconButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .taskToggleStatus(
                                                                          task.id);
                                                                },
                                                                icon: Icon(Icons
                                                                    .check_box_outline_blank),
                                                              ),
                                                            )
                                                          : Container(
                                                              color:
                                                                  Colors.white,
                                                            );
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 11),
                                          Text(
                                            'Completed',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 11),
                                          Container(
                                            height: mediaQueryHeight * 0.3,
                                            width: mediaQuerywidth * 0.9,
                                            child: FutureBuilder<List<Tasks>>(
                                              future: controller
                                                  .getAllCrewTasks(controller
                                                      .detailProject
                                                      .value
                                                      .data
                                                      .id),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          'No Tasks Completed'));
                                                } else if (!snapshot.hasData ||
                                                    snapshot.data!.isEmpty) {
                                                  return Center(
                                                      child: Text(
                                                          'No Tasks Completed'));
                                                } else {
                                                  return ListView.builder(
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Tasks task =
                                                          snapshot.data![index];
                                                      return (task.status ==
                                                              true)
                                                          ? CardTask(
                                                              namaProject:
                                                                  task.name,
                                                              toDos: 'toDos',
                                                              date: DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(task
                                                                      .createdAt),
                                                              progress:
                                                                  'progress',
                                                              chekBox:
                                                                  IconButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .taskToggleStatus(
                                                                          task.id);
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .check_box,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              color:
                                                                  Colors.white,
                                                            );
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              :
                              // pm
                              GetBuilder<Project2Controller>(
                                  builder: (controler) {
                                  return Container(
                                    height: mediaQueryHeight * 0.7,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            'All Tasks',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 11),
                                          Container(
                                            height: mediaQueryHeight * 0.6,
                                            width: mediaQuerywidth * 0.9,
                                            child: FutureBuilder<List<Tasks>>(
                                              future: controller.getAllPmTasks(
                                                  controller.detailProject.value
                                                      .data.id),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text('No Tasks'));
                                                } else if (!snapshot.hasData ||
                                                    snapshot.data!.isEmpty) {
                                                  return Center(
                                                      child: Text('No Tasks'));
                                                } else {
                                                  return ListView.builder(
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Tasks task =
                                                          snapshot.data![index];
                                                      return CardTask(
                                                          namaProject:
                                                              task.name,
                                                          toDos: 'toDos',
                                                          date: DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(task
                                                                  .createdAt),
                                                          progress: 'progress',
                                                          chekBox: Text(''));
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 11),
                                          // Text(
                                          //   'Completed',
                                          //   style: TextStyle(
                                          //     fontSize: 15,
                                          //     fontWeight: FontWeight.w700,
                                          //   ),
                                          // ),
                                          // SizedBox(height: 11),
                                          // Container(
                                          //   height: mediaQueryHeight * 0.3,
                                          //   width: mediaQuerywidth * 0.9,
                                          //   child: FutureBuilder<List<Tasks>>(
                                          //     future: controller.getAllPmTasks(
                                          //         controller.detailProject.value
                                          //             .data.id),
                                          //     builder: (context, snapshot) {
                                          //       if (snapshot.connectionState ==
                                          //           ConnectionState.waiting) {
                                          //         return Center(
                                          //             child:
                                          //                 CircularProgressIndicator());
                                          //       } else if (snapshot.hasError) {
                                          //         return Center(
                                          //             child: Text(
                                          //                 'No Tasks Completed'));
                                          //       } else if (!snapshot.hasData ||
                                          //           snapshot.data!.isEmpty) {
                                          //         return Center(
                                          //             child: Text(
                                          //                 'No Tasks Completed'));
                                          //       } else {
                                          //         return ListView.builder(
                                          //           itemCount:
                                          //               snapshot.data!.length,
                                          //           itemBuilder:
                                          //               (context, index) {
                                          //             Tasks task =
                                          //                 snapshot.data![index];
                                          //             return (task.status ==
                                          //                     true)
                                          //                 ? CardTask(
                                          //                     namaProject:
                                          //                         task.name,
                                          //                     toDos: 'toDos',
                                          //                     date: DateFormat(
                                          //                             'yyyy-MM-dd')
                                          //                         .format(task
                                          //                             .createdAt),
                                          //                     progress:
                                          //                         'progress',
                                          //                     chekBox:
                                          //                         IconButton(
                                          //                       onPressed: () {
                                          //                         controller
                                          //                             .taskToggleStatus(
                                          //                                 task.id);
                                          //                       },
                                          //                       icon: Icon(
                                          //                         Icons
                                          //                             .check_box,
                                          //                         color: Colors
                                          //                             .blue,
                                          //                       ),
                                          //                     ),
                                          //                   )
                                          //                 : Container();
                                          //           },
                                          //         );
                                          //       }
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                        // GetBuilder<Project2Controller>(
                        //     builder: (controler) {
                        //     return Container(
                        //       height: mediaQueryHeight * 0.6,
                        //       child: Center(
                        //         child: Column(
                        //           children: [
                        //             Text(
                        //               'On-Progress',
                        //               style: TextStyle(
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //             ),
                        //             SizedBox(height: 11),
                        //             Container(
                        //               height: mediaQueryHeight * 0.3,
                        //               width: mediaQuerywidth * 0.9,
                        //               child: FutureBuilder<List<Tasks>>(
                        //                 future: controller.getAllPmTasks(
                        //                     controller.detailProject.value
                        //                         .data.id),
                        //                 builder: (context, snapshot) {
                        //                   if (snapshot.connectionState ==
                        //                       ConnectionState.waiting) {
                        //                     return Center(
                        //                         child:
                        //                             CircularProgressIndicator());
                        //                   } else if (snapshot.hasError) {
                        //                     return Center(
                        //                         child: Text('No Tasks'));
                        //                   } else if (!snapshot.hasData ||
                        //                       snapshot.data!.isEmpty) {
                        //                     return Center(
                        //                         child: Text('No Tasks'));
                        //                   } else {
                        //                     return ListView.builder(
                        //                       itemCount:
                        //                           snapshot.data!.length,
                        //                       itemBuilder:
                        //                           (context, index) {
                        //                         Tasks task =
                        //                             snapshot.data![index];
                        //                         return (task.status ==
                        //                                 false)
                        //                             ? CardTask(
                        //                                 namaProject:
                        //                                     task.name,
                        //                                 toDos: 'toDos',
                        //                                 date: DateFormat(
                        //                                         'yyyy-MM-dd')
                        //                                     .format(task
                        //                                         .createdAt),
                        //                                 progress:
                        //                                     'progress',
                        //                                 chekBox:
                        //                                     IconButton(
                        //                                   onPressed: () {
                        //                                     controller
                        //                                         .taskToggleStatus(
                        //                                             task.id);
                        //                                   },
                        //                                   icon: Icon(Icons
                        //                                       .check_box_outline_blank),
                        //                                 ),
                        //                               )
                        //                             : Container();
                        //                       },
                        //                     );
                        //                   }
                        //                 },
                        //               ),
                        //             ),
                        //             SizedBox(height: 11),
                        //             Text(
                        //               'Completed',
                        //               style: TextStyle(
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //             ),
                        //             SizedBox(height: 11),
                        //             Container(
                        //               height: mediaQueryHeight * 0.3,
                        //               width: mediaQuerywidth * 0.9,
                        //               child: FutureBuilder<List<Tasks>>(
                        //                 future: controller.getAllPmTasks(
                        //                     controller.detailProject.value
                        //                         .data.id),
                        //                 builder: (context, snapshot) {
                        //                   if (snapshot.connectionState ==
                        //                       ConnectionState.waiting) {
                        //                     return Center(
                        //                         child:
                        //                             CircularProgressIndicator());
                        //                   } else if (snapshot.hasError) {
                        //                     return Center(
                        //                         child: Text(
                        //                             'No Tasks Completed'));
                        //                   } else if (!snapshot.hasData ||
                        //                       snapshot.data!.isEmpty) {
                        //                     return Center(
                        //                         child: Text(
                        //                             'No Tasks Completed'));
                        //                   } else {
                        //                     return ListView.builder(
                        //                       itemCount:
                        //                           snapshot.data!.length,
                        //                       itemBuilder:
                        //                           (context, index) {
                        //                         Tasks task =
                        //                             snapshot.data![index];
                        //                         return (task.status ==
                        //                                 true)
                        //                             ? CardTask(
                        //                                 namaProject:
                        //                                     task.name,
                        //                                 toDos: 'toDos',
                        //                                 date: DateFormat(
                        //                                         'yyyy-MM-dd')
                        //                                     .format(task
                        //                                         .createdAt),
                        //                                 progress:
                        //                                     'progress',
                        //                                 chekBox:
                        //                                     IconButton(
                        //                                   onPressed: () {
                        //                                     controller
                        //                                         .taskToggleStatus(
                        //                                             task.id);
                        //                                   },
                        //                                   icon: Icon(
                        //                                     Icons
                        //                                         .check_box,
                        //                                     color: Colors
                        //                                         .blue,
                        //                                   ),
                        //                                 ),
                        //                               )
                        //                             : Container();
                        //                       },
                        //                     );
                        //                   }
                        //                 },
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   });
                        // target
                        case 1:
                          // target
                          return GetBuilder<Project2Controller>(
                              builder: (controler) {
                            return Container(
                              height: mediaQueryHeight * 0.7,
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 11),
                                    Container(
                                      height: mediaQueryHeight * 0.6,
                                      width: mediaQuerywidth * 0.9,
                                      child: FutureBuilder<List<Target>>(
                                        future: controller.getAllCrewTarget(
                                            controller
                                                .detailProject.value.data.id,
                                            SpUtil.getString('username')),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text('No Target'));
                                          } else if (!snapshot.hasData ||
                                              snapshot.data!.isEmpty) {
                                            return Center(
                                                child: Text('No Target'));
                                          } else {
                                            return ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                Target target =
                                                    snapshot.data![index];
                                                return CardTarget(
                                                  week: target.week.toString(),
                                                  label:
                                                      target.labels.toString(),
                                                  date:
                                                      "${DateFormat('yyyy-MM-dd').format(target.startDate)} - ${DateFormat('yyyy-MM-dd').format(target.endDate)}",
                                                  progress:
                                                      "${target.taskCompleted}/${target.target}",
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 11),
                                  ],
                                ),
                              ),
                            );
                          });
                        // teams
                        case 2:
                          // teams
                          return (SpUtil.getString('userType') == 'Crew')
                              ?
                              // Crew
                              Container()
                              :
                              // pm
                              GetBuilder<Project2Controller>(
                                  builder: (controler) {
                                  return Container(
                                    height: mediaQueryHeight * 0.6,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 11),
                                          Container(
                                            height: mediaQueryHeight * 0.6,
                                            width: mediaQuerywidth * 0.9,
                                            child: FutureBuilder<List<Team>>(
                                              future: controller
                                                  .getAllTeamProject(controller
                                                      .detailProject
                                                      .value
                                                      .data
                                                      .id),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          'Tidak ada Teams'));
                                                } else if (!snapshot.hasData ||
                                                    snapshot.data!.isEmpty) {
                                                  return Center(
                                                      child: Text(
                                                          'Tidak ada Teams'));
                                                } else {
                                                  return ListView.builder(
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Team team =
                                                          snapshot.data![index];
                                                      return CardTeam(
                                                          name: team.username,
                                                          role: team.crewRole,
                                                          teamId: team.id,
                                                          projectId: controller
                                                              .detailProject
                                                              .value
                                                              .data
                                                              .id);
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 11),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                        default:
                          return Container(color: Colors.white);
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: (SpUtil.getString('userType') == 'Project Manager')
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Get.to(AddTaskView(
                    idProject: controller.detailProject.value.data.id));
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
