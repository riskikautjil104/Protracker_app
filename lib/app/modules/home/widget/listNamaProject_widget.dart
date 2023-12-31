// import 'package:flutter/material.dart';

// import 'package:percent_indicator/percent_indicator.dart';

// class CartProject extends StatelessWidget {
//     final String namaProject;
  
//   final String date;
//   final String progress;
//   const CartProject({
//     required this.namaProject,
    
//     required this.date,
//     required this.progress,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(14.0),
//         ),
//         // Menggunakan Card di dalam CarouselSlider
//         color: Color(0XFFD6D6D6),
//         child: SizedBox(
//           height: 73,
//           width: 344,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               namaProject,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 140,
//                             ),
//                             Text(
//                               date,
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 12,
//                       ),
//                       Row(
//                         // mainAxisAlignment:
//                         //     MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context)
//                                     .size
//                                     .width -
//                                 (MediaQuery.of(context)
//                                         .size
//                                         .width -
//                                     290),
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.circular(10.0),
//                               color: Color(0XFFB1B1B1),
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: ClipRRect(
//                                     borderRadius:
//                                         BorderRadius.circular(
//                                             10.0),
//                                     child:
//                                         LinearPercentIndicator(
//                                       padding: EdgeInsets.zero,
//                                       animation: true,
//                                       lineHeight: 7.0,
//                                       animationDuration: 2500,
//                                       percent: 0.9,
//                                       progressColor:
//                                           Color(0XFF197492),
//                                       backgroundColor:
//                                           Colors.transparent,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             progress,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 9.06,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }