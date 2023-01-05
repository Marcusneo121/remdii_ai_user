class FoodSurveyModel {
  bool? egg;
  bool? cowMilk;
  bool? soy;
  bool? peanut;
  bool? seafood;
  bool? wheat;

  FoodSurveyModel(
      {this.egg,
      this.cowMilk,
      this.soy,
      this.peanut,
      this.seafood,
      this.wheat});

  factory FoodSurveyModel.fromJson(Map<String, dynamic> json) {
    return FoodSurveyModel(
      egg: json['Egg'] != null ? json['Egg'] : false,
      cowMilk: json['CowMilk'] != null ? json['CowMilk'] : false,
      soy: json['Soy'] != null ? json['Soy'] : false,
      peanut: json['Peanut'] != null ? json['Peanut'] : false,
      seafood: json['Seafood'] != null ? json['Seafood'] : false,
      wheat: json['Wheat'] != null ? json['Wheat'] : false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Egg": egg,
        "CowMilk": cowMilk,
        "Soy": soy,
        "Peanut": peanut,
        "Seafood": seafood,
        "Wheat": wheat,
      };
}
