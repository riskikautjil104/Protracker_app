import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../data/models/detail_project.dart';
import '../../../data/providers/project_api_random.dart';
import '../../../data/providers/project_provider.dart';
import '../../../data/models/projects_model.dart';
import '../models/project1.dart';

class HomeController extends GetxController {
  final ProjectProvider _apiService = ProjectProvider();
  final project = Project(code: 0, data: []).obs;
  RxBool isRefreshing = false.obs;
  var currentIndex = 0.obs;
  final count = 0.obs;
  RxBool isLoading = true.obs;
  // notifacis method
  void goToNotification() {
    Get.toNamed('/notification');
  }

  Future fetchDataFromApi() async {
    // print(isLoading);
    try {
      final data = await _apiService.fetchData();
      project.value = data;

      isLoading = false.obs;
    } catch (e) {
    } finally {
      isLoading = false.obs;
    }
  }

// method button_navigator
  void changePage(int index) {
    currentIndex.value = index;
  }

  void changePagePm(int index) {
    currentIndex.value = index;
  }

  var detailProject = DetailProject(
      code: 0,
      data: DetailProjectData(
        id: '',
        name: '',
        description: '',
        pmName: '',
        createdAt: DateTime.now(),
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: false,
      )).obs;

  void fetchDetailProjectData() {
    EasyLoading.show(status: 'loading...');

    // print(data);

    Get.toNamed('/project');
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataFromApi();

    // update();
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final ApiServices apiService = ApiServices();
  final RxList<Project1> projects = <Project1>[].obs;

// Metode untuk memuat data
  Future<List<Project1>> loadData() async {
    List<Project1> data = await apiService.fetchData1();
    projects.assignAll(data);
    refreshController.refreshCompleted();
    return data;
  }
}
