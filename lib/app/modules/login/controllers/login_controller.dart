import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/data/providers/login_provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:productivity_tracker_app/app/data/login_provider.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isObscured = true.obs; // Observable<bool> to track the obscureText state

  void toggleObscureText() {
    isObscured
        .toggle(); // Toggles the value of isObscured (true to false or vice versa)
  }

  void logout() {
    LoginProvider().logout(SpUtil.getString('jwtToken'));
    Get.offAllNamed('/login');
  }

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Failed',
        "Email or Password cannot be empty",
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show(status: 'loading...');
      var data = {
        'email': email,
        'password': password,
      };

      LoginProvider().auth(data).then((value) {
        print(value.statusCode);
        if (value.statusCode == 200) {
          var responBody = value.body;

          var data = responBody['data'];
          var username = data['username'];
          var id = data['id'];
          var email = data['email'];
          var userType = data['userType'];
          var jwtToken = data['jwtToken'];
          if (data['crewRole'] != null) {
            var crewRole = data['crewRole'];
            SpUtil.putString('crewRole', crewRole);
          }
          SpUtil.putString('username', username);
          SpUtil.putString('userId', id);
          SpUtil.putString('email', email);
          SpUtil.putString('jwtToken', jwtToken);
          SpUtil.putString('userType', userType);
          SpUtil.putBool('already_login', true);
          print(SpUtil.getString('jwtToken'));
          // if (userType == 'Crew') {
          //   Get.offAllNamed('/homeCrew');
          // } else if (userType == 'Project Manager') {
          //   Get.offAllNamed('/homeViewPm');
          // }
          Get.offAllNamed('/homeCrew');

          // print(username);
        } else if (value.statusCode == 400) {
          Get.snackbar(
            'Failed',
            "Incorrect Email or Password",
            backgroundColor: Colors.red.shade500,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Failed',
            "Something Wrong, Please Login Again",
            backgroundColor: Colors.red.shade500,
            colorText: Colors.white,
          );
        }
        EasyLoading.dismiss();
      });
    }
  }
}
// wahyu@example.com crew
// fikri@example.com pm
// Tespassword123