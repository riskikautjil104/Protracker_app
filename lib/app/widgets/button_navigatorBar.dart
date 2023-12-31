import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../modules/home/controllers/home_controller.dart';

class NavigatorButton extends StatelessWidget {
  const NavigatorButton({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0XFF197391),
                  Color(0xFF0F9EEA),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        // BottomNavigationBar
        Obx(
          () => BottomNavigationBar(
            currentIndex: homeController.currentIndex.value,
            elevation: 0,
            selectedItemColor: Color(0XFF28A4DC),
            unselectedItemColor: Colors.white,
            // ukuran font yang dipilh
            selectedFontSize: 14,

            // Atur ukuran font item yang tidak dipilih
            unselectedFontSize: 12,
            // Gaya label item yang dipilih
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),

            // Gaya label item yang tidak dipilih
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            onTap: homeController.changePage,
            type: BottomNavigationBarType.fixed,
            // Ubah latar belakang menjadi transparan
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_alt_sharp),
                label: 'Project',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Statistik',
              ),
              //
            ],
          ),
        ),
      ],
    );
  }
}
