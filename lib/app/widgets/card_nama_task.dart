import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:productivity_tracker_app/app/modules/project/controllers/project_controller.dart';

class CardTask extends StatelessWidget {
  final String namaProject;
  final String toDos;
  final String date;
  final String progress;
  final chekBox;

  const CardTask({
    Key? key,
    required this.namaProject,
    required this.toDos,
    required this.date,
    required this.progress,
    required this.chekBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ProjectController controller = Get.find<ProjectController>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      color: Color(0XFFD6D6D6),
      child: SizedBox(
        height: 90,
        width: 344,
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Row(
            children: [
              chekBox,
              SizedBox(width: 17),
              Expanded(
                // Gunakan Expanded agar Column mengambil sisa lebar yang tersedia
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaProject,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      // maxLines: 2,
                      // Atur maxWidth untuk membatasi lebar teks
                      // maxWidth: 200, // Sesuaikan nilai sesuai kebutuhan
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0XFFB1B1B1),
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
