// import 'package:flutter/material.dart';


// class CartNamaTask extends StatelessWidget {
//   final String namaProject;
//   final String toDos;
//   final String date;
//   final String progress;

//   const CartNamaTask({
//     Key? key,
//     required this.namaProject,
//     required this.toDos,
//     required this.date,
//     required this.progress,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14.0),
//       ),
//       color: Color(0XFFD6D6D6),
//       child: SizedBox(
//         height: 73,
//         width: 344,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     namaProject,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     toDos,
//                     style: TextStyle(
//                       fontSize: 10.68,
//                       color: Color(0XFF737373),
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 width: 150,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     date,
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Color(0XFFB1B1B1),
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     progress,
//                     style: TextStyle(
//                       fontSize: 9.06,
//                       color: Color(0XFFB1B1B1),
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }