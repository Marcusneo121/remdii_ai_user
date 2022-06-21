// import 'package:flutter/material.dart';
// import 'package:fyp/constants.dart';
//
// class Categories extends StatefulWidget {
//   const Categories({Key? key}) : super(key: key);
//
//   @override
//   _CategoriesState createState() => _CategoriesState();
// }
//
// class _CategoriesState extends State<Categories> {
//   List<String> categories = [
//     "Sensitive Series",
//     "Skincare Series",
//     "Care Series",
//     "Aurora Gentle Protection Series",
//     "Aurora Series"
//   ];
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: SizedBox(
//         height: 25,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: categories.length,
//           itemBuilder: (context, index) => buildCategory(index),
//         ),
//       ),
//     );
//   }
//
//   Widget buildCategory(int index) {
//     return GestureDetector(
//       onTap: (){
//         setState(() {
//           selectedIndex = index;
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               categories[index],
//               style: TextStyle(
//                 fontFamily: 'Lato',
//                 fontWeight: FontWeight.w800,
//                 fontSize: 18.0,
//                 color: selectedIndex == index? Colors.black : hintColor,
//               ),
//             ),
//             Container(
//               height: 2,
//               width: 80,
//               color: selectedIndex == index? buttonColor : Colors.transparent,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }