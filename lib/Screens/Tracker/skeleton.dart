import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:mysql1/mysql1.dart';

class SkeletonBackup extends StatefulWidget {
  const SkeletonBackup({super.key});

  @override
  State<SkeletonBackup> createState() => _SkeletonBackupState();
}

class _SkeletonBackupState extends State<SkeletonBackup> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _futureDataResults;

  @override
  void initState() {
    // TODO: implement initState
    _futureDataResults = fetchYearData();
    super.initState();
  }

  fetchYearData() async {
    try {} catch (e) {
      print("Error message : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Backup Skeleton",
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w800,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: FutureBuilder(
            future: _futureDataResults,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length > 0) {
                } else {
                  return Center(
                      child: Text('Your order history is empty now.'));
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
