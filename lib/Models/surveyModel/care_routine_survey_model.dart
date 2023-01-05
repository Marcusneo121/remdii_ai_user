class CareRoutineSurveyModel {
  bool? moisturiser;
  bool? topicalSteroids;
  bool? medicines;
  bool? immunosuppressant;
  bool? wetWrapTherapy;
  bool? bleachBath;

  CareRoutineSurveyModel({
    this.moisturiser,
    this.topicalSteroids,
    this.medicines,
    this.immunosuppressant,
    this.wetWrapTherapy,
    this.bleachBath,
  });

  factory CareRoutineSurveyModel.fromJson(Map<String, dynamic> json) {
    return CareRoutineSurveyModel(
      moisturiser: json['Moisturiser'] != null ? json['Moisturiser'] : false,
      topicalSteroids:
          json['TopicalSteroids'] != null ? json['TopicalSteroids'] : false,
      medicines: json['Medicines'] != null ? json['Medicines'] : false,
      immunosuppressant:
          json['Immunosuppressant'] != null ? json['Immunosuppressant'] : false,
      wetWrapTherapy:
          json['WetWrapTherapy'] != null ? json['WetWrapTherapy'] : false,
      bleachBath: json['BleachBath'] != null ? json['BleachBath'] : false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Moisturiser": moisturiser,
        "TopicalSteroids": topicalSteroids,
        "Medicines": medicines,
        "Immunosuppressant": immunosuppressant,
        "WetWrapTherapy": wetWrapTherapy,
        "BleachBath": bleachBath,
      };
}
