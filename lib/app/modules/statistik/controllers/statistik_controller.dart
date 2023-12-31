import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/providers/project_api_random.dart';
import '../../home/models/project1.dart';

class StatistikController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isDataLoaded = false.obs;
  RxInt myIntData = 0.obs;
  RxInt currentIndex = 0.obs;

  // Future<void> loadData() async {
  //   try {
  //     isLoading(true);
  //     // Lakukan pemanggilan data atau proses async lainnya
  //     // ...
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // void fetchData() async {
  //   try {
  //     isLoading(true);
  //     // Lakukan pemanggilan data atau proses async lainnya
  //     await loadData(); // Gantilah dengan pemanggilan data sebenarnya
  //     isDataLoaded(true);
  //   } finally {
  //     isLoading(false);
  //   }

  @override
  void onInit() {
    super.onInit();
    loadData();
    // fetchData();
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
