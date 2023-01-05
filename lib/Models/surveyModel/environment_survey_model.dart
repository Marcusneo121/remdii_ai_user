class EnvironmentSurveyModel {
  bool? dust;
  bool? sun;
  bool? sweat;
  bool? pets;

  EnvironmentSurveyModel({
    this.dust,
    this.sun,
    this.sweat,
    this.pets,
  });

  factory EnvironmentSurveyModel.fromJson(Map<String, dynamic> json) {
    return EnvironmentSurveyModel(
      dust: json['Dust'] != null ? json['Dust'] : false,
      sun: json['Sun'] != null ? json['Sun'] : false,
      sweat: json['Sweat'] != null ? json['Sweat'] : false,
      pets: json['Pets'] != null ? json['Pets'] : false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Dust": dust,
        "Sun": sun,
        "Sweat": sweat,
        "Pets": pets,
      };
}
