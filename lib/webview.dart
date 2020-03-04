import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import './splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Webview extends StatefulWidget {
  String url;
  String topic;

  Webview(this.url,this.topic);

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {

   int countVisit; 

  _getCookieArticle(String topic) async {
  final getPref = await SharedPreferences.getInstance();
  countVisit = getPref.getInt(topic);
  if(countVisit != null){
      countVisit++;
  }else{
    setState(() {
      countVisit = 0;
    });   
  }
    _setCookieArticle(topic, countVisit);
    _setTagTopicCount(topic, countVisit);
  }

  _setCookieArticle(String topic,int count) async {
  final setPref = await SharedPreferences.getInstance();
  setPref.setInt(topic,count);
  //Navigator.push(context,MaterialPageRoute(builder: (context) => NewsApiParsing(_indexArtikel)));
 }

 _setTagTopicCount(String topic,int countVisit) async{
    await OneSignal.shared.sendTag(topic, countVisit);
  }

  //Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      hidden: true,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () { 
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Splash()),);
                    },
                    );
                },
            ),
      ),
    );
  }
}