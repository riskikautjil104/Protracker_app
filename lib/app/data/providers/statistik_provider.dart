import 'package:get/get.dart';
import 'package:productivity_tracker_app/core/utils/EndPoints.dart';
import '../models/statistik_models.dart';
import 'package:sp_util/sp_util.dart';

class ApiServicess extends GetConnect {
  var token = SpUtil.getString('jwtToken');
  var name = SpUtil.getString('username');
  Future<List<Project>> fetchData1() async {
    final response = await get(
      EndPoints.baseUrl + 'stat/$name/get-stats-project',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print("ini adalah kamu ${response.body}");
    if (response.status.isOk) {
      Map<String, dynamic> responseData = response.body;
      List<dynamic> data = responseData['data'];

      // Konversi data JSON menjadi objek Project1
      return data.map((json) => Project.fromJson(json)).toList();
    } else {
      final errorResponse = response.body['Errors'];
      throw Exception('Gagal mengambil data proyek: $errorResponse');
    }
  }

  Future<List<StatistikDataMonth>> fetchDataStatistikMonthDay() async {
    final response = await get(
      EndPoints.baseUrl + 'stat/$name/get-stat-month',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print("ini pusing ${response.body}");
    if (response.status.isOk) {
      Map<String, dynamic> data = response.body['data'];

      // Konversi data JSON menjadi objek StatistikDataMonth
      return [
        StatistikDataMonth.fromJson(data),
      ];
    } else {
      final errorResponse = response.body['Errors'];
      throw Exception('Gagal mengambil data proyek: $errorResponse');
    }
  }

  // lastweek
  Future<List<StatistikDataLastWeek>> fetchDataStatistikLastWeek() async {
    final response = await get(
      EndPoints.baseUrl + 'stat/$name/get-stat-week',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print("ini pusing ${response.body}");
    if (response.status.isOk) {
      Map<String, dynamic> data = response.body['data'];

      // Konversi data JSON menjadi objek StatistikDataLastWeek
      return [
        StatistikDataLastWeek.fromJson(data),
      ];
    } else {
      final errorResponse = response.body['Errors'];
      throw Exception('Gagal mengambil data proyek: $errorResponse');
    }
  }

  // day
  Future<List<StatistikDataDay>> fetchDataStatistikDay() async {
    final response = await get(
      EndPoints.baseUrl + 'stat/$name/get-stat-day',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print("ini pusing ${response.body}");
    if (response.status.isOk) {
      Map<String, dynamic> data = response.body['data'];

      // Konversi data JSON menjadi objek StatistikDataLastWeek
      return [
        StatistikDataDay.fromJson(data),
      ];
    } else {
      final errorResponse = response.body['Errors'];
      throw Exception('Gagal mengambil data proyek: $errorResponse');
    }
  }

  // quarter
  Future<List<StatistikDataQuarter>> fetchDataStatistikQuarter() async {
    final response = await get(
      EndPoints.baseUrl + 'stat/$name/get-stat-quarter',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print("ini pusing ${response.body}");
    if (response.status.isOk) {
      Map<String, dynamic> data = response.body['data'];

      // Konversi data JSON menjadi objek StatistikDataLastWeek
      return [
        StatistikDataQuarter.fromJson(data),
      ];
    } else {
      final errorResponse = response.body['Errors'];
      throw Exception('Gagal mengambil data proyek: $errorResponse');
    }
  }

  // post data statistik day

  Future<Response> postData(int inputData) async {
   
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // Membuat Map untuk body permintaan
    Map<String, dynamic> jsonData = {"hour": inputData};

    final response = await post(
      EndPoints.baseUrl + 'stat/$name/add-working-time',
      jsonData,
      headers: myHeader,
    );

    print("ini adalah input ${response.body}");

    return response;
  }
}
