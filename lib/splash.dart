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
  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjU4MGVkYmJhYWQ3OTJjZjU1MzRjZmJmMjllYWJmNGI0NTA2OTczNzMxNjU0YTkzMmUyNjljZmNmNzI1MWE1YzBiODFmM2U3Yzk0NmJlNTZkIn0.eyJhdWQiOiIxNCIsImp0aSI6IjU4MGVkYmJhYWQ3OTJjZjU1MzRjZmJmMjllYWJmNGI0NTA2OTczNzMxNjU0YTkzMmUyNjljZmNmNzI1MWE1YzBiODFmM2U3Yzk0NmJlNTZkIiwiaWF0IjoxNTY2NTQ1OTMxLCJuYmYiOjE1NjY1NDU5MzEsImV4cCI6MTU5ODE2ODMzMSwic3ViIjoiOTMyIiwic2NvcGVzIjpbXX0.RvP0ZkHT_ujM0u8F41xSzqQ4eoyTf76HORCn6O39OfnBRVcmXv_BF8QiF_LreN6pD1pDouYDyTEVwxjWiEYy3yc0TMRb3j6rfayFewm0R0Yp7HTkiStLF80Fn02nCwvuckFhjlxuZNAOj-MlXUVzgav_jIkZQPbc95_3RHaG60JQqdRTMgVGgDuMmCQR0RNj59KxBdF2MY-IV5kq33ZSNn412UeYEsxCefgGv_wlbkWj1jKI9jedRAnm-bRU3AdELNFN8LYejTPXpqyJ8P5NYbKVmOPRYWIRptkqVaHucVveTzHxu-d0eD-6-FM9IbRU9Mb4nAbMvsxGyIp-4t_-xzaGyyZLQo2bBw75Lx17W3c4cMZV0InecaYzC4-Ru3GhN787Ft51wpZ756ijUbkgUBwnK106-PEwQQ36zHdAC_ZcSC423mY_5-lPPYsROp0-Uw11n6Grt6Ae-CS7TZJowPd8YIFUIIFqdK0JdcYcLhCqVTqHfRbURMSm3o_peU72o-FxJKdfEI_eyUn1zsi3D1tUnbx9mlS73L2hZf9EqMlrgGD_L0t8zxG81-_mqoAABXX7AJa7q9FxJNY5x41IrRE_C6GYT8tJysDwJRsJVR2IAJGbIqW2Rhar6NQPGCgr0Vj8SBzoiti0hstoRkcnyNQNN7guZC33PUjGCHlK9mE";
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

