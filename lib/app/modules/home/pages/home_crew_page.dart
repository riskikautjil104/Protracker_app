import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:productivity_tracker_app/app/modules/login/controllers/login_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sp_util/sp_util.dart';
import '../controllers/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../widgets/navbarAppBar.dart';
import '../views/home_view.dart';
import '../widget/cart_project.dart';
import '../widget/cart_nama_task.dart';
import '../../../data/providers/home_provider.dart';
import '../../../data/models/home_model.dart';
import 'package:lottie/lottie.dart';

class HomeViewCrew extends GetView<HomeController> {
  final LoginController loginController = Get.put(LoginController());
  final ApiServices apiService = ApiServices();
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // Set tinggi yang diinginkan (misalnya, 430.0)
    double desiredHeight = 430.0;
    // var productivity = SpUtil
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      // navbar
      appBar: GradientAppBar(
        title: Text(
          SpUtil.getString('username').toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
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
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height:
                  50, // Ubah tinggi dan lebar agar sama untuk membuat lingkaran
              width: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/image/profilePic.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        actions: [
          SizedBox(width: 13),
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
                  padding: EdgeInsets.all(4),
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
                    future: apiService
                        .fetchDataNotificationCount(), // Menggunakan fungsi async untuk mengambil data dari API
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
                          child: CircularProgressIndicator(color: Colors.blue),
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
        onRefresh: () async {
          await Get.offAll(HomeView());
          await controller.loadData();
          // await apiService.fetchData1();
        },
        child: FutureBuilder<List<ProjectHomeCrew>?>(
          future: apiService.fetchDataHome(),
          // future: controller.loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0XFF0F9EEA),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                        width:
                            10), // Jarak antara teks dan animasi, sesuaikan sesuai kebutuhan
                    Lottie.asset(
                      'assets/lottie/Animation-cat-serevr.json',
                      width: 200, // Sesuaikan ukuran animasi sesuai kebutuhan
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
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
                    SizedBox(width: 10), // Jarak antara teks dan animasi
                    Lottie.network(
                      'https://lottie.host/21f699d1-5f97-405e-b338-e31d1a80cb9d/07uDzn6POU.json',
                      width: 200,
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
              List<ProjectHomeCrew> projects = snapshot.data!;

              return Column(
                children: [
                  // Bagian atas

                  Container(
                    width: 375,
                    height: 185,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<dynamic>(
                            future: apiService.productifity(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                dynamic sumProductivity = snapshot.data!;
                                return CIrcularStatistik(
                                  radius: 45.0,
                                  lineWidth: 13.0,
                                  animation: true,
                                  animationDuration: 5000,
                                  percent: sumProductivity is int
                                      ? sumProductivity.toDouble()
                                      : sumProductivity,
                                  centerText:
                                      "${(sumProductivity * 100).toStringAsFixed(0)}%",
                                  centerTextColor: Color(0XFF197492),
                                  centerTextFontWeight: FontWeight.bold,
                                  centerTextFontSize: 20.0,
                                  footerText: "Productivity",
                                  footerTextFontSize: 15.0,
                                  progressColor: Color(0XFF197492),
                                );
                              } else {
                                return Container(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                      color: Colors.blue),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 113,
                            width: 1,
                            color: Color(0XFFB1B1B1),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FutureBuilder<dynamic>(
                            future: apiService.contribution(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                dynamic sumContibution = snapshot.data!;
                                return CircularPercentIndicator(
                                  radius: 45.0,
                                  lineWidth: 13.0,
                                  animation: true,
                                  animationDuration: 5000,
                                  // contributionPercentage is int
                                  //           ? contributionPercentage
                                  //                           .toDouble() <
                                  //                       0 ||
                                  //                   contributionPercentage
                                  //                           .toDouble() >
                                  //                       1.1
                                  //               ? 1
                                  //               : contributionPercentage
                                  //                   .toDouble()
                                  //           : contributionPercentage < 0 ||
                                  //                   contributionPercentage > 1
                                  //               ? 1
                                  //               : contributionPercentage,
                                  percent: sumContibution is int
                                      ? sumContibution.toDouble() < 0 ||
                                              sumContibution.toDouble() > 1.1
                                          ? 1
                                          : sumContibution.toDouble()
                                      : sumContibution < 0 || sumContibution > 1
                                          ? 1
                                          : sumContibution,
                                  center: Text(
                                    "${(sumContibution * 100).toStringAsFixed(0)}%",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        color: Color(0XFF0F9EEA)),
                                  ),
                                  footer: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      "Contribution",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Color(0XFF2699FB),
                                );
                              } else {
                                return Container(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                      color: Colors.blue),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // CarouselSlider

                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: screenHeight < desiredHeight
                          ? screenHeight
                          : desiredHeight,
                      // height: 430.0,
                      viewportFraction: 1.0,
                      // autoPlay: projects.length > 1,
                      // autoPlayAnimationDuration: Duration(seconds: 5),
                    ),
                    items: projects.map(
                      (project) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  children: [
                                    Column(
                                      children: [
                                        project.status == true
                                            ? CartProject(
                                                namaProject:
                                                    project.name.toString(),
                                                date: "Completed✅",
                                                // DateFormat('yyyy-MM-dd')
                                                //     .format(project.endDate),
                                                progress:
                                                    '${project.progress}%',
                                                percent: project.progress / 100,
                                                leadingIcon:
                                                    Icons.arrow_back_ios,
                                                leadingIconOnPressed: () {
                                                  _carouselController
                                                      .previousPage();
                                                },
                                                trailingIcon:
                                                    Icons.arrow_forward_ios,
                                                tarilingIconOnPressed: () {
                                                  _carouselController
                                                      .nextPage();
                                                },
                                                onTap: () {},
                                              )
                                            : Column(
                                                children: [
                                                  CartProject(
                                                    namaProject:
                                                        project.name.toString(),
                                                    date: DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(
                                                            project.endDate),
                                                    progress:
                                                        '${project.progress}%',
                                                    percent:
                                                        project.progress / 100,
                                                    leadingIcon:
                                                        Icons.arrow_back_ios,
                                                    leadingIconOnPressed: () {
                                                      _carouselController
                                                          .previousPage();
                                                    },
                                                    trailingIcon:
                                                        Icons.arrow_forward_ios,
                                                    tarilingIconOnPressed: () {
                                                      _carouselController
                                                          .nextPage();
                                                    },
                                                    onTap: () {},
                                                  ),
                                                  SizedBox(height: 5),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 14,
                                                            right: 14),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          (project.tasks
                                                                      ?.isNotEmpty ??
                                                                  false)
                                                              ? "Task Count: ${project.tasks?.length}"
                                                              : "Task Count\t :\t 0",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          " ${(project.tasks?.where((task) => task.status == true).length ?? 0) > 0 ? project.tasks?.where((task) => task.status == true).length : 0}\t: \tTask Completed",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        SizedBox(
                                          height: 22,
                                        ),
                                        Column(
                                          children: [
                                            // Bagian "New Task"
                                            Text("Task"),
                                            if ((project.tasks ?? [])
                                                .isNotEmpty)
                                              for (var task in project.tasks!)
                                                if (task.status ==
                                                    false) // Hanya menampilkan jika status true
                                                  CartNamaTask(
                                                    namaProject: task.name,
                                                    toDos: task.name,
                                                    date: DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(task.createdAt),
                                                    // progress:
                                                    //     task.status.toString(),
                                                    progress: task.status
                                                        ? 'Selesai'
                                                        : 'Belum Selesai',
                                                  ),
                                            // CartNamaTask(
                                            //   namaProject: project.name,
                                            //   toDos: task.name,
                                            //   date: DateFormat('yyyy-MM-dd')
                                            //       .format(task
                                            //           .createdAt), // Sesuaikan dengan tanggal tugas
                                            //   progress: task.status
                                            //       .toString(), // Sesuaikan dengan progress tugas
                                            // ),
                                            if ((project.tasks ?? []).isEmpty)
                                              SizedBox(height: 10),
                                            // Bagian "New Task" kosong
                                            if ((project.tasks ?? []).isEmpty)
                                              Container(
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 223, 223, 223),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Center(
                                                  child: Container(
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 223, 223, 223),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Center(
                                                        child: Text('No Task'),
                                                      )
                                                      // Lottie.asset(
                                                      //     'assets/lottie/notfound.json'),
                                                      // child: Text("New Task Kosong"),
                                                      ),
                                                ),
                                              ),
                                            SizedBox(height: 8),

                                            // Bagian "Completed"
                                            if ((project.tasks ?? [])
                                                .isNotEmpty)
                                              ListView(
                                                shrinkWrap: true,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                children: [
                                                  Center(
                                                    child:
                                                        Text("Task Completed✅"),
                                                  ),
                                                  for (var task
                                                      in project.tasks!)
                                                    if (task.status ==
                                                        true) // Hanya menampilkan jika status true
                                                      CartNamaTask(
                                                        namaProject: task.name,
                                                        toDos: task.name,
                                                        date: DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                task.createdAt),
                                                        // progress: task.status
                                                        //     .toString(),
                                                        progress: task.status
                                                            ? 'Selesai'
                                                            : 'Belum Selesai',
                                                      ),
                                                ],
                                              ),
                                            // Bagian "Completed" kosong
                                            if ((project.tasks ?? []).isEmpty)
                                              Container(
                                                height: 70,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 223, 223, 223),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child:
                                                      Text("No Task Completed"),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class CIrcularStatistik extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final bool animation;
  final int animationDuration;
  final double percent;
  final String centerText;
  final Color centerTextColor;
  final FontWeight centerTextFontWeight;
  final double centerTextFontSize;
  final String footerText;
  final double footerTextFontSize;
  final Color progressColor;

  const CIrcularStatistik({
    Key? key,
    required this.radius,
    required this.lineWidth,
    required this.animation,
    required this.animationDuration,
    required this.percent,
    required this.centerText,
    required this.centerTextColor,
    required this.centerTextFontWeight,
    required this.centerTextFontSize,
    required this.footerText,
    required this.footerTextFontSize,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      animation: animation,
      animationDuration: animationDuration,
      percent: percent,
      center: Text(
        centerText,
        style: TextStyle(
          fontWeight: centerTextFontWeight,
          fontSize: centerTextFontSize,
          color: centerTextColor,
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          footerText,
          style: TextStyle(
            fontSize: footerTextFontSize,
          ),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: progressColor,
    );
  }
}
