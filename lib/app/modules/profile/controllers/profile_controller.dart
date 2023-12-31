import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/data/providers/profile_provider.dart';
import 'package:productivity_tracker_app/app/modules/profile/views/profile_view.dart';
import 'package:sp_util/sp_util.dart';

class ProfileController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  var isObscured = true.obs; // Observable<bool> to track the obscureText state

  void toggleObscureText() {
    isObscured
        .toggle(); // Toggles the value of isObscured (true to false or vice versa)
  }

  var isObscured2 = true.obs; // Observable<bool> to track the obscureText state

  void toggleObscureText2() {
    isObscured2
        .toggle(); // Toggles the value of isObscured (true to false or vice versa)
  }

  void updateProfile() {
    print(username.text);
    print(email.text);
    print(password.text);
    print(confirmPassword.text);
    if (username.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Username cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (email.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Email cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (password.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Password cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (confirmPassword.text.isEmpty) {
      Get.snackbar(
        'Failed',
        'Confrim Password cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else if (password.text != confirmPassword.text) {
      Get.snackbar(
        'Failed',
        'Password is not the same as Confirm Password',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show(status: 'loading...');
      var data = {
        "username": username.text,
        "email": email.text,
        "password": password.text,
        "confirmPassword": confirmPassword.text
      };

      ProfileProvider().updateProfile(data).then((value) {
        // final data = jsonDecode(value.body) as Map<String, dynamic>;
        print(value.body);
        if (value.statusCode == 200) {
          Get.snackbar('Successful', 'profile updated successfully',
              backgroundColor: Colors.green.shade500,
              colorText: Colors.white,
              duration: Duration(seconds: 4));
          SpUtil.remove('username');
          SpUtil.remove('email');
          SpUtil.putString('email', email.text);
          SpUtil.putString('username', username.text);
          username.clear();
          email.clear();
          password.clear();
          confirmPassword.clear();
          Get.to(ProfileView());
          EasyLoading.dismiss();
        } else if (value.statusCode == 400) {
          // String emailFailed = data['Faileds']['Email'][0];
          // String userNameFailed = data['Faileds']['Username'][0];
          // String passwordError = data['errors']['Password'][0];
          // String confirmPasswordError = data['errors']['ConfirmPassword'][0];
          // print(value.body['Errors']);
          EasyLoading.dismiss();
          Get.snackbar(
            'Failed',
            value.body['Errors'],
            backgroundColor: Colors.red.shade500,
            colorText: Colors.white,
          );
        }
      });
      // EasyLoading.dismiss();
    }
  }
}
