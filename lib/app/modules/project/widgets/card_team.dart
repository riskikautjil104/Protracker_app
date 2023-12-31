import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/modules/project/controllers/project2_controller.dart';
import 'package:productivity_tracker_app/app/modules/project/views/target.dart';

// ignore: must_be_immutable
class CardTeam extends StatelessWidget {
  Project2Controller controller = Project2Controller();
  final String name;
  final String role;
  final String teamId;
  final String projectId;

  CardTeam({
    Key? key,
    required this.name,
    required this.role,
    required this.teamId,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      color: Color(0XFFD6D6D6),
      child: SizedBox(
        height: 87,
        width: 344,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.centerLeft,
                      clipBehavior: Clip.antiAlias,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0XFF737373),
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.to(TargetView(projectId:projectId,name: name, crewRole: role));
                        controller.getAllCrewTarget(projectId, name);
                      },
                      icon: Icon(
                        Icons.add_box_outlined,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
