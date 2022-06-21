import 'package:flutter/material.dart';
import 'package:fyp/Screens/Dashboard/Components/body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   foregroundColor: hintColor,
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      // ),
      body: Body(),
    );
  }
}
