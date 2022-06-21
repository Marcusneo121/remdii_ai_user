import 'package:flutter/material.dart';
import 'package:fyp/Screens/EczemaDiagnosis/Components/questionnaire.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AffectBody extends StatefulWidget {
  const AffectBody({Key? key}) : super(key: key);

  @override
  _AffectBodyState createState() => _AffectBodyState();
}

class _AffectBodyState extends State<AffectBody> {
  // bool value = false;
  int counter = 0;
  Map<String, bool> values = {
    '1    Right Face (Front)': false,
    '2    Left Face (Back)': false,
    '3    Neck (Front)': false,
    '4    Right Upper Chest (Front)': false,
    '5    Left Upper Chest (Front)': false,
    '6    Right Upper Arm (Front) ': false,
    '7    Left Upper Arm (Front)': false,
    '8    Right Forearm (Front)': false,
    '9    Left Forearm (Front)': false,
    '10   Right Hand (Front)': false,
    '11   Left Hand (Front)': false,
    '12   Right Lower Chest (Front)': false,
    '13   Left Lower Chest (Front)': false,
    '14   Right Abs (Front)': false,
    '15   Left Abs (Front)': false,
    '16   Private Zone': false,
    '17   Right Upper Legs (Front)': false,
    '18   Left Upper Legs (Front)': false,
    '19   Right Lower Legs (Front)': false,
    '20   Left Lower Legs (Front)': false,
    '21   Right Ankle (Front)': false,
    '22   Left Ankle (Front)': false,
    '23   Left Scalp (Back)': false,
    '24   Right Scalp (Back)': false,
    '25   Neck (Back)': false,
    '26   Left Upper Chest (Back)': false,
    '27   Right Upper Chest (Back)': false,
    '28   Left Upper Arm (Back)': false,
    '29   Right Upper Arm (Back)': false,
    '30   Left Forearm (Back)': false,
    '31   Right Forearm (Back)': false,
    '32   Left Hand (Back)': false,
    '33   Right Hand (Back)': false,
    '34   Left Lower Chest (Back)': false,
    '35   Right Lower Chest (Back)': false,
    '36   Left Lower Back (Back)': false,
    '37   Right Lower Back (Back)': false,
    '38   Left Buttocks (Back)': false,
    '39   Right Buttocks (Back)': false,
    '40   Left Upper Legs (Back)': false,
    '41   Right Upper Legs (Back)': false,
    '42   Left Lower Legs (Back)': false,
    '43   Right Lower Legs (Back)': false,
    '44   Left Ankle (Back)': false,
    '45   Right Ankle (Back)': false,
  };
  List<String> tmpArray = [];

  getCheckboxItems() async {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });
    // Printing all selected items on Terminal screen.
    print(tmpArray);
    print('Storing pref for bodyPart');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bodyPart', tmpArray);
    print('Checked!!');
    print(prefs.getStringList('bodyPart'));
    tmpArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Eczema Diagnosis",
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Instructions: \n- Please select on the affected body part by referring to the diagram below. \n- You may choose more than one affected body parts in your options. ",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
              Image.asset(
                'assets/images/body.png',
                fit: BoxFit.fill,
                width: 400.0,
                height: 400.0,
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
                // child: ListView(
                //   padding: EdgeInsets.symmetric(vertical: 5),
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   children: [...bodyPart.map(buildSingleCheckBox).toList()],
                // ),
              ),
              RoundedButton(
                  text: "Continue",
                  color: buttonColor,
                  press: () {
                    if (counter > 0) {
                      getCheckboxItems();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return QuestionnaireScreen();
                          },
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                new Text('Please enter at least one option.'),
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
    );
  }

// Widget buildSingleCheckBox(CheckBoxState checkbox) => CheckboxListTile(
//       controlAffinity: ListTileControlAffinity.leading,
//       value: checkbox.value,
//       title: Text(
//         checkbox.title,
//         style: TextStyle(
//           fontFamily: 'Lato',
//           fontWeight: FontWeight.w800,
//           fontSize: 16.0,
//         ),
//       ),
//       activeColor: buttonColor,
//       onChanged: (bool? value) => setState(() {
//         checkbox.value = value!;
//         if (value) {
//           counter += 1;
//           print('counter - 1');
//           print(counter);
//         } else {
//           counter -= 1;
//           print('counter + 1');
//           print(counter);
//         }
//       }),
//     );
}
