import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';

class PaymentInfoScreen extends StatelessWidget {
  const PaymentInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Delivery and Return",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(payment_info[index]),
          itemCount: payment_info.length,
        ),
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> payment_info = <Entry>[
  Entry(
    'Delivery',
    <Entry>[
      // Entry(
      //   'All orders shipped with UPS Express.',
      // ),
      Entry('Always free shipping for orders over RM 250.'),
      Entry('All orders are shipped with a UPS tracking number.'),
    ],
  ),
  Entry(
    'Returns',
    <Entry>[
      Entry(
        'Items returned within 14 days of their original shipment date in same as new condition will be eligible for a full refund or store credit.',
      ),
      Entry(
          'Refunds will be charged back to the original form of payment used for purchase.'),
      Entry(
          'Customer is responsible for shipping charges when making returns and shipping/handling fees of original purchase is non-refundable.'),
      Entry('All sale items are final purchases.'),
    ],
  ),
  Entry(
    'Help',
    <Entry>[
      Entry(
        'Give us a shout if you have any other questions and/or concerns.',
      ),
      Entry('Email: contact@domain.com'),
      Entry('Phone: +1 (23) 456 789'),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(
          root.title,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
      );
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(
        root.title,
        style: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w800,
          fontSize: 18.0,
        ),
      ),
      textColor: buttonColor,
      iconColor: buttonColor,
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
