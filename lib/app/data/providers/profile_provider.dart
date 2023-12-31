import 'package:get/get.dart';
import 'package:productivity_tracker_app/core/utils/EndPoints.dart';
import 'package:sp_util/sp_util.dart';

class ProfileProvider extends GetConnect {
  Future<Response> updateProfile(var data) async {
    var token = SpUtil.getString('jwtToken');
    var name = SpUtil.getString('username');
    var myHeader = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await put(EndPoints.baseUrl + 'home/$name/update-profile', data,
        headers: myHeader);
  }
}
