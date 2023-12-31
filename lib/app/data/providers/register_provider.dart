import 'package:get/get.dart';
import 'package:productivity_tracker_app/core/utils/EndPoints.dart';

class RegisterProvider extends GetConnect {
  Future<Response> getRegister(var data) async {
    var myHeader = {
      'Accept': 'application/json'
    };
    return await post(EndPoints.register, data, headers: myHeader);
  }
}
