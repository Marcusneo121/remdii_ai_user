import 'package:flutter/material.dart';
import 'package:fyp/LocalNotifyManager.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/view_and_update_screen.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';

class ProgressionScreen extends StatefulWidget {
  const ProgressionScreen({Key? key}) : super(key: key);

  @override
  _ProgressionScreenState createState() => _ProgressionScreenState();
}

class _ProgressionScreenState extends State<ProgressionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification) {
    print('Notification Received: ${notification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload: $payload');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ViewUpdate();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "How's Your Progress?",
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
            children: [
              Text(
                "Instructions: \n- By selecting 'I'm Recovering' button, you will no longer receive any notifications for update recovery progress purpose. \n- By selecting 'Continue Update', you will continue receive notifications for tracking recovery progress purpose.",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  RoundedButton(
                    text: "I'm Recovering",
                    color: buttonColor2,
                    press: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomepageScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  RoundedButton(
                    text: "Continue Update",
                    press: () async {
                      //await localNotifyManager.scheduleNotification();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomepageScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
