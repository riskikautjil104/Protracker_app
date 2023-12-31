import 'package:get/get.dart';
import 'package:productivity_tracker_app/core/utils/EndPoints.dart';
import '../../modules/home/models/project1.dart';
import 'package:sp_util/sp_util.dart';


class ApiServices extends GetConnect {
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

     
      return data.map((json) => Project1.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data proyek\nHarap muat ulang');
    }
  }

  

  Future<int> fetchDataNotificationCountPM() async {
    try {
      var token = SpUtil.getString('jwtToken');
      var token1 =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUml6a2kiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IlJMLWNjNmRhMTAiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJDcmV3IiwiSldUSUQiOiI1NzAwOGRlNC0xYjI4LTRlMWMtODQzNC03NjIzYjFiZjc5ZDcifQ.JVSGGOQPzCkyF-Kus5ScXQZcbI6YvgSQdGTPlevq28Y';
      print("ini adalah token ${token}");
      var name = SpUtil.getString('username');
      print("nama : ${name}");

      final response = await get(
        EndPoints.baseUrl + 'home/$name',
        headers: {
          'Authorization': 'Bearer $token1',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print(
          "int notif ${response.body}"); 
          // Tambahkan ini untuk mencetak respons API

      if (response.status.isOk) {
        Map<String, dynamic> responseData = response.body;
        int notificationCount = responseData['data']['notifications'];

        return notificationCount;
      } else {
        throw Exception('Gagal mengambil data notifikasi');
      }
    } catch (error) {
      print(error.toString()); // Tambahkan ini untuk mencetak kesalahan (error)
      throw error;
    }
  }
}
