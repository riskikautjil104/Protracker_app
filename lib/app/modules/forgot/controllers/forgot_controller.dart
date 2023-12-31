import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/data/providers/forgot_provider.dart';
import 'package:sp_util/sp_util.dart';

class ForgotController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newConfirmPassword = TextEditingController();
  void sendEmail() {
    EasyLoading.show(status: 'loading...');
    String email = emailController.text;

    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Failed',
        "Please Enter Your Email",
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
      EasyLoading.dismiss();
    } else {
      var data = {
        'email': email,
      };

      ForgotProvider().forgot(data).then((value) {
        if (value.statusCode == 200) {
          var responBody = value.body;

          var data = responBody['data'];
          var token = data['token'];
          var email = data['email'];
          SpUtil.putString('ForgotToken', token);
          SpUtil.putString('email', email);
          print(email);
          print(token);
          Get.toNamed('/otpVerification');
          EasyLoading.dismiss();
        } else {
          EasyLoading.dismiss();
          Get.snackbar(
            'Failed',
            'Enter your registered email',
            backgroundColor: Colors.red.shade500,
            colorText: Colors.white,
          );
        }
      });
    }
  }

  void reSendCode() {
    var emailResend = {'email': SpUtil.getString('email')};
    ForgotProvider().forgot(emailResend);
  }

  void resetPassword() {
    String password = newPassword.text;
    String confirmPassword = newConfirmPassword.text;
    if (password.length < 8) {
      Get.snackbar(
        'Failed',
        'Password Minimum 8 Characters',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (password != confirmPassword) {
      Get.snackbar(
        'Failed',
        'Password Does Not Match with Confirm Password',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    }
    if (newPassword.text.isEmpty || newConfirmPassword.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Password or Password Confirmation must be Entered.',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else {
      var data = {
        'token': SpUtil.getString('ForgotToken'),
        'email': SpUtil.getString('email'),
        'newPassword': password,
        'confirmPassword': confirmPassword,
      };

      print(data);
      ForgotProvider().createNewPassword(data).then((value) {
        EasyLoading.show(status: 'loading...');
        if (value.statusCode == 200) {
          SpUtil.clear();
          newPassword.clear();
          newConfirmPassword.clear();
          Get.offAllNamed('/changepasswordsuccess');
          EasyLoading.dismiss();
        } else {
          Get.snackbar(
            'Failed',
            'Something Wrong',
            backgroundColor: Colors.red.shade500,
            colorText: Colors.white,
          );
          EasyLoading.dismiss();
        }
      });
    }
  }
}
