import 'package:flutter/material.dart';
import './push-notif-page.dart';
import './sliver-page.dart';
import './home.dart';
import './read-page-liga1.dart';
import './model/artikel-model.dart';
import './api-parse.dart';
import './splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: //PushNotif(),
            //SliverPage(),
            //SliverCollapse(),
            //ReadPageLiga1(),
            //ExpandArtikel(),
            //ExpandedSection(),
            //ReadPageLiga1_state()
            //Home(),
            //NewsApiParsing(),
            Splash(),
    );
  }
}

