import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/update_sleep_time_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodDiaryScreen extends StatefulWidget {
  const FoodDiaryScreen({Key? key}) : super(key: key);

  @override
  _FoodDiaryScreenState createState() => _FoodDiaryScreenState();
}

class _FoodDiaryScreenState extends State<FoodDiaryScreen> {
  int counter = 0;final formGlobalKey = GlobalKey<FormState>();
  List<String> tmpArray = [];
  // final foodList =[
  //   CheckBoxState(title: "Eggs"),
  //   CheckBoxState(title: "Milk"),
  //   CheckBoxState(title: "Wheat"),
  //   CheckBoxState(title: "Soy"),
  //   CheckBoxState(title: "Seafood"),
  //   CheckBoxState(title: "Nuts"),
  //   CheckBoxState(title: "Food Additives"),
  //   CheckBoxState(title: "Citrus fruits"),
  //   CheckBoxState(title: "Strawberries"),
  // ];
  //
  Map<String, bool> values = {
    'Eggs': false,
    'Milk': false,
    'Wheat': false,
    'Soy': false,
    'Seafood': false,
    'Nuts': false,
    'Food Additives': false,
    'Citrus fruits': false,
    'Strawberries': false,
  };

  getCheckboxItems() async {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });
    // Printing all selected items on Terminal screen.
    print(tmpArray);
    print('Storing pref for foodLog');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('foodLog', tmpArray);
    print('Checked!!');
    print(prefs.getStringList('foodLog'));
    tmpArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Update Recovery Progress",
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
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  Text(
                    "Instructions: \n- Please select on the food you have eaten before in these past few days. \n- You may choose more than one food in your options. ",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0,
                    ),
                  ),
                  Container(
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      children: values.keys.map((String key) {
                        return new CheckboxListTile(
                          title: new Text(
                            key,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          ),
                          value: values[key],
                          activeColor: buttonColor,
                          // checkColor: Colors.white,
                          onChanged: (bool? value) {
                            setState(() {
                              values[key] = value!;

                              if (value) {
                                counter += 1;
                                print('counter - 1');
                                print(counter);
                              } else {
                                counter -= 1;
                                print('counter + 1');
                                print(counter);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  RoundedButton(
                      text: "Continue",
                      color: buttonColor,
                      press: () {
                        if(counter > 0){
                          getCheckboxItems();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UpdateSleepTimeScreen();
                              },
                            ),
                          );
                        } else{
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text(
                                    'Please enter at least one option.'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: new Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        )

    );
  }
  // Widget buildSingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
  //   controlAffinity: ListTileControlAffinity.leading,
  //   value: checkbox.value,
  //   title: Text(
  //     checkbox.title,
  //     style: TextStyle(
  //       fontFamily: 'Lato',
  //       fontWeight: FontWeight.w800,
  //       fontSize: 16.0,
  //     ),
  //   ),
  //   activeColor: buttonColor,
  //   onChanged: (bool? value) => setState(() {
  //     checkbox.value = value!;
  //     if(value){
  //       counter += 1;
  //       print('counter - 1');
  //       print(counter);
  //     }else {
  //       counter -= 1;
  //       print('counter + 1');
  //       print(counter);
  //     }
  //   }),
  // );
}
