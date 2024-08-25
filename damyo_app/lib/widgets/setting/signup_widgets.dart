// import 'package:damyo_app/style.dart';
// import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
// import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// Widget signupName(BuildContext context, TextEditingController nameController) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       textFormat(
//         text: '이름',
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//       ),
//       const SizedBox(height: 10),
//       TextField(
//         controller: nameController,
//         decoration: const InputDecoration(
//           hintText: '이름을 입력해주세요.',
//           hintStyle: TextStyle(
//             color: Color(0xFFA8AFB6),
//             fontSize: 14,
//             fontFamily: 'Pretendard',
//             fontWeight: FontWeight.w500,
//           ),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xFFA9AFB7),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Widget signupAge(BuildContext context, TextEditingController ageController) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         '나이',
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 16,
//           fontFamily: 'Pretendard',
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       const SizedBox(height: 8),
//       SizedBox(
//         width: 130,
//         child: TextField(
//           controller: ageController,
//           keyboardType: TextInputType.number,
//           decoration: const InputDecoration(
//             hintText: '나이를 입력해주세요.',
//             hintStyle: TextStyle(
//               color: Color(0xFFA8AFB6),
//               fontSize: 14,
//               fontFamily: 'Pretendard',
//               fontWeight: FontWeight.w500,
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Color(0xFFA9AFB7),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Widget signupGender(BuildContext context, UserInfoViewModel userInfoViewModel) {
//   return SizedBox(
//     width: 180,
//     height: 100,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           '성별',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//             fontFamily: 'Pretendard',
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 30),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 73,
//               height: 33,
//               child: ElevatedButton(
//                 onPressed: () {
//                   userInfoViewModel.setGender(true);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: const Color(0xFF6E767F),
//                   backgroundColor:
//                       userInfoViewModel.userInfoModel.gender == true
//                           ? const Color(0xFF0099FC)
//                           : Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(23),
//                     side: userInfoViewModel.userInfoModel.gender == false
//                         ? BorderSide.none
//                         : const BorderSide(color: Color(0xFFEEF1F4), width: 1),
//                   ),
//                 ),
//                 child: const Text('남성', style: TextStyle(fontSize: 14)),
//               ),
//             ),
//             const SizedBox(width: 10),
//             SizedBox(
//               width: 73,
//               height: 33,
//               child: ElevatedButton(
//                 onPressed: () {
//                   userInfoViewModel.setGender(false);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: const Color(0xFF6E767F),
//                   backgroundColor:
//                       userInfoViewModel.userInfoModel.gender == false
//                           ? const Color(0xFF0099FC)
//                           : Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(23),
//                     side: userInfoViewModel.userInfoModel.gender == true
//                         ? BorderSide.none
//                         : const BorderSide(color: Color(0xFFEEF1F4), width: 1),
//                   ),
//                 ),
//                 child: const Text('여성', style: TextStyle(fontSize: 14)),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Widget signupCompleteBtn(
//     BuildContext context,
//     UserInfoViewModel userInfoViewModel,
//     IsloginViewModel isloginViewModel,
//     TextEditingController nameController,
//     TextEditingController ageController) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: ElevatedButton(
//       onPressed: () async {
//         userInfoViewModel.setName(nameController.text);
//         userInfoViewModel.setAge(int.parse(ageController.text));
//         isloginViewModel.login();
//         Navigator.popUntil(context, (route) => route.isFirst);
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF0099FC),
//         minimumSize: const Size(390, 48),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(26),
//         ),
//       ),
//       child: const Text(
//         '완료',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 16,
//           fontFamily: 'Pretendard',
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     ),
//   );
// }

// Widget testbtn(UserInfoViewModel userInfoViewModel) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 10.0),
//     child: InkWell(
//       onTap: () async {
//         print(userInfoViewModel.userInfoModel.gender);
//         print(userInfoViewModel.userInfoModel.age);
//         print(userInfoViewModel.userInfoModel.name);
//       },
//       child: Container(
//         width: 100,
//         height: 55,
//         clipBehavior: Clip.antiAlias,
//         decoration: ShapeDecoration(
//           color: const Color(0xFF000000),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(41),
//           ),
//         ),
//       ),
//     ),
//   );
// }
