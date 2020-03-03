import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:one_signal_notification/api-parse.dart';
import './splash.dart';

class Webview extends StatefulWidget {
  String url;

  Webview(this.url);

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {

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