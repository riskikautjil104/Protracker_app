import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import '../models/task_models.dart';

class ApiService extends GetConnect {
  // ...

  Future<List<TaskData>> fetchDataTask() async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');
    var taskId = SpUtil.getString('projectId');

    final response = await get(
      'https://protracker.azurewebsites.net/api/task/$name/get-all-task?projectId=$taskId',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print('nama $name');
    print('nama id task $taskId');
    print('token $token');
    print("data data nya heitsaaa ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.body['data'];
      List<dynamic> data = [responseData];
      print("ini adalah $data");

      return data.map((json) => TaskData.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data\nHarap muat ulang');
    }
  }
}
