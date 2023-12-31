import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../data/providers/statistik_provider.dart';
import '../../../widgets/navbarAppBar.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/statistik_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../pages/detail_statistik_pm.dart';
import '../../../data/models/statistik_models.dart';

class StatistikPm extends StatelessWidget {
  StatistikPm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatistikController controller = Get.put(StatistikController());
    final HomeController homeCrewController = Get.put(HomeController());
    final ApiServicess apiService = ApiServicess();
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          'Statistik',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerText: true,
        gradient: LinearGradient(
          colors: [
            Color(0xFF197391),
            Color(0xFF0F9EEA),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
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
          await apiService.fetchData1();
          controller.onInit();
          await StatistikController;
          // await homeCrewController.currentIndex(2);
          homeCrewController.changePage(2);
          await controller.loadData();
          // Get.offAll(
          //   HomeView(),
          //   arguments: 2,
          // );
        },
        child: FutureBuilder<List<Project>>(
          future: apiService.fetchData1(),
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
                    SizedBox(
                        width:
                            10), // Jarak antara teks dan animasi, sesuaikan sesuai kebutuhan
                    Lottie.network(
                      'https://lottie.host/21f699d1-5f97-405e-b338-e31d1a80cb9d/07uDzn6POU.json',
                      width: 200, // Sesuaikan ukuran animasi sesuai kebutuhan
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'No Data',
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
              List<Project> projects = snapshot.data!;
              projects.sort((a, b) => b.endDate.compareTo(a.endDate));
              return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  Project project = projects[index];
                  return Material(
                    elevation: 0.1,
                    child: InkWell(
                      splashColor: Color(0xFF197391),
                      onTap: () {
                        // Navigasi menggunakan GetX
                        Get.to(() => DetailStatistikPm(
                              project: project,
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0XFF292D32),
                                              Color(0XFF929197),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircularPercentIndicator(
                                          radius: 30.0,
                                          animation: true,
                                          animationDuration: 5200,
                                          lineWidth: 5.0,
                                          percent: project.progress is int
                                              ? project.progress.toDouble() /
                                                  100
                                              : project.progress.toDouble() /
                                                  100,
                                          center: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${(project.progress).toStringAsFixed(0)}%',
                                                // ${project.progress}%
                                              ),
                                            ),
                                          ),
                                          circularStrokeCap:
                                              CircularStrokeCap.butt,
                                          backgroundColor: Colors.transparent,
                                          progressColor: Color(0XFF2697F7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      project.name.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "🚀 ${project.endDate.toString().substring(0, 10)}",
                                          // DateFormat('yyyy-MM-dd')
                                          //     .format(project.endDate),
                                          style: TextStyle(fontSize: 9),
                                        ),
                                        Text(
                                          "-",
                                          style: TextStyle(fontSize: 9),
                                        ),
                                        Text(
                                          "✅ ${project.startDate.toString().substring(0, 10)}",
                                          // DateFormat('yyyy-MM-dd')
                                          //     .format(project.startDate),
                                          style: TextStyle(fontSize: 9),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
