import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/Info.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/Screens/EczemaInfo/eczema_info_details_screen.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:mysql1/mysql1.dart';

class ViewInfoScreenAfterResult extends StatefulWidget {
  const ViewInfoScreenAfterResult({Key? key}) : super(key: key);

  @override
  _ViewInfoScreenAfterResultState createState() =>
      _ViewInfoScreenAfterResultState();
}

class _ViewInfoScreenAfterResultState extends State<ViewInfoScreenAfterResult> {
  //List<Info> info = infos;
  // final String apiURL =
  //     'https://remdii-lipidware.000webhostapp.com/Eczema_Info/read_all_info.php';
  // late List<Info> infoList = [];
  // late bool _hasData;
  // late List<String> img_list;
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  @override
  void initState() {
    _future = fetchInfoData();
    // splitImg();
    super.initState();
  }

  fetchInfoData() async {
    try {
      List<Info> infoList = [];
      var conn = await MySqlConnection.connect(settings);
      var results = await conn.query('SELECT * FROM eczemainfo');
      //print('connected database');

      for (var row in results) {
        print('${row[0]},${row[1]}, ${row[2]}, ${row[3]}');
        print(row[0].runtimeType);
        print(row[1].runtimeType);
        print(row[2].runtimeType);
        infoList.add(Info(
            info_id: row[0].toString(),
            info_name: row[1].toString(),
            info_des: row[2].toString(),
            info_cse: row[3].toString(),
            info_symp: row[4].toString(),
            info_trmt: row[5].toString(),
            info_addInfo: row[6].toString(),
            info_img_list: row[7].toString()));
      }
      print(infoList.length);
      await conn.close();
      return infoList;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: Text(
          "Eczema Info Centre",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
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
                  width: double.infinity,
                  height: size.height,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   padding: EdgeInsets.only(bottom: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "Eczema Info Centre",
                      //         style: TextStyle(
                      //             fontFamily: 'Lato',
                      //             fontWeight: FontWeight.w800,
                      //             fontSize: 22.0),
                      //       ),
                      //       InkWell(
                      //         child: Text(
                      //           "Back to Home",
                      //           style: TextStyle(
                      //               fontFamily: 'Lato',
                      //               fontWeight: FontWeight.w600,
                      //               color: Color(0xFF42995C),
                      //               fontSize: 15.0),
                      //         ),
                      //         onTap: () {
                      //           Navigator.pushAndRemoveUntil(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) {
                      //                 return Homepage();
                      //               },
                      //             ),
                      //             (route) => false,
                      //           );
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            width: size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EInfoDetails(
                                        info: snapshot.data[index],
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRect(
                                      child: Image.memory(
                                        base64.decode(
                                            '${snapshot.data[index].info_img_list.split(',')[0]}'),
                                        fit: BoxFit.cover,
                                        width: 2000.0,
                                        height: 200.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data[index].info_name}'
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16.0),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  '${snapshot.data[index].info_des}',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
          }),
    );

    // : Center(
    //     child: CircularProgressIndicator(),
    //   );
  }
}

// class EInfoScreen extends StatelessWidget {
//   //const EInfoScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text("Eczema Info"),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.white,
//       //   foregroundColor: hintColor,
//       //   bottomOpacity: 0.0,
//       //   elevation: 0.0,
//       // ),
//       body: Body(),
//     );
//   }
// }
