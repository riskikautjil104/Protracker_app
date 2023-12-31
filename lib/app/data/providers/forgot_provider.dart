import 'package:get/get.dart';
import 'package:productivity_tracker_app/core/utils/EndPoints.dart';

class ForgotProvider extends GetConnect {
  Future<Response> forgot(var data) async {
    var myHeader = {
      'Accept': 'application/json',
    };
    return await post(EndPoints.forgotPassword, data, headers: myHeader);
  }

  Future<Response> createNewPassword(var data) async {
    var myHeader = {
      'Accept': 'application/json',
    };
    return await post(EndPoints.resetPassword, data, headers: myHeader);
  }
}
