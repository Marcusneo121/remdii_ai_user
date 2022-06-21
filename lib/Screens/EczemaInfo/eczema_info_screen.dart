import 'package:flutter/material.dart';
import 'package:fyp/Models/eczema_info.dart';
import 'package:fyp/Screens/EczemaInfo/view_info_screen.dart';

class EInfoScreen extends StatelessWidget {
  //const EInfoScreen({Key? key}) : super(key: key);


  //const EInfoScreen({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Products"),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   foregroundColor: hintColor,
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      // ),
      body: ViewInfoScreen(),
    );
  }
}
