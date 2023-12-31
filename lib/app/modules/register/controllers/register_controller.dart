import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
// import 'package:productivity_tracker_app/core/utils/EndPoints.dart';
// import 'package:http/http.dart' as http;
import 'package:productivity_tracker_app/app/data/providers/register_provider.dart';

class RegisterController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController userType = TextEditingController();
  TextEditingController crewRole = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final List<String> tipePengguna = [
    'Project Manager',
    'Crew',
  ];
  final List<String> roleItems = [
    "Frontend Dev",
    "Analyst",
    "Backend Dev",
    "Quality Assurance",
    "Mobile Dev",
    "UI/UX"
  ].obs;

  var isObscured = true.obs; // Observable<bool> to track the obscureText state

  void toggleObscureText() {
    isObscured
        .toggle(); // Toggles the value of isObscured (true to false or vice versa)
  }

  String? selectedTipePengguna;
  String? errTipePengguna;
  String? selectedRoleItem;

  var isPm = 'Crew'.obs; // Observable<bool> to track the obscureText state

  void register() {
    if (selectedTipePengguna == 'Project Manager') {
      selectedRoleItem = null;
    } else {
      selectedRoleItem = selectedRoleItem;
    }

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
    } else if (selectedTipePengguna == null) {
      Get.snackbar(
        'Failed',
        'User Type cannot be empty',
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } else {
      EasyLoading.show(status: 'loading...');
      var data = {
        "username": username.text,
        "email": email.text,
        "userType": selectedTipePengguna,
        "crewRole": selectedRoleItem,
        "password": password.text,
        "confirmPassword": confirmPassword.text
      };

      RegisterProvider().getRegister(data).then((value) {
        // final data = jsonDecode(value.body) as Map<String, dynamic>;
        // print(value.body);
        if (value.statusCode == 200) {
          Get.snackbar('Successful',
              'Your account has been successfully registered Please Login',
              backgroundColor: Colors.green.shade500,
              colorText: Colors.white,
              duration: Duration(seconds: 4));
          username.clear();
          email.clear();
          password.clear();
          confirmPassword.clear();
          Get.toNamed('/login');
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
