// import 'package:flutter/material.dart';
// import 'package:fyp/Screens/Products/Components/categories.dart';
// import 'package:fyp/Screens/Products/Components/product_card.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);
//   @override
//   State<Body> createState() => _BodyState();
// }
//
// class Product {
//   final String prod_img, name, prod_desc, add_info, stock;
//   final String prod_id, series_id;
//   final double price;
//
//   Product({
//     required this.prod_img,
//     required this.name,
//     required this.prod_desc,
//     required this.add_info,
//     required this.stock,
//     required this.prod_id,
//     required this.series_id,
//     required this.price,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//         prod_img: json['prod_img'],
//         name: json['name'],
//         prod_desc: json['prod_desc'],
//         add_info: json['add_info'],
//         stock: json['stock'],
//         prod_id: json['prod_id'],
//         series_id: json['series_id'],
//         price: double.parse(json['price']));
//   }
// }
//
// class _BodyState extends State<Body> {
//   final String apiURL =
//       'https://remdii-lipidware.000webhostapp.com/read_products_data.php';
//   late List<Product> productList;
//   late bool _hasData;
//
//   @override
//   void initState() {
//     _hasData = false;
//     fetchProductData();
//     super.initState();
//   }
//
//    fetchProductData() async {
//     final response = await http.get(Uri.parse(apiURL));
//
//     if (response.statusCode == 200) {
//       final items = json.decode(response.body).cast<Map<String, dynamic>>();
//
//       List<Product> products = items.map<Product>((json) {
//         return Product.fromJson(json);
//       }).toList();
//
//       print(products[0].name);
//       print(products[1].name);
//       print(products[2].name);
//       print(products[3].name);
//       print(products[4].name);
//       print(products[3].price);
//       print(products[4].price);
//       print(products.length);
//
//       setState(() {
//         _hasData = true;
//         productList = products;
//       });
//     } else {
//       throw Exception('Failed to load data from Server.');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return _hasData == true? Container(
//       width: double.infinity,
//       height: size.height,
//       padding: EdgeInsets.all(10.0),
//       // child: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: GridView.builder(
//                 itemCount: productList.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 20.0,
//                   crossAxisSpacing: 20.0,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemBuilder: (context, index) => ProductCard(
//                     //product: snapshot.data![index],
//                    product: productList[index],),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ): Center(child: CircularProgressIndicator(),);
//   }
// }
