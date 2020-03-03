import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
class PushNotif extends StatefulWidget {
  @override
  _PushNotifState createState() => _PushNotifState();
}

class _PushNotifState extends State<PushNotif> {

  //OneSignal.shared.init(d4d0c1ef-46bc-4c6d-9ebc-b3255cc60911);

  
  @override
  void initState() {
    OneSignal.shared.init("d4d0c1ef-46bc-4c6d-9ebc-b3255cc60911");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notif - One Signal"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),


      body: Container(
        child: Center(
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Text("Click to Activate Notification"),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                onPressed:(){},
                child: Text("Send Push Notif"), 
              )
          ],
         ),
        ),
      ),
      
    );
  }
}