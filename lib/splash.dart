import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './api-parse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model/artikel-model.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  //SharedPreferences setCookieId;

  String baseUrl = "https://dev.one.co.id/api/article";
  String token = "xxxxx";
  int endPoint;

  List<String> _idArtikel = [];
  List<IndexArtikel> _indexArtikel = [];

  Future<Null> getApiNews() async {
    final data = await http.get(baseUrl,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final respon = jsonDecode(data.body);

    if(respon != null){
      for(var res in respon["data"]){
        //IdArtikel idArtikel = IdArtikel(res["id"].toString());
        _idArtikel.add(res["id"].toString());
        setState(() {
          getDetailNews(res["id"].toString());
        });
      }   
      //_setCookieIdNews();
    }
  
  }

  Future<Null> getDetailNews(String endpoint) async{
    final data = await http.get(baseUrl + "/$endpoint",headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    final respon = jsonDecode(data.body);

    if(respon != null){


      //for(var res in respon["data"]){
        IndexArtikel indexArtikel = IndexArtikel(respon["data"]["title"],respon["data"]["photos"][0]["photo_url"],respon["data"]["reporter"],respon["data"]["category"]["category_name"],respon["data"]["source"]);

        //print("${_indexArtikel.length}");

        _indexArtikel.add(indexArtikel);

      //}


    }else{
      print("API not Called");
    }

    if(_idArtikel.length == _indexArtikel.length){
      //print("Artikel lengkap");
      //print("isi dari list _indexArtikel : ${_indexArtikel.length}");
      Navigator.push(context,MaterialPageRoute(builder: (context) => NewsApiParsing(_indexArtikel)));
    }
 

  }


  @override
  void initState() {
    getApiNews();
    //print("${_indexArtikel.length}");
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x0FFffa000),
      body: Container (
              child:Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                    Text("Personalization Push Notif \n Testing", style: TextStyle(fontSize:28.0,fontWeight: FontWeight.bold,height: 1.5,color:Colors.white),textAlign: TextAlign.center,),
                    SizedBox(height: 20.0,),
                    CircularProgressIndicator(strokeWidth: 1.5,semanticsLabel: "Progress",backgroundColor: Colors.white,),
                ]
              ),  
              
            ),
          ),
        );
  }

  _setCookieIdNews() async {
  final setPref = await SharedPreferences.getInstance();
  setPref.setStringList("id_news", _idArtikel);
  Navigator.push(context,MaterialPageRoute(builder: (context) => NewsApiParsing(_indexArtikel)));
 }

}

class IdArtikel{
  String id;
  IdArtikel(this.id);
}

