class Product {
  final String prod_img, name, prod_desc, add_info, stock;
  final int prod_id, series_id;
  final double price;

  Product({
    required this.prod_img,
    required this.name,
    required this.prod_desc,
    required this.add_info,
    required this.stock,
    required this.prod_id,
    required this.series_id,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        prod_img: json['prod_img'],
        name: json['name'],
        prod_desc: json['prod_desc'],
        add_info: json['add_info'],
        stock: json['stock'],
        prod_id: int.parse(json['prod_id']),
        series_id: int.parse(json['series_id']),
        price: double.parse(json['price']));
  }
}
