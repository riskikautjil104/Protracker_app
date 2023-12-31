import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/data/models/home_model.dart';
import 'package:sp_util/sp_util.dart';
import '../../../core/utils/EndPoints.dart';
import '../../modules/home/models/project1.dart';
import '../models/notifikasi_models.dart';

class ApiServices extends GetConnect {
  Future<List<ProjectHomeCrew>> fetchDataHome() async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');

    final response = await get(
      EndPoints.baseUrl + 'home/$name',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.status.isOk) {
      Map<String, dynamic> responseData = response.body;

      List<dynamic> projectsData = responseData['data']['projects'];

      // Konversi data JSON menjadi objek ProjectHomeCrew
      List<ProjectHomeCrew> projectsList = projectsData
          .map((projectJson) => ProjectHomeCrew.fromJson(projectJson))
          .toList();

      return projectsList;
    } else {
      throw Exception('Gagal mengambil data proyek\nHarap muat ulang');
    }
  }

  // Fungsi untuk mengambil data notifikasi dari API
  Future<int> fetchDataNotificationCount() async {
    try {
      var token = SpUtil.getString('jwtToken');
      var name = SpUtil.getString('username');
      // print("nama : ${name}");

      final response = await get(
        EndPoints.baseUrl + 'home/$name',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

    

      if (response.status.isOk) {
        Map<String, dynamic> responseData = response.body;
        int notificationCount = responseData['data']['notifications'];

        return notificationCount;
      } else {
        throw Exception('Gagal mengambil data notifikasi');
      }
    } catch (error) {
     
      throw error;
    }
  }

  Future<dynamic> productifity() async {
    try {
      var token = SpUtil.getString('jwtToken');
      var name = SpUtil.getString('username');

      final response = await get(
        EndPoints.baseUrl + 'home/$name',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );


      if (response.status.isOk) {
        Map<String, dynamic> responseData = response.body;
        dynamic productivity = responseData['data']['productivity'];

        return productivity;
      } else {
        throw Exception('Gagal mengambil data productifity');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> contribution() async {
    try {
      var token = SpUtil.getString('jwtToken');
      var name = SpUtil.getString('username');
      print("nama : ${name}");

      final response = await get(
        EndPoints.baseUrl + 'home/$name',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );


      if (response.status.isOk) {
        Map<String, dynamic> responseData = response.body;
        dynamic contribution = responseData['data']['contribution'];

        return contribution;
      } else {
        throw Exception('Gagal mengambil data contribution');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<NotificationModel>> fetchDataNotifications() async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');
    final response = await get(
      EndPoints.baseUrl + 'home/$name/get-notifications',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    print(response.body['data']);
    if (response.status.isOk) {
      dynamic responseData = response.body['data'];

      if (responseData == null || responseData == "") {
        // Data kosong, kembalikan daftar kosong
        return [];
      }

      List<dynamic> responseDataList = responseData;

      List<NotificationModel> notifications = responseDataList
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      return notifications;
    } else {
      throw Exception('Gagal mengambil data notifikasi');
    }
  }

  Future<String> deleteAllNotifications() async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');

    final response = await delete(
      EndPoints.baseUrl + 'home/$name/delete-notifications',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.status.isOk) {
      return response.body['data'];
    } else {
      throw Exception('Gagal menghapus semua notifikasi');
    }
  }

  var token = SpUtil.getString('jwtToken');
  var name = SpUtil.getString('username');
  var ids = SpUtil.getString('projectId');

  // Method untuk mendapatkan daftar proyek
  Future<List<Project1>> fetchData1() async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');

    final response = await get(
      EndPoints.baseUrl + 'project/$name/get-all-project',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.status.isOk) {
      Map<String, dynamic> responseData = response.body;
      List<dynamic> data = responseData['data'];

      // Konversi data JSON menjadi objek Project1
      return data.map((json) => Project1.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data proyek\nHarap muat ulang');
    }
  }

  
}
