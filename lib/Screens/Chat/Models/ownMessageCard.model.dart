import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class OwnMessageCard extends StatelessWidget {
  final String message;
  final String messageType;
  final String img;

  const OwnMessageCard(
      {Key? key,
        required this.message,
        required this.messageType,
        required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
        const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
        child: Align(
            alignment: (messageType == "receiver"
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (messageType == "receiver"
                      ? Colors.grey.shade200
                      : Colors.blue[200]),
                ),
                padding: EdgeInsets.all(16),
                child: GestureDetector(
                    child: Hero(
                        tag: 'imageHero',
                        child: CachedNetworkImage(imageUrl: img)
                      // Image.network(
                      //   img,
                      //   fit: BoxFit.cover,
                      // )
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DetailScreen(
                          img: img,
                        );
                      }));
                    }))));

    // return Align(
    //   alignment: Alignment.centerRight,
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(
    //       maxWidth: MediaQuery.of(context).size.width - 45,
    //     ),
    //     child: Card(
    //       elevation: 1,
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //       color: Color(0xffdcf8c6),
    //       margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    //       child: Stack(
    //         children: [
    //           Padding(
    //               padding: const EdgeInsets.only(
    //                 left: 10,
    //                 right: 30,
    //                 top: 5,
    //                 bottom: 20,
    //               ),
    //               child: Image.network(message)),
    //           Positioned(
    //             bottom: 4,
    //             right: 10,
    //             child: Row(
    //               children: [
    //                 // Text(
    //                 //   time,
    //                 //   style: TextStyle(
    //                 //     fontSize: 13,
    //                 //     color: Colors.grey[600],
    //                 //   ),
    //                 // ),
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class DetailScreen extends StatelessWidget {
  String img;

  DetailScreen({required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl: img,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
