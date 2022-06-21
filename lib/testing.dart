// import 'dart:convert';
// import 'dart:io';
// import 'package:dropdownfield/dropdownfield.dart';
// import 'package:flutter/material.dart';
// import 'package:fyp_admin1/Screens/Home/home_screen.dart';
// import 'package:fyp_admin1/components/rectangular_input_field.dart';
// import 'package:fyp_admin1/components/rounded_button.dart';
// import 'package:mysql1/mysql1.dart';
// import 'package:fyp_admin1/DB_Models/connection.dart';
// import '../../constants.dart';
// import 'package:image_picker/image_picker.dart';
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   final formGlobalKey = GlobalKey<FormState>();
//
//   List<String> series = [
//     "REMDII® Sensitive Series",
//     "REMDII® Skincare Series",
//     "REMDII® Care Series",
//     "REMDII® Aurora Gentle Protection Series",
//     "Aurora",
//     "Others"
//   ];
//
//   List<String> stock = [
//     "In Stock",
//     "Out of Stock",
//   ];
//
//   String selectSeries = "";
//
//   String selectStock = "";
//
//   final seriesController = TextEditingController();
//   final nameController = TextEditingController();
//   final priceController = TextEditingController();
//   final prodImgController = TextEditingController();
//   final prodDescController = TextEditingController();
//   final addInfoController = TextEditingController();
//   final stockController = TextEditingController();
//
//   bool visible = false;
//
//   var settings = new ConnectionSettings(
//       host: connection.host,
//       port: connection.port,
//       user: connection.user,
//       password: connection.pw,
//       db: connection.db);
//
//   Future addProduct() async {
//     String name = nameController.text;
//     String series_id = '';
//     String price = priceController.text;
//     //String prod_img = prodImgController.text;
//     String prod_desc = prodDescController.text;
//     String add_info = addInfoController.text;
//     String stock = stockController.text;
//
//     try {
//       var conn = await MySqlConnection.connect(settings);
//       var results =
//           await conn.query('SELECT * FROM products WHERE name = ?', [name]);
//       if (results.isEmpty) {
//         var getSeries = await conn.query(
//             'SELECT series_id FROM prodseries WHERE name = ?',
//             [seriesController.text]);
//
//         for (var row in getSeries) {
//           series_id = row[0].toString();
//         }
//
//         var insertResult = await conn.query(
//             'insert into products (series_id, name, price, prod_img, prod_desc, add_info, stock, img) values (?, ?, ?, ?, ?, ?, ?, "-")',
//             [series_id, name, price, prod_img, prod_desc, add_info, stock]);
//
//         await conn.close();
//
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: new Text('Product has been successfully added'),
//               actions: <Widget>[
//                 FlatButton(
//                   child: new Text("OK"),
//                   onPressed: () {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (BuildContext context) => HomeScreen(),
//                       ),
//                       (route) => false,
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: new Text('This product already exist.'),
//               actions: <Widget>[
//                 FlatButton(
//                   child: new Text("OK"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   final ImagePicker _picker = ImagePicker();
//
//   XFile? _image;
//   String? prod_img;
//
//   // String? imagenConvertida;
//
//   void selectImages() async {
//     // XFile? image = await ImagePicker().pickImage(
//     //     source: ImageSource.gallery, imageQuality: 50);
//     String? imagenConvertida;
//     imagenConvertida = "";
//
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (image!.length() != 0) {
//       _image = XFile(image.path);
//       var bytes = _image!.readAsBytes();
//       imagenConvertida = base64.encode(await bytes);
//       print(imagenConvertida);
//       prod_img = imagenConvertida;
//     }
//
//     setState(() {});
//   }
//
//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         selectImages();
//                         Navigator.of(context).pop();
//                       }),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Add Product",
//           style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Lato',
//               fontSize: 22.0,
//               color: Colors.grey[600]),
//         ),
//         iconTheme: IconThemeData(color: Colors.grey[600]),
//         actions: <Widget>[],
//         backgroundColor: Colors.white,
//         foregroundColor: hintColor,
//         bottomOpacity: 0.0,
//         elevation: 0.0,
//       ),
//       body: Container(
//         width: double.infinity,
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//             child: Form(
//               key: formGlobalKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {
//                       _showPicker(context);
//                     },
//                     child: Center(
//                       child: _image != null
//                           ? Container(
//                               width: size.width * 1.0,
//                               height: size.height * 0.4,
//                               child: Image.file(
//                                 File(_image!.path),
//                                 //width: 110,
//                                 //height: 100,
//                                 fit: BoxFit.fill,
//                               ),
//                             )
//                           : Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[200],
//                               ),
//                               width: size.width * 1.0,
//                               height: size.height * 0.4,
//                               child: Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.grey[800],
//                                 size: 50,
//                               ),
//                             ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     'Series',
//                     style: TextStyle(
//                         fontFamily: 'Lato',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   DropDownField(
//                     controller: seriesController,
//                     hintText: "Select a series",
//                     enabled: true,
//                     itemsVisibleInDropdown: 6,
//                     items: series,
//                     onValueChanged: (value) {
//                       selectSeries = value;
//                     },
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     'Product Name',
//                     style: TextStyle(
//                         fontFamily: 'Lato',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16),
//                   ),
//                   RectangularInputField(
//                     onChanged: (value) {},
//                     validator: validateName,
//                     height: size.height * 0.08,
//                     controller: nameController,
//                   ),
//                   Text(
//                     'Price (RM)',
//                     style: TextStyle(
//                         fontFamily: 'Lato',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16),
//                   ),
//                   RectangularInputField(
//                     onChanged: (value) {},
//                     validator: validatePrice,
//                     height: size.height * 0.08,
//                     controller: priceController,
//                   ),
//                   Text(
//                     'Description',
//                     style: TextStyle(
//                         fontFamily: 'Lato',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16),
//                   ),
//                   RectangularInputField(
//                     onChanged: (value) {},
//                     validator: validateDescription,
//                     height: size.height * 0.5,
//                     controller: prodDescController,
//                   ),
//                   Text(
//                     'Additional Information',
//                     style: TextStyle(
//                         fontFamily: 'Lato',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16),
//                   ),
//                   RectangularInputField(
//                     onChanged: (value) {},
//                     validator: (String? value) {},
//                     height: size.height * 0.5,
//                     controller: addInfoController,
//                   ),
//                   Text(
//                     'Stock Status',
//                     style: TextStyle(
//                         fontFamily: 'Lato',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   DropDownField(
//                     controller: stockController,
//                     hintText: "Select a status",
//                     enabled: true,
//                     itemsVisibleInDropdown: 2,
//                     items: stock,
//                     onValueChanged: (value) {
//                       selectStock = value;
//                     },
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   RoundedButton(
//                     text: "Add",
//                     press: () async {
//                       if (formGlobalKey.currentState!.validate()) {
//                         formGlobalKey.currentState!.save();
//                         await addProduct();
//                       }
//                     },
//                     width: size.width * 0.9,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   String? validateName(String? value) {
//     String _msg = '';
//     if (value!.isEmpty) {
//       _msg = "Product Name cannot be empty";
//       return _msg;
//     }
//     return null;
//   }
//
//   String? validatePrice(String? value) {
//     String _msg = '';
//     RegExp regex = new RegExp(r'(^\d{9}(\.\d{2})?$)');
//     if (value!.isEmpty) {
//       _msg = "Price cannot be empty";
//       return _msg;
//     } else if (!regex.hasMatch(value)) {
//       _msg = "Please provide a valid price with \nthe given format (99.99)";
//     }
//     return null;
//   }
//
//   String? validateDescription(String? value) {
//     String _msg = '';
//     if (value!.isEmpty) {
//       _msg = "Product Description cannot be empty";
//       return _msg;
//     }
//     return null;
//   }
// }
