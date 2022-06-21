// import 'package:flutter/material.dart';
// import 'package:fyp/DB_Models/Products.dart';
// import 'package:fyp/Screens/Products/Components/body.dart';
//
// class Header extends StatelessWidget {
//   const Header({
//     Key? key,
//     required this.product,
//   }) : super(key: key);
//
//   final Product product;
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.8,
//       child: Container(
//           decoration: BoxDecoration(
//             color: Colors.black12.withAlpha(10),
//           ),
//           child: LayoutBuilder(
//             builder: (_, constraints) {
//               return Column(
//                 children: <Widget>[
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.network(product.prod_img,
//                         // Image.asset(product.prod_img,
//                           // width: constraints.maxWidth * 0.65,
//                           // height: constraints.maxHeight * 0.9,
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               );
//             },
//           )),
//     );
//   }
// }
