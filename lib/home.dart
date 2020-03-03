import 'package:flutter/material.dart';
import './read-page-liga1.dart' as liga1Artikel;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import './model/carousel.dart';

class Home extends StatefulWidget {
  @override
  _SliverCollapseState createState() => _SliverCollapseState();
}

class _SliverCollapseState extends State<Home> {

  String imgArtikel;

  List imgSlider = [
    {"image":"foto-liga-1.jpg","title":"Ilkay Gundogan Menolak Pinangan Liverpool"},
    {"image":"foto-liga-3.jpg","title":"Jadon Sancho Ditawari Nomor Punggung Spesial"},
    {"image":"foto-liga-4.jpg","title":"Liverpool Bersiap Ditinggal 3 Pemain Pilar"},
  ];

  var listArtikel = 
  [
    {
      "topic":"Liga Inggris",
      "image":"foto-liga-inggris.jpg",
      "title":"Massimiliano Allegri Bersiap Merapat ke Inggris",
      //"page":liga1Artikel.ReadPageLiga1("Liga Inggris"),
    },
    {
      "topic":"Liga 1",
      "image":"foto-liga-indonesia-1.jpg",
      "title":"Gabung Timnas Indonesia, Andritany dan Osvaldo Haay Absen Saat Persija Hadapi Arema FC",
      //"page":liga1Artikel.ReadPageLiga1("Liga Inggris"),
    },
    {
      "topic":"Liga Spanyol",
      "image":"foto-liga-spanyol.jpg",
      "title":"Eden Hazard Unggah Video Latihan, Isyarat Siap Kembali Bermain?",
     //"page":liga1Artikel.ReadPageLiga1("Liga Inggris"),
    },
    {
      "topic":"Liga Inggris",
      "image":"foto-liga-inggris.jpg",
      "title":"Massimiliano Allegri Bersiap Merapat ke Inggris",
      //"page":liga1Artikel.ReadPageLiga1("Liga Inggris"),
    },
    {
      "topic":"Liga 1",
      "image":"foto-liga-indonesia-1.jpg",
      "title":"Gabung Timnas Indonesia, Andritany dan Osvaldo Haay Absen Saat Persija Hadapi Arema FC",
      //"page":liga1Artikel.ReadPageLiga1("Liga Inggris"),
    },
    {
      "topic":"Liga Spanyol",
      "image":"foto-liga-spanyol.jpg",
      "title":"Eden Hazard Unggah Video Latihan, Isyarat Siap Kembali Bermain?",
      //"page":liga1Artikel.ReadPageLiga1("Liga Inggris"),
    },
    

  ];

  sendTagNameUser() async{
    await OneSignal.shared.sendTag("name", "Budi");
  }

  setTagTopicPage(String topicPage) async{
    await OneSignal.shared.sendTag("topic", topicPage);
  }

  @override
  void initState() {
    OneSignal.shared.init("d4d0c1ef-46bc-4c6d-9ebc-b3255cc60911");
    sendTagNameUser();
    //setTagTopicPage("Liga Inggris");
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
              title: Text("Firebase A/B Test Phase 2"),
              backgroundColor: Color.fromRGBO(0,85,151,1),
              flexibleSpace: FlexibleSpaceBar(                 
                  background: ImageCarousel(),
                  ),
            ),
            
          ];
        },
        body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              //SizedBox(height: 20.0,),

              SizedBox(
                height: 20.0,
              ),

               Container(
                  padding: EdgeInsets.only(left:20.0),
                  decoration: BoxDecoration(
                    //color:Colors.blueAccent,
                  ),
                  child: Text("Top Artikel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),



                Expanded(
                child: ListView.builder(
                itemCount: listArtikel.length,
                itemBuilder: (context, i){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => liga1Artikel.ReadPageLiga1(listArtikel[i]["topic"])),);
                      //print(listArtikel[i]["topic"]);
                    },
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                        Container(
                    padding: EdgeInsets.only(left:20.0,right:20.0),
                    
                    child: Container(
                      padding: EdgeInsets.only(bottom:25.0,),                    
                      
                      child:Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Image.asset("assets/images/${listArtikel[i]["image"]}",fit:BoxFit.contain),
                            ),
                          SizedBox(width: 20.0),
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(listArtikel[i]["topic"],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:Colors.blue),),
                                SizedBox(height: 5.0),
                                Text(listArtikel[i]["title"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,height: 1.3),),
                              ],
                            ), 
                            
                          ),
                          
                        ],
                    ),),
                  ),
                    ],
                    ),);
                },
                ),),

             
          ],
        ),
      ),
    );
  }

}



