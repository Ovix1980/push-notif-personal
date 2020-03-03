import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './model/artikel-model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './webview.dart';
import './model/carousel.dart';

class NewsApiParsing extends StatefulWidget {
  List<IndexArtikel> _listIndex;

  NewsApiParsing(this._listIndex);

  @override
  _NewsApiParsingState createState() => _NewsApiParsingState();
}

class _NewsApiParsingState extends State<NewsApiParsing> {

  SharedPreferences getId;

  String baseUrl = "https://dev.one.co.id/api/article";
  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjU4MGVkYmJhYWQ3OTJjZjU1MzRjZmJmMjllYWJmNGI0NTA2OTczNzMxNjU0YTkzMmUyNjljZmNmNzI1MWE1YzBiODFmM2U3Yzk0NmJlNTZkIn0.eyJhdWQiOiIxNCIsImp0aSI6IjU4MGVkYmJhYWQ3OTJjZjU1MzRjZmJmMjllYWJmNGI0NTA2OTczNzMxNjU0YTkzMmUyNjljZmNmNzI1MWE1YzBiODFmM2U3Yzk0NmJlNTZkIiwiaWF0IjoxNTY2NTQ1OTMxLCJuYmYiOjE1NjY1NDU5MzEsImV4cCI6MTU5ODE2ODMzMSwic3ViIjoiOTMyIiwic2NvcGVzIjpbXX0.RvP0ZkHT_ujM0u8F41xSzqQ4eoyTf76HORCn6O39OfnBRVcmXv_BF8QiF_LreN6pD1pDouYDyTEVwxjWiEYy3yc0TMRb3j6rfayFewm0R0Yp7HTkiStLF80Fn02nCwvuckFhjlxuZNAOj-MlXUVzgav_jIkZQPbc95_3RHaG60JQqdRTMgVGgDuMmCQR0RNj59KxBdF2MY-IV5kq33ZSNn412UeYEsxCefgGv_wlbkWj1jKI9jedRAnm-bRU3AdELNFN8LYejTPXpqyJ8P5NYbKVmOPRYWIRptkqVaHucVveTzHxu-d0eD-6-FM9IbRU9Mb4nAbMvsxGyIp-4t_-xzaGyyZLQo2bBw75Lx17W3c4cMZV0InecaYzC4-Ru3GhN787Ft51wpZ756ijUbkgUBwnK106-PEwQQ36zHdAC_ZcSC423mY_5-lPPYsROp0-Uw11n6Grt6Ae-CS7TZJowPd8YIFUIIFqdK0JdcYcLhCqVTqHfRbURMSm3o_peU72o-FxJKdfEI_eyUn1zsi3D1tUnbx9mlS73L2hZf9EqMlrgGD_L0t8zxG81-_mqoAABXX7AJa7q9FxJNY5x41IrRE_C6GYT8tJysDwJRsJVR2IAJGbIqW2Rhar6NQPGCgr0Vj8SBzoiti0hstoRkcnyNQNN7guZC33PUjGCHlK9mE";
  int endPoint;
  var dataListArtikel2;

  List<IndexArtikel> _indexArtikel = [];
  //List<IdArtikel> _idArtikel = [];

  bool showArtikelUntukmu;

  @override
  void initState() {
    setState(() {
      showArtikelUntukmu = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: Icon(Icons.menu),
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              centerTitle: true,
              elevation: 20.0,
              title: Text("Push Notif Personalisation 1"),
              backgroundColor: Color(0x0FFffa000),
              flexibleSpace: FlexibleSpaceBar(                 
                  background: ImageCarousel(),
                  ),
            ),
            
          ];
        },  
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          showArtikelUntukmu == true?
          Container(
            margin:EdgeInsets.all(20.0),
            width: double.infinity,
            height: 100.0,
            //constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color:Colors.grey[300],
            ),
            child: Center(child:Text("Artikel Untukmu",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
          ):Text(""),
          Container(
                  padding: EdgeInsets.only(left:20.0),
                  //margin: EdgeInsets.only(top:20.0),
                  decoration: BoxDecoration(
                    //color:Colors.blueAccent,
                  ),
                  child: Text("Artikel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.grey[700]),),
                ),

                Expanded(
                  child:Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget._listIndex.length,
          itemBuilder: (context,index){
            
            var dataListArtikel = widget._listIndex[index];
            //print("Isi dari konten detail artikel ${dataListArtikel.title}");           
            return InkWell(
              onTap: (){
                print("${dataListArtikel.url}");
                Navigator.push(context,MaterialPageRoute(builder: (context) => Webview("${dataListArtikel.url}")));
              },
              child:Container(
                margin:EdgeInsets.only(left:20.0,right:20.0),
                padding: EdgeInsets.only(bottom:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                     //Text("${dataListArtikel.title}"),
                     
                     //SizedBox(height: 5.0,),
                     Row(
                      children: <Widget>[ 
                        Flexible(
                          flex: 1,
                          child: Container(
                          //padding: EdgeInsets.all(value),
                          width: 60.0,
                          height:60.0,
                          child:dataListArtikel.img != null?Image.network("${dataListArtikel.img}",fit: BoxFit.cover,):CircularProgressIndicator(strokeWidth: 1.0,backgroundColor: Colors.blueGrey,),
                        ),
                          ),
                        
                          SizedBox(width: 20.0,),

                          Flexible(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${dataListArtikel.kategori}",style: TextStyle(fontSize:12.0,fontWeight: FontWeight.bold,color:Color(0x0FFffa000)),), 
                              Text("${dataListArtikel.title}",style: TextStyle(height:1.6),),
                            ],
                          ),
                          
                          ),
                      ],
                     ),
                     
                  ],
                ),
            ),);
          }
          ),
            
      ),
                ),
        ],
      ),
      ),
    );
  }

  Container parsingListArtikel(){
    return Container(
      child: ListView.builder(
          itemCount: _indexArtikel.length,
          itemBuilder: (context,index){
            
            var dataListArtikel = _indexArtikel[index];
            print("Isi dari konten detail artikel ${dataListArtikel.title}");           
            return Container(
                margin:EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                     Text("${dataListArtikel.title}"),
                     //Text("${dataListArtikel.kategori}"), 
                     SizedBox(height: 5.0,),
                     //Text("${dataListArtikel.title}"), 
                  ],
                ),
            );
          }
          ),
    );
  }
}



