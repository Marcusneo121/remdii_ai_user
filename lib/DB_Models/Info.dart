class Info {
  final String info_id,
      info_name,
      info_des,
      info_cse,
      info_symp,
      info_trmt,
      info_addInfo,
      info_img_list;

  Info({
    required this.info_id,
    required this.info_name,
    required this.info_des,
    required this.info_cse,
    required this.info_symp,
    required this.info_trmt,
    required this.info_addInfo,
    required this.info_img_list,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      info_id: json['info_id'],
      info_des: json['info_des'],
      info_addInfo: json['info_addInfo'],
      info_img_list: json['info_img_list'],
      info_cse: json['info_cse'],
      info_name: json['info_name'],
      info_symp: json['info_symp'],
      info_trmt: json['info_trmt'],

    );
  }
}
