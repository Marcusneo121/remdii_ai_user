import 'package:flutter/material.dart';
import 'package:fyp/Screens/EczemaDiagnosis/Components/body.dart';

class EDiagnosisScreen extends StatelessWidget {
  //const EDiagnosisScreen({Key? key}) : super(key: key);

  //we are using FVM 2.2.6

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Eczema Management",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Body(),
    );
  }
}
