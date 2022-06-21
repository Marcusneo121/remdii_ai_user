// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fyp/DB_Models/Products.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';
// import 'package:fyp/constants.dart';
//
// class Details extends StatefulWidget {
//   final Product product;
//   const Details({
//     Key? key,
//     required this.product,
//   }) : super(key: key);
//
//   @override
//   State<Details> createState() => _DetailsState();
// }
//
// class _DetailsState extends State<Details> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             widget.product.name,
//             // product.name,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontFamily: 'Lato',
//               fontWeight: FontWeight.w800,
//               fontSize: 20.0,
//             ),
//           ),
//           SizedBox(
//             height: 8.0,
//           ),
//           Text(
//             widget.product.stock,
//             // product.stock,
//             style: TextStyle(
//               fontFamily: 'Lato',
//               fontWeight: FontWeight.w800,
//               fontSize: 14.0,
//               color: buttonColor,
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 "RM ${widget.product.price.toStringAsFixed(2)}",
//                 style: TextStyle(
//                   fontFamily: 'Lato',
//                   fontWeight: FontWeight.w800,
//                   fontSize: 17.0,
//                 ),
//               ),
//               Spacer(),
//               Expanded(
//                 child: SpinBox(
//                   value: 1,
//                   readOnly: true,
//                   min: 1,
//                   max: 10,
//                 ),
//               ),
//               // IconButton(
//               //   icon: Icon(
//               //     Icons.horizontal_rule,
//               //     color: buttonColor,
//               //   ),
//               //   onPressed: () {},
//               // ),
//               // Container(
//               //   // margin: const EdgeInsets.symmetric(horizontal: 5),
//               //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               //   decoration: BoxDecoration(
//               //     border: Border.all(color: hintColor.withOpacity(0.4)),
//               //     borderRadius: BorderRadius.circular(12),
//               //   ),
//               //   child: Text(
//               //     "1",
//               //     style: TextStyle(
//               //       fontFamily: 'Lato',
//               //       fontWeight: FontWeight.w800,
//               //       fontSize: 14.0,
//               //       color: buttonColor,
//               //     ),
//               //   ),
//               // ),
//               // IconButton(
//               //   icon: Icon(
//               //     Icons.add,
//               //     color: buttonColor,
//               //   ),
//               //   onPressed: () {},
//               // ),
//
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
