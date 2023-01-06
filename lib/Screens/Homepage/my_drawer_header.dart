import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/User.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'dart:convert';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  @override
  void initState() {
    _future = fetchUserData();
    super.initState();
  }

  fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<User> user = [];
      var conn = await MySqlConnection.connect(settings);
      print(prefs.getInt('userID'));
      if (prefs.getInt('userID') != null) {
        var results = await conn.query(
            'SELECT * FROM customer WHERE user_id = ?',
            [prefs.getInt('userID').toString()]);
        //print(results);

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
        }
        await conn.close();
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.only(top: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                  color: buttonColorLight,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: Image.memory(
                          base64.decode(snapshot.data[0].user_img),
                          fit: BoxFit.fill,
                          width: 100.0,
                          height: 100.0,
                        ).image,
                        radius: 80.0,
                      ),
                    ),
                    // Container(
                    //   child: Container(
                    //     margin: EdgeInsets.only(bottom: 10.0),
                    //     height: 120,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //         image: Image.memory(
                    //           base64.decode(snapshot.data[0].user_img),
                    //           fit: BoxFit.fill,
                    //           width: 100.0,
                    //           height: 100.0,
                    //         ).image,
                    //         //image: AssetImage('assets/images/profile.jpg'),
                    //       ),
                    //     ),
                    //     // child: Image.memory(
                    //     //   base64.decode(snapshot.data[0].user_img),
                    //     //   fit: BoxFit.fill,
                    //     //   width: 110.0,
                    //     //   height: 110.0,
                    //     // ),
                    //   ),
                    // ),
                    Text(
                      snapshot.data[0].user_name,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text('Network error'));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
