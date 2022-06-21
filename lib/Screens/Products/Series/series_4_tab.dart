import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/Products.dart';
import 'package:fyp/Screens/Products/Components/product_card.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';

class PSeries4Tab extends StatefulWidget {
  const PSeries4Tab({Key? key}) : super(key: key);

  @override
  _PSeries4TabState createState() => _PSeries4TabState();
}

class _PSeries4TabState extends State<PSeries4Tab> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db
  );

  late Future _future;

  @override
  void initState() {
    _future = fetchProductData();
    super.initState();
  }

  fetchProductData() async {
    try {
      List<Product> productList = [];
      var conn = await MySqlConnection.connect(settings);
      var results = await conn.query(
          'SELECT * FROM products WHERE series_id = 4');
      //print('connected database');

      for (var row in results) {
        print('${row[0]},${row[1]}, ${row[2]}, ${row[3]}');
        print(row[0].runtimeType);print(row[1].runtimeType);print(row[2].runtimeType);
        productList.add(Product(prod_img: row[4].toString(), name: row[2], prod_desc: row[5].toString(), add_info:row[6].toString(), stock: row[7], prod_id: row[0], series_id: row[1], price: row[3]));
      }
      print(productList.length);
      await conn.close();
      return productList;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                height: size.height,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 10.0),
                // child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (context, index) =>
                              ProductCard(
                                product: snapshot.data[index],),
                          // product: productList[index],),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text('Network error'));
            // return Center(child: CircularProgressIndicator(),);
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );

    // : Center(child: CircularProgressIndicator(),);
  }
}
