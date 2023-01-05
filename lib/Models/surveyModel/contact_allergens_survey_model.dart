class ContactAllergensSurveyModel {
  bool? fragrance;
  bool? rubber;
  bool? nickel;
  bool? formaldehyde;
  bool? preservatives;
  bool? sanitiser;

  ContactAllergensSurveyModel({
    this.fragrance,
    this.rubber,
    this.nickel,
    this.formaldehyde,
    this.preservatives,
    this.sanitiser,
  });

  factory ContactAllergensSurveyModel.fromJson(Map<String, dynamic> json) {
    return ContactAllergensSurveyModel(
      fragrance: json['Fragrance'] != null ? json['Fragrance'] : false,
      rubber: json['Rubber'] != null ? json['Rubber'] : false,
      nickel: json['Nickel'] != null ? json['Nickel'] : false,
      formaldehyde: json['Formaldehyde'] != null ? json['Formaldehyde'] : false,
      preservatives:
          json['Preservatives'] != null ? json['Preservatives'] : false,
      sanitiser: json['Sanitiser'] != null ? json['Sanitiser'] : false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Fragrance": fragrance,
        "Rubber": rubber,
        "Nickel": nickel,
        "Formaldehyde": formaldehyde,
        "Preservatives": preservatives,
        "Sanitiser": sanitiser,
      };
}
