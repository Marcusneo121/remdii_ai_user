import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/DB_Models/User.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/components/rounded_input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';

class EditPersonalDetails extends StatefulWidget {
  const EditPersonalDetails({Key? key}) : super(key: key);

  @override
  _EditPersonalDetailsState createState() => _EditPersonalDetailsState();
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
  // String initialValue = 'Gender';
  // var genderList = [
  //   'Gender',
  //   'Male',
  //   'Female',
  //   'Prefer not to say',
  // ];
  final formGlobalKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ICController = TextEditingController();
  final add1Controller = TextEditingController();
  final add2Controller = TextEditingController();
  final add3Controller = TextEditingController();
  String userImg = '';
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  File? _image;
  String? imagenConvertida;
  final ImagePicker _picker = ImagePicker();

  void initState() {
    // TODO: implement initState
    _future = fetchUserData();
    super.initState();
  }

  Future getImage() async {
    try {
      var image = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);

      setState(() {
        // _image = image;
        // _image = image as io.File;
        _image = File(image!.path);
        var bytes = _image!.readAsBytesSync();
        imagenConvertida = base64.encode(bytes);
        print('this is byte ${bytes}');
        print('this is string ${imagenConvertida} end here.');
      });
      print('_image');
      print(_image);
      print('done');
      EasyLoading.showInfo(
        'Please press save to ensure information is updated.',
        duration: Duration(seconds: 3),
      );
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<User> user = [];
      var conn = await MySqlConnection.connect(settings);
      print(prefs.getInt('userID'));

      setState(() {
        userImg = prefs.getString('userImg').toString();
      });

      print(userImg);

      if (prefs.getInt('userID') != null) {
        var results = await conn.query(
            'SELECT * FROM customer WHERE user_id = ?',
            [prefs.getInt('userID').toString()]);
        print(results);
        for (var row in results) {
          user.add(User(
            user_name: row[1].toString(),
            user_email: row[2].toString(),
            user_id: row[0],
            user_phone: row[4].toString(),
            user_ic: row[5].toString(),
            user_add_1: row[6].toString(),
            user_add_2: row[7].toString(),
            user_add_3: row[8],
            user_img: row[9].toString(),
          ));

          setState(() {
            nameController.text = row[1].toString();
            emailController.text = row[2].toString();
            phoneController.text = row[4].toString();
            ICController.text = row[5].toString();
            add1Controller.text = row[6].toString();
            add2Controller.text = row[7].toString();
            add3Controller.text = row[8].toString();
          });
        }

        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Edit Personal Details",
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w800,
                fontSize: 22.0),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Container(
                  height: size.height,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formGlobalKey,
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(children: [
                              Container(
                                child: _image != null
                                    ? Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              // cover, contain,
                                              image: FileImage(
                                                  io.File(_image!.path)),
                                            )),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: snapshot
                                                    .data[0].user_img ==
                                                null
                                            ? Image.memory(
                                                base64
                                                    .decode(userImg.toString()),
                                                fit: BoxFit.fill,
                                                width: 90.0,
                                                height: 90.0,
                                              ).image
                                            : Image.memory(
                                                base64.decode(
                                                    snapshot.data[0].user_img),
                                                fit: BoxFit.fill,
                                                width: 90.0,
                                                height: 90.0,
                                              ).image,
                                        radius: 80.0,
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 1,
                                //child: buildEditIcon(color),
                                child: ClipOval(
                                  child: InkWell(
                                    onTap: () {
                                      getImage();
                                      //getImage();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      color: Colors.white,
                                      child: ClipOval(
                                        child: Container(
                                          padding: EdgeInsets.all(7),
                                          color: Color(0xFF42995C),
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            // CircleAvatar(
                            //   backgroundImage: snapshot.data[0].user_img == null
                            //       ? Image.memory(
                            //           base64.decode(userImg.toString()),
                            //           fit: BoxFit.fill,
                            //           width: 100.0,
                            //           height: 100.0,
                            //         ).image
                            //       : Image.memory(
                            //           base64.decode(snapshot.data[0].user_img),
                            //           fit: BoxFit.fill,
                            //           width: 100.0,
                            //           height: 100.0,
                            //         ).image,
                            //   radius: 80.0,
                            // ),
                            SizedBox(height: 20),
                            RoundedInputField(
                              //initialValue: snapshot.data[0].user_name,
                              icon: Icons.person,
                              onChanged: (value) {},
                              validator: validateName,
                              hintText: 'Full Name',
                              enableMode: true,
                              controller: nameController,
                            ),
                            // PretypedRoundedInputField(
                            //   initialValue: "Blue_shirt_guy",
                            //   icon: Icons.person_pin_rounded,
                            //   onChanged: (value) {},
                            //   validator: (String? value) {  },
                            //   hintText: '',
                            // ),
                            RoundedInputField(
                              // initialValue: snapshot.data[0].user_email,
                              icon: Icons.email_outlined,
                              onChanged: (value) {},
                              validator: (String? value) {},
                              hintText: 'Email',
                              enableMode: false,
                              controller: emailController,
                            ),
                            RoundedInputField(
                              //initialValue: snapshot.data[0].user_phone,
                              icon: Icons.local_phone,
                              onChanged: (value) {},
                              validator: validatePhone,
                              hintText: 'Phone Number',
                              enableMode: true,
                              controller: phoneController,
                            ),
                            // RoundedInputField(
                            //   //initialValue: snapshot.data[0].user_ic,
                            //   icon: Icons.badge,
                            //   onChanged: (value) {},
                            //   validator: validateIC,
                            //   hintText: 'IC Number',
                            //   enableMode: true,
                            //   controller: ICController,
                            // ),
                            // RoundedInputField(
                            //   //initialValue: snapshot.data[0].user_add_1,
                            //   icon: Icons.location_on,
                            //   onChanged: (value) {},
                            //   validator: validateAddress,
                            //   hintText: 'Address Line 1',
                            //   enableMode: true,
                            //   controller: add1Controller,
                            // ),
                            // RoundedInputField(
                            //   //initialValue: snapshot.data[0].user_add_2,
                            //   icon: Icons.location_on,
                            //   onChanged: (value) {},
                            //   validator: validateAddress,
                            //   hintText: 'Address Line 2',
                            //   enableMode: true,
                            //   controller: add2Controller,
                            // ),
                            // RoundedInputField(
                            //     //initialValue: snapshot.data[0].user_add_3,
                            //     icon: Icons.location_on,
                            //     onChanged: (value) {},
                            //     validator: validateAddress,
                            //     hintText: 'Address Line 3',
                            //     enableMode: true,
                            //     controller: add3Controller),
                            // Align(
                            //     alignment: Alignment(0.02, 1.0),
                            //   child: Icon(
                            //     Icons.ice_skating
                            //   )
                            // ),
                            // Container(
                            //   margin: EdgeInsets.symmetric(vertical: 10),
                            //   width: size.width * 0.8,
                            //   height: 52,
                            //   //gives the height of the dropdown button
                            //   //gives the width of the dropdown button
                            //   decoration: BoxDecoration(
                            //     color: kPrimaryColor,
                            //     borderRadius: BorderRadius.circular(29),
                            //   ),
                            //
                            //   padding: const EdgeInsets.only(left: 45, right: 15), //you can include padding to control the menu items
                            //   child: Theme(
                            //     data: Theme.of(context).copyWith(
                            //       canvasColor: kPrimaryColor,
                            //       // background color for the dropdown items
                            //       buttonTheme: ButtonTheme.of(context).copyWith(
                            //         alignedDropdown:
                            //         true, //If false (the default), then the dropdown's menu will be wider than its button.
                            //       ),
                            //     ),
                            //     child: DropdownButtonHideUnderline(
                            //       // to hide the default underline of the dropdown button
                            //       child: DropdownButton<String>(
                            //         icon: Icon(
                            //           Icons.keyboard_arrow_down,
                            //           color: hintColor,
                            //         ),
                            //         // icon color of the dropdown button
                            //         items: genderList.map((String value) {
                            //           return DropdownMenuItem<String>(
                            //             value: value,
                            //             child: Text(
                            //               value,
                            //               style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                            //             ),
                            //           );
                            //         }).toList(),
                            //         hint: Text(
                            //           initialValue,
                            //           style:
                            //           TextStyle(color: hintColor, fontSize: 15),
                            //         ),
                            //         // setting hint
                            //         onChanged: (String? newValue) {
                            //           setState(() {
                            //             initialValue = newValue!; // saving the selected value
                            //           });
                            //         },
                            //         value: initialValue, // displaying the selected value
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 20.0),
                            RoundedButton(
                              text: "Save",
                              press: () async {
                                // print(nameController.text);
                                // print(emailController.text);
                                // print(phoneController.text);
                                // print(ICController.text);
                                // print(add1Controller.text);
                                // print(add2Controller.text);
                                // print(add3Controller.text);
                                if (formGlobalKey.currentState!.validate()) {
                                  formGlobalKey.currentState!.save();
                                  var conn =
                                      await MySqlConnection.connect(settings);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await conn.query(
                                      'UPDATE customer SET user_name = ?, user_phone = ?, user_ic = ?, user_add_1 = ?, '
                                      'user_add_2 = ?, user_add_3 = ? , user_img = ? WHERE user_id = ?',
                                      [
                                        nameController.text,
                                        phoneController.text,
                                        ICController.text,
                                        add1Controller.text,
                                        add2Controller.text,
                                        add3Controller.text,
                                        imagenConvertida.toString(),
                                        prefs.getInt('userID')
                                      ]);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: new Text(
                                            'Your changes have been saved successfully.'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: new Text("Back to Home"),
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          HomepageScreen(),
                                                ),
                                                (route) => false,
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Center(child: Text('Network error'));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  String? validateName(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your name is required";
      return _msg;
    }
    return null;
  }

  String? validatePhone(String? value) {
    String _msg = '';
    RegExp regex = new RegExp(r'(^01[0-9]{8,9}$)');
    if (value!.isEmpty) {
      _msg = "Your phone number is required";
      return _msg;
    } else if (!regex.hasMatch(value)) {
      _msg =
          "Please provide a valid phone number with \nthe given format (0123456789)";
      // phoneController.text = '';
      return _msg;
    }
    return null;
  }

  String? validateIC(String? value) {
    String _msg = '';
    RegExp regex = new RegExp(r'(^[0-9]{6}-[0-9]{2}-[0-9]{4}$)');
    if (value!.isEmpty) {
      _msg = "Your IC number is required";
      return _msg;
    } else if (!regex.hasMatch(value)) {
      _msg =
          "Please provide a valid IC number with the format \n(XXXXXX-XX-XXXX)";
      // ICController.text = '';
      return _msg;
    }
    return null;
  }

  String? validateAddress(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your address is required";
      return _msg;
    }
    return null;
  }
}
