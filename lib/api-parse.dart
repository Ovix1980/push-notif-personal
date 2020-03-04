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
  String token = "xxxxxx";
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
                Navigator.push(context,MaterialPageRoute(builder: (context) => Webview("${dataListArtikel.url}","${dataListArtikel.kategori}")));
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



