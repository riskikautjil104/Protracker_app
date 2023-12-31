import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/data/models/target.dart';
import 'package:productivity_tracker_app/app/data/models/tasks.dart';
import 'package:productivity_tracker_app/app/data/models/projects_model.dart';
import 'package:productivity_tracker_app/app/data/models/detail_project.dart';
import 'package:productivity_tracker_app/app/data/models/team.dart';
import 'package:productivity_tracker_app/core/utils/EndPoints.dart';
// import 'package:productivity_tracker_app/core/utils/EndPoints.dart';
import 'package:sp_util/sp_util.dart';

class ProjectProvider extends GetConnect {
  var token = SpUtil.getString('jwtToken');
  var name = SpUtil.getString('username');
  var ids = SpUtil.getString('projectId');
  Future<Project> fetchData() async {
    final response = await get(
        EndPoints.baseUrl + 'project/$name/get-all-project',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }); // Ganti 'URL_API' dengan URL API yang sesuai
    print('id task ${ids}');
    if (response.status.hasError) {
      throw Exception('Gagal Memuat Data');
    }
    // simpan project id
    SpUtil.putString('projectId', response.body['data']['id']);

    print('raspons ${response.body}');

    return Project.fromJson(response.body);
  }

  Future<Response> createProject(var data) async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await post(EndPoints.baseUrl + 'project/$name/create-project', data,
        headers: myHeader);
  }

  Future<Response> createTask(var data, String idProject) async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await post(EndPoints.baseUrl + 'task/$name/create-task?projectId=$idProject', data,
        headers: myHeader);
  }

  Future<Response> updateProject(var data, var id) async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await put(
        EndPoints.baseUrl + 'project/$name/update-project?projectId=$id', data,
        headers: myHeader);
  }

  Future<DetailProject> detailProject(var id) async {
    final response = await get(
        EndPoints.baseUrl + 'project/$name/get-project?projectId=$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }); // Ganti 'URL_API' dengan URL API yang sesuai
    if (response.status.hasError) {
      throw Exception('Error saat mengambil data');
    }
    return DetailProject.fromJson(response.body);
  }

  Future<List<Tasks>> getPmTasks(var id) async {
    final response = await get(
        EndPoints.baseUrl + 'task/get-all-task?projectId=$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }); // Ganti 'URL_API' dengan URL API yang sesuai
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = response.body['data'];
      // print(jsonResponse);
      return jsonResponse.map((data) => Tasks.fromJson(data)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Data Tidak ada');
      // final List<dynamic> jsonResponse = response.body;
      // print(jsonResponse);
      // return jsonResponse.map((data) => Tasks.fromJson(data)).toList();
    } else {
      throw Exception();
      // final List<dynamic> jsonResponse = response.body;
      // print(jsonResponse);
      // return jsonResponse.map((data) => Tasks.fromJson(data)).toList();
    }
  }

// get team
  Future<List<Team>> getTeamProject(var id) async {
    final response = await get(
        EndPoints.baseUrl + 'project/get-project-team?projectId=$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }); // Ganti 'URL_API' dengan URL API yang sesuai
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = response.body['data'];
      // print(jsonResponse);
      return jsonResponse.map((data) => Team.fromJson(data)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Data Tidak ada');
      // final List<dynamic> jsonResponse = response.body;
      // print(jsonResponse);
      // return jsonResponse.map((data) => Tasks.fromJson(data)).toList();
    } else {
      throw Exception();
      // final List<dynamic> jsonResponse = response.body;
      // print(jsonResponse);
      // return jsonResponse.map((data) => Tasks.fromJson(data)).toList();
    }
  }

// get crew taget
  Future<List<Target>> getTargetCrew(var id, var nameCrew) async {
    final response = await get(
        EndPoints.baseUrl +
            'week-target/$nameCrew/get-all-target?projectId=$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }); // Ganti 'URL_API' dengan URL API yang sesuai
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = response.body['data'];
      // print(jsonResponse);
      return jsonResponse.map((data) => Target.fromJson(data)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Data Tidak ada');
    } else {
      throw Exception();
    }
  }

  Future<Response> createTarget(var data, var projectId, var nameCrew) async {
    var token = SpUtil.getString('jwtToken');
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await post(
        EndPoints.baseUrl +
            'week-target/$nameCrew/create-target?projectId=$projectId',
        data,
        headers: myHeader);
  }

// get crew tasks
  Future<List<Tasks>> getCrewTasks(var id) async {
    final response = await get(
        EndPoints.baseUrl + 'task/$name/get-all-task?projectId=$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }); // Ganti 'URL_API' dengan URL API yang sesuai
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = response.body['data'];
      print(jsonResponse);
      return jsonResponse.map((data) => Tasks.fromJson(data)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Data Tidak ada');
      // final List<dynamic> jsonResponse = response.body;
      // print(jsonResponse);
      // return jsonResponse.map((data) => Tasks.fromJson(data)).toList();
    } else {
      throw Exception();
      // final List<dynamic> jsonResponse = response.body;
      // print(jsonResponse);
      // return jsonResponse.map((data) => Tasks.fromJson(data)).toList();
    }
  }

  Future<Response> deleteProject(var id) async {
    // final response =  // Ganti 'URL_API' dengan URL API yang sesuai

    // if (response.status.hasError) {
    //   throw Exception('Error saat mengambil data');
    // }
    return await delete(
        EndPoints.baseUrl + 'project/$name/delete-project?projectId=$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
  }

  // static  baseUrl = 'https://pro-pracker.azurewebsites.net/api';

  Future<List<String>> fetchNamesTargetFromApi() async {
    try {
      final response = await get(
          EndPoints.baseUrl + 'week-target/$name/get-all-target',
          query: {
            'projectId': SpUtil.getString('idProject')
          },
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          });

      if (response.status.isOk) {
        // List<String> names = (response.body as List)
        //     .map((data) => data['data']['name'].toString())
        //     .toList();
        // List<String> names = (response.body as List<dynamic>)
        //     .map((data) => data['data']['name'].toString())
        //     .toList();
        print(response.body['data']['week']);
        List<String> names = [
          (response.body as Map<String, dynamic>)['data']['week'].toString()
        ];
        // List<String> names = (response.body as List<dynamic>)
        //     .map((data) => data['name'].toString())
        //     .toList();

        print(names);
        print('names');
        return names;
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan Target: $e');
    }
  }

  Future<Response> changeStatusTask(var id) async {
    // final response =  // Ganti 'URL_API' dengan URL API yang sesuai

    // if (response.status.hasError) {
    //   throw Exception('Error saat mengambil data');
    // }
    // var body = {};

    return await patch(
        EndPoints.baseUrl + 'task/$name/update-task-status?taskId=$id', {},
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        });
  }
}
