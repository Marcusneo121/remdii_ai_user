import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/update_questionnaire_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePhotoScreen extends StatefulWidget {
  const UpdatePhotoScreen({Key? key}) : super(key: key);

  @override
  _UpdatePhotoScreenState createState() => _UpdatePhotoScreenState();
}

class _UpdatePhotoScreenState extends State<UpdatePhotoScreen> {
  File? _image;
  String? imagenConvertida;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    try {
      var image = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        _image = File(image!.path);
        var bytes = _image!.readAsBytesSync();
        imagenConvertida = base64.encode(bytes);
        print(bytes);
        print(imagenConvertida);
      });

      print('_image');
      print(_image);
      final url = 'http://i2hub.tarc.edu.my:8851/app';
      final request = http.MultipartRequest("POST", Uri.parse(url));
      final headers = {"Content-type": "multipart/form-data"};

      request.files.add(http.MultipartFile('image',
          _image!.readAsBytes().asStream(), _image!.lengthSync(),
          filename: _image!.path.split("/").last));

      request.headers.addAll(headers);
      final response = await request.send();
      print('done');
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update Recovery Progress",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: EdgeInsets.only(bottom: 10.0),
              //   child: Text(
              //     "Eczema Diagnosis",
              //     style: TextStyle(
              //         fontFamily: 'Lato',
              //         fontWeight: FontWeight.w800,
              //         fontSize: 22.0),
              //   ),
              // ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Instructions: \n - Focus the camera on the affected skin area. \n - Avoid blurry image.",
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0),
                ),
              ),
              SizedBox(height: 40),
              Container(
                // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                // height: 280,
                // width: double.infinity,
                // decoration: BoxDecoration(
                //   color: Color(0xFFDEDEDE),
                //   borderRadius: BorderRadius.circular(30),
                // ),
                child: _image != null
                    ? Container(
                        height: 280,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              // cover, contain,
                              image: FileImage(io.File(_image!.path)),
                            )),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        height: 280,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Color(0xFFDEDEDE),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.camera),
                          iconSize: 50,
                          color: hintColor,
                          onPressed: getImage,
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RoundedButton(
                          text: "Retake",
                          color: buttonColor2,
                          press: getImage)),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: RoundedButton(
                          text: "Continue",
                          press: () async {
                            if (_image != null) {
                              print('Storing pref for img');
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('caseImg', imagenConvertida!);
                              print('Checked!!');
                              print(prefs.getString('caseImg'));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateQuestionnaireScreen();
                                  },
                                ),
                              );
                            }else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text(
                                        'Please capture an image.'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: new Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }




                          }))
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
