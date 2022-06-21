class User {
  final int user_id;
  final String user_name,
      user_email,
      user_phone,
      user_ic,
      user_add_1,
      user_add_2,
      user_add_3;

  User({
    required this.user_id,
    required this.user_name,
    required this.user_email,
    required this.user_phone,
    required this.user_ic,
    required this.user_add_1,
    required this.user_add_2,
    required this.user_add_3,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        user_id: int.parse(json['user_id']),
        user_name: json['user_name'],
        user_email: json['user_email'],
        user_phone: json['user_phone'],
        user_ic: json['user_ic'],
        user_add_1: json['user_add_1'],
        user_add_2: json['user_add_2'],
        user_add_3: json['user_add_3']);
  }
}
