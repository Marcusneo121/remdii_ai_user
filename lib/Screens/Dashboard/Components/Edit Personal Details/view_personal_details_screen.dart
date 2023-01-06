import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/User.dart';
import 'package:fyp/Screens/Dashboard/Components/Edit%20Personal%20Details/change_pw_screen.dart';
import 'package:fyp/Screens/Dashboard/Components/Edit%20Personal%20Details/edit_personal_details_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPersonalDetails extends StatefulWidget {
  const ViewPersonalDetails({Key? key}) : super(key: key);

  @override
  _ViewPersonalDetailsState createState() => _ViewPersonalDetailsState();
}

class _ViewPersonalDetailsState extends State<ViewPersonalDetails> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  @override
  void initState() {
    // TODO: implement initState
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "View Personal Details",
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w800,
                fontSize: 22.0),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: hintColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditPersonalDetails();
                    },
                  ),
                );
              },
            )
          ],
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
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                          radius: 80.0,
                        ),
                        Divider(
                          // the horizontal line
                          color: Colors.grey[800],
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'NAME',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                              color: buttonColor,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data[0].user_name,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child:
                        //   Text(
                        //     'USERNAME',
                        //     style: TextStyle(
                        //       fontFamily: 'Lato',
                        //       fontWeight: FontWeight.w800,
                        //       fontSize: 16.0,
                        //       color: buttonColor,
                        //       letterSpacing: 2.0,
                        //     ),
                        //   ),
                        // ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     'Blue_shirt_guy',
                        //     style: TextStyle(
                        //       fontFamily: 'Lato',
                        //       fontWeight: FontWeight.w800,
                        //       fontSize: 18.0,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 15.0,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'EMAIL',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                              color: buttonColor,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data[0].user_email,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // SizedBox(height: 15.0,),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child:
                        //   Text(
                        //     'GENDER',
                        //     style: TextStyle(
                        //       fontFamily: 'Lato',
                        //       fontWeight: FontWeight.w800,
                        //       fontSize: 16.0,
                        //       color: buttonColor,
                        //       letterSpacing: 2.0,
                        //     ),
                        //   ),
                        // ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     'Male',
                        //     style: TextStyle(
                        //       fontFamily: 'Lato',
                        //       fontWeight: FontWeight.w800,
                        //       fontSize: 18.0,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'PHONE NUMBER',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                              color: buttonColor,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data[0].user_phone,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'IC NUMBER',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                              color: buttonColor,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data[0].user_ic,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ADDRESS',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                              color: buttonColor,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data[0].user_add_1 +
                                snapshot.data[0].user_add_2 +
                                snapshot.data[0].user_add_3,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RoundedButton(
                          text: "Change Password",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangePWScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
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
}
