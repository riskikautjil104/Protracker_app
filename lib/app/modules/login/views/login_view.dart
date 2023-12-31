import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends GetView<LoginController> {
  final LoginController _obscureTextController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            
            leading: IconButton(
              onPressed: () {
                Get.toNamed('/welcome');
              },
              icon: Container(
                width: 41,
                height: 41,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: Colors.amber,
                  border: Border.all(color: Color(0xFFE8ECF4)),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(23),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Welcome back to ',
                          style: GoogleFonts.playfairDisplay(
                            textStyle: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF032D23),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextSpan(
                          text: 'Productivity Tracker App',
                          style: GoogleFonts.playfairDisplay(
                            textStyle: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF0F9EEA),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 57),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Obx(() {
                    return TextFormField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextController.isObscured.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _obscureTextController.toggleObscureText();
                          },
                        ),
                      ),
                      obscureText: _obscureTextController.isObscured.value,
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.toNamed('/forgot'),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  InkWell(
                    onTap: () {
                      controller.login();
                      // Get.offAllNamed('/homeCrew');
                    },
                    child: Container(
                      width: 330,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: <Color>[
                            Color(0xff2DB5F4),
                            Color(0xff197390),
                          ],
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ),
                  SizedBox(height: 150),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () => Get.toNamed('/register'),
                          child: Text('Register Now'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
