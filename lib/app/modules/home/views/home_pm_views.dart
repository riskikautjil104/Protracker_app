// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../controllers/home_controller.dart';

// import '../../../widgets/button_navigatorBar.dart';

// import '../pages/home_view_pm.dart';

// import '../../statistik/views/statistik_pm.dart';

// class HomeViewPm extends GetView<HomeController> {
//   const HomeViewPm({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final HomeController homePmController = Get.put(HomeController());
//     return Scaffold(
//       body: Obx(
//         () {
//           switch (homePmController.currentIndex.value) {
//             case 0:
//               return HomePm();
//             case 1:
//               return Container(
//                 child: Center(
//                   child: Text(
//                     "Not Found",
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               );
//             case 2:
//               return StatistikPm();
//             default:
//               return Container();
//           }
//         },
//       ),
//       bottomNavigationBar: NavigatorButton(homeController: homePmController),
//     );
//   }
// }
