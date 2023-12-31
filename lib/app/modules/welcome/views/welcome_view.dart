import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/image/logoRadya.png'),
                const SizedBox(height: 181),
                InkWell(
                  onTap: () {
                    Get.toNamed('/login');
                    // ;
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
                const SizedBox(height: 34),
                InkWell(
                  onTap: () => Get.toNamed('/register'),
                  child: Container(
                    width: 330,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(),
                    ),
                    child: const Center(
                        child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
