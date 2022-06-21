import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/Info.dart';
import 'package:fyp/Screens/EczemaInfo/Components/expandable.dart';
import 'package:fyp/constants.dart';

class EInfoDetails extends StatefulWidget {
  final Info info;

  const EInfoDetails({Key? key, required this.info}) : super(key: key);

  @override
  _EInfoDetailsState createState() => _EInfoDetailsState();
}

class _EInfoDetailsState extends State<EInfoDetails> {
  late List<String> img_list;

  @override
  void initState() {
    img_list = [];
    splitImg();
  }

  splitImg() {
    img_list = widget.info.info_img_list.split(', ');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  autoPlay: true,
                  disableCenter: false,
                ),
                items: img_list
                    .map(
                      (item) => Container(
                        child: Center(
                          child: Image.memory(
                            base64.decode(item),
                            fit: BoxFit.cover,
                            width: 2000.0,
                            height: 200.0,
                            errorBuilder:
                                (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return const Text('No more images');
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '${widget.info.info_name}'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Expandable(
                title: "Description",
                desc: widget.info.info_des,
                // desc: product.add_info,
              ),
              Divider(
                color: kPrimaryColor,
                indent: 15,
                endIndent: 15,
              ),
              Expandable(
                title: "Causes",
                desc: widget.info.info_cse,
                // desc: product.add_info,
              ),
              Divider(
                color: kPrimaryColor,
                indent: 15,
                endIndent: 15,
              ),
              Expandable(
                title: "Symptoms",
                desc: widget.info.info_symp,
                // desc: product.add_info,
              ),
              Divider(
                color: kPrimaryColor,
                indent: 15,
                endIndent: 15,
              ),
              Expandable(
                title: "Treatments",
                desc: widget.info.info_trmt,
                // desc: product.add_info,
              ),
              Divider(
                color: kPrimaryColor,
                indent: 15,
                endIndent: 15,
              ),
              Expandable(
                title: "Additional Information",
                desc: widget.info.info_addInfo,
                // desc: product.add_info,
              ),
              // ListView.builder(
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemBuilder: (BuildContext context, int index) =>
              //       DataPopUp(data[index]),
              //   itemCount: data.length,
              //   padding: EdgeInsets.symmetric(vertical: 15.0),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// final List<EczemaInfo> data = <EczemaInfo>[
//   EczemaInfo(
//     'Description',
//     <EczemaInfo>[
//       EczemaInfo(
//         'Often called eczema or atopic eczema, this is a condition that usually develops by 5 years of age and causes extremely itchy rashes that come and go. Atopic dermatitis (AD) is common worldwide. People of all ages from newborns to adults 65 years of age and older live with this condition. Symptoms range from excessively dry, itchy skin to painful, itchy rashes that cause sleepless nights and interfere with everyday life.',
//       ),
//     ],
//   ),
//   EczemaInfo(
//     'Prevention/Self-care',
//     <EczemaInfo>[
//       EczemaInfo(
//           'Moisturize after bathing and when your skin feels dry. Keeping your skin hydrated helps form a barrier between you and the world. To avoid irritating your skin, use a fragrance-free cream or ointment instead of a lotion.'),
//       EczemaInfo(
//           'Choose fragrance-free skin care products. Fragrance can cause an AD flare-up. To avoid this, only use products labeled “fragrance free.” You may see the word “unscented” on a product label. Avoid these, too. Unscented means that the fragrance has been masked. Although you won’t smell the fragrance in an unscented product, a masked fragrance can still trigger a flare-up.'),
//       EczemaInfo(
//           'Test all skin care products before using them. While fragrance often causes AD to flare, other ingredients in skin care products can also cause a flare-up. To test a product, apply a small amount to skin without AD. Leave it on your skin for 24 hours. If your skin remains clear after 24 hours, it’s less likely to cause a flare-up.'),
//     ],
//   ),
//   EczemaInfo(
//     'Treatments',
//     <EczemaInfo>[
//       EczemaInfo(
//           'Bathing'),
//       EczemaInfo(
//           'Applying moisturizer'),
//       EczemaInfo(
//           'Being gentle with your skin'),
//     ],
//   ),
//   EczemaInfo(
//     'Symptoms',
//     <EczemaInfo>[
//       EczemaInfo(
//           'AD causes itchy skin. No matter your age or where the AD appears on your skin, AD tends to itch.'),
//     ],
//   ),
// ];
//
// class EczemaInfo {
//   EczemaInfo(this.info_title, [this.info_details = const <EczemaInfo>[]]);
//
//   final String info_title;
//   final List<EczemaInfo> info_details;
// }
//
// class DataPopUp extends StatelessWidget {
//   const DataPopUp(this.popup);
//
//   final EczemaInfo popup;
//
//   Widget _buildTiles(EczemaInfo root) {
//     bool isExpanded = false;
//     if (root.info_details.isEmpty)
//       return ListTile(
//           title: Text(
//             root.info_title,
//             textAlign: TextAlign.justify,
//             style: TextStyle(
//               fontFamily: 'Lato',
//               fontWeight: FontWeight.w800,
//               fontSize: 16.0,
//             ),
//           ),
//           contentPadding:
//               EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0));
//     return ExpansionTile(
//       key: PageStorageKey<EczemaInfo>(root),
//       title: Text(
//         root.info_title,
//         style: TextStyle(
//           fontFamily: 'Lato',
//           fontWeight: FontWeight.w800,
//           fontSize: 18.0,
//         ),
//       ),
//       textColor: buttonColor,
//       iconColor: buttonColor,
//       children: root.info_details.map(_buildTiles).toList(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildTiles(popup);
//   }
// }
