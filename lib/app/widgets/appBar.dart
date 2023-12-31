import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/modules/home/views/home_view.dart';
// for use in Scaffold
// appBar: appBar(
//         'Profile',
//         <Widget>[
//           IconButton(
//             icon: Icon(Icons.more_vert),
//             onPressed: () {
//               //action for search icon button
//             },
//           ),
//         ],
//       ),

appBar(String title, actions) {
  return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.offAll(HomeView());
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Color(0xff2DB5F4),
                Color(0xff197390),
              ]),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFFFFF)),
      ),
      actions: actions);
}
