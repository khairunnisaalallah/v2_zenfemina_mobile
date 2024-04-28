// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/services.dart' show AssetImage;

// class ProfilePic extends StatelessWidget {
//   const ProfilePic({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 115,
//       width: 115,
//       child: Stack(
//         fit: StackFit.expand,
//         clipBehavior: Clip.none,
//         children: [
//           const CircleAvatar(
//             backgroundImage: AssetImage("assets/images/logo.png"),
//           ),
//           Positioned(
//             right: 34,
//             bottom: 34,
//             child: SizedBox(
//               height: 20,
//               width: 0,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     side: const BorderSide(color: Colors.white),
//                   ),
//                   backgroundColor: const Color(0xFFF5F6F9),
//                 ),
//                 onPressed: () {},
//                 child: SvgPicture.asset("assets/images/cameraicon.svg"),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
