import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:mysql1/mysql1.dart';

class TrackerMainScreen extends StatefulWidget {
  const TrackerMainScreen({super.key});

  @override
  State<TrackerMainScreen> createState() => _TrackerMainScreenState();
}

class _TrackerMainScreenState extends State<TrackerMainScreen> {
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
          "Tracker",
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
        child: Center(
          child: FutureBuilder(
            future: _futureDataResults,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length > 0) {
                  return Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Container(
                              width: size.width,
                              child: Row(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
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
