import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:productivity_tracker_app/app/data/models/target.dart';
import 'package:productivity_tracker_app/app/modules/project/controllers/project2_controller.dart';
import 'package:productivity_tracker_app/app/modules/project/views/add_target_view.dart';
// import 'package:productivity_tracker_app/app/modules/project/views/add_target_view.dart';
import 'package:productivity_tracker_app/app/modules/project/widgets/card_target.dart';
import 'package:productivity_tracker_app/app/widgets/navbarAppBar.dart';
import 'package:sp_util/sp_util.dart';

// ignore: must_be_immutable
class TargetView extends GetView<Project2Controller> {
  String projectId;
  String name;
  String crewRole;
  TargetView({
    required this.projectId,
    required this.name,
    required this.crewRole,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQuerywidth = MediaQuery.of(context).size.width;
    // ProjectController controller = Get.find<ProjectController>();
    // final mediaQueryHeight = MediaQuery.of(context).size.height;

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
        'Target',
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
      // actions: (SpUtil.getString('userType') == 'crew')
      //     ? []
      //     : <Widget>[
      //         PopupMenuButton(
      //             // add icon, by default "3 dot" icon
      //             icon: Icon(
      //               Icons.more_vert,
      //               color: Colors.white,
      //             ),
      //             itemBuilder: (context) {
      //               return [
      //                 const PopupMenuItem<int>(
      //                   value: 0,
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       Icon(
      //                         Icons.edit,
      //                         color: Colors.black,
      //                       ),
      //                       Text(
      //                         'Edit',
      //                         style: TextStyle(
      //                             fontSize: 16, fontWeight: FontWeight.w700),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 PopupMenuItem<int>(
      //                   value: 1,
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       IconButton(
      //                         onPressed: () {},
      //                         icon: Icon(
      //                           Icons.delete,
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                       Text(
      //                         'Delete',
      //                         style: TextStyle(
      //                             fontSize: 16, fontWeight: FontWeight.w700),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ];
      //             },
      //             onSelected: (value) {
      //               if (value == 0) {
      //                 // Get.to(const EditProfileView());
      //               } else if (value == 1) {
      //                 Get.dialog(
      //                   Center(
      //                     child: Container(
      //                       padding: EdgeInsets.all(20.0),
      //                       width: mediaQuerywidth * 0.8,
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(20)),
      //                       child: Column(
      //                         mainAxisSize: MainAxisSize.min,
      //                         children: [
      //                           Text(
      //                               'This project will be permanently deleted'),
      //                           SizedBox(height: 20),
      //                           Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceAround,
      //                             children: [
      //                               TextButton(
      //                                 onPressed: () {
      //                                   Get.back(); // Menutup modal
      //                                 },
      //                                 child: Text(
      //                                   'Cancel',
      //                                   style: TextStyle(
      //                                     color: Colors.black,
      //                                     fontSize: 14,
      //                                     fontWeight: FontWeight.w700,
      //                                   ),
      //                                 ),
      //                               ),
      //                               TextButton(
      //                                 onPressed: () {},
      //                                 child: Text(
      //                                   'Accept',
      //                                   style: TextStyle(
      //                                     color: Colors.black,
      //                                     fontSize: 14,
      //                                     fontWeight: FontWeight.w700,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               }
      //             }),
      //       ],
    );

    // final bodyHeight = mediaQueryHeight -
    //     appBar.preferredSize.height -
    //     MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 31),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Text(
                name.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3),
              Text(
                (crewRole == null) ? '' : crewRole.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFB1B1B1)),
              ),
              SizedBox(height: 13),
              GetBuilder<Project2Controller>(builder: (controler) {
                return Container(
                  height: mediaQueryHeight * 0.9,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 11),
                        Container(
                          height: mediaQueryHeight * 0.7,
                          width: mediaQuerywidth * 0.9,
                          child: FutureBuilder<List<Target>>(
                            future: controller.getAllCrewTarget(
                                controller.detailProject.value.data.id, name),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Tidak ada Target'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(child: Text('Tidak ada Target'));
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    Target target = snapshot.data![index];
                                    return CardTarget(
                                      week: target.week.toString(),
                                      label: target.labels.toString(),
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
              }),
              SizedBox(height: 10),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: (SpUtil.getString('userType') == 'crew')
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Get.to(AddTargetView(
                  projectId: projectId,
                  crewName: name,
                ));
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
