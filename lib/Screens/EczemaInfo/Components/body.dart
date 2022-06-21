import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: double.infinity,
      // height: size.height,
      // padding: EdgeInsets.all(20.0),
      // child: SingleChildScrollView(
      //   child:Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Text(
      //         "Eczema Info Centre",
      //         style: TextStyle(
      //           fontFamily: 'Lato',
      //           fontWeight: FontWeight.w800,
      //           fontSize: 22.0,
      //         ),
      //       ),
      //       ListView.builder(
      //         shrinkWrap: true,
      //         itemCount: infos.length,
      //           itemBuilder: (BuildContext context, int index) => Container(
      //             width: size.width,
      //             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      //             child: Card(
      //               elevation: 5.0,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(0.0),
      //               ),
      //               child: Container(
      //                 width: size.width,
      //                 padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      //               ),
      //             ),
      //           )
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
