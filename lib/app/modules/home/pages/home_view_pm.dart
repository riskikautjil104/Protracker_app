import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:productivity_tracker_app/app/modules/home/views/home_view.dart';
// import 'package:productivity_tracker_app/app/modules/project/controllers/project2_controller.dart';
import 'package:sp_util/sp_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/providers/project_api_random.dart';
import '../controllers/home_controller.dart';

import '../../../widgets/navbarAppBar.dart';

import '../models/project1.dart';

import '../widget/cart_project.dart';

class HomePm extends GetView<HomeController> {
  final ApiServices apiService = ApiServices();

  @override
  Widget build(BuildContext context) {
    // final Project2Controller controller2 = Project2Controller();

    return Scaffold(
      // navbar
      appBar: GradientAppBar(
        title: Text(
          SpUtil.getString('username').toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
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
        leading: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            // Navigasi ke halaman detail profil
            Get.toNamed('/profile');
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              height:
                  50, // Ubah tinggi dan lebar agar sama untuk membuat lingkaran
              width: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipOval(
                child: Image.asset('assets/image/profilePic.png',
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        actions: [
          SizedBox(width: 10),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  controller.goToNotification();
                },
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.red, // Warna latar belakang angka notifikasi
                    borderRadius:
                        BorderRadius.circular(10), // Bentuk angka notifikasi
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: FutureBuilder<int>(
                    // Ambil nilai notifikasi dari API
                    future: apiService.fetchDataNotificationCountPM(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int notificationCount = snapshot.data!;

                        return Text(
                          notificationCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        );
                      } else {
                        // Tampilkan loader atau widget lain jika data belum tersedia
                        return Container(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

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
          Get.offAll(HomeView());
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
                child: Column(
                  children: [
                    SizedBox(width: 10),
                    Lottie.asset(
                      'assets/lottie/Animation-cat-serevr.json',
                      width: 200, // Sesuaikan ukuran animasi sesuai kebutuhan
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Server Erorr 500 ${snapshot.error}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                        width:
                            10), // Jarak antara teks dan animasi, sesuaikan sesuai kebutuhan
                    Lottie.asset(
                      'assets/lottie/cat.json',
                      width: 200, // Sesuaikan ukuran animasi sesuai kebutuhan
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'No Project',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              List<Project1> projects = snapshot.data!;
              // target selesai
              projects.sort((a, b) => b.endDate.compareTo(a.endDate));

              // start project
              // projects.sort((a, b) => b.startDate.compareTo(a.startDate));
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 27,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "List Project",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Count Project: ${projects.length}")
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      height: MediaQuery.of(context).size.height * 0.7 - 26,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          Project1 project = projects[index];
                          if (project.status == false) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              child: CartProject(
                                onTap: () {},
                                namaProject: project.name, // Ganti properti
                                date: DateFormat('yyyy-MM-dd').format(project
                                    .endDate), // Konversi DateTime ke String
                                progress:
                                    '${project.progress}%', // Ganti properti
                                percent: project.progress is int
                                    ? project.progress.toDouble() / 100
                                    : project.progress.toDouble() /
                                        100, // Ganti properti
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              child: CartProject(
                                onTap: () {},
                                namaProject: project.name, // Ganti properti
                                date: DateFormat('yyyy-MM-dd').format(project
                                    .endDate), // Konversi DateTime ke String
                                progress:
                                    '${project.progress}%\t✅', // Ganti properti
                                percent: project.progress.toDouble() /
                                    100, // Ganti properti
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
