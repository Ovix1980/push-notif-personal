import 'package:flutter/material.dart';
import './model/read-more.dart';
import './home.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReadPageLiga1 extends StatefulWidget {

    String topic;

    ReadPageLiga1(this.topic);
    
    ReadPageLiga1_state createState() => ReadPageLiga1_state();

}

class ReadPageLiga1_state extends State<ReadPageLiga1> {

  

  int numberVisitPage;

  RemoteConfig remoteConfig;

  String getBgColor;

  List imgSlider = [
    {"image":"foto-liga-1.jpg","title":"Ilkay Gundogan Menolak Pinangan Liverpool"},
    {"image":"foto-liga-3.jpg","title":"Jadon Sancho Ditawari Nomor Punggung Spesial"},
    {"image":"foto-liga-4.jpg","title":"Liverpool Bersiap Ditinggal 3 Pemain Pilar"},
  ];

  getCountVisitPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int getCount = prefs.getInt(widget.topic);

    if(getCount != null){
       setState(() {
         getCount++;
       });
    }else{
        getCount = 0;
    }
    
    prefs.setInt(widget.topic, getCount);

    tagUserWithPageTopic(widget.topic, numberVisitPage);
    
  }

  
  setTagTopicPage(String topicPage) async{
    await OneSignal.shared.sendTag("topic", topicPage);
  }

  tagUserWithPageTopic(key, value) async {
    await OneSignal.shared.sendTag(key, value);
  }



  @override
  void initState() {
    OneSignal.shared.init("d4d0c1ef-46bc-4c6d-9ebc-b3255cc60911");
    setTagTopicPage(widget.topic);
    getCountVisitPage();
    //print(widget.topic);
    //_getBgRemote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /* actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => home.SliverCollapse()),);
              },
            ),
          ], */
          leading: Builder(
          builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () { 
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
                    },
                    );
                },
            ),
          //Icon(Icons.arrow_back_ios),
          elevation: 20.0,
          title: Text("Firebase A/B Test Phase 2"),
          backgroundColor: Color.fromRGBO(0,85,151,1),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.only(left:10.0,right:10.0,bottom:20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Liga Inggris",
                        style: TextStyle(fontSize: 12, color:Colors.blueGrey,fontWeight: FontWeight.normal,height: 1.3),
                  ),
                  Text("Mulai Negosiasi, Massimiliano Allegri Kian Dekat Gabung Manchester United",
                        style: TextStyle(fontSize: 22, color:Color.fromRGBO(0,85,151,1),fontWeight: FontWeight.bold,height: 1.3),
                  ),
                ],
              ),
            ),
            Image.asset("assets/images/massimiliani.jpg"),

            FutureBuilder<RemoteConfig>(
                    future: _getBgRemote(),
                    builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot){
                      if(snapshot.hasData){
                        return isiArtikel(snapshot.data.getString("bg_read_page"));
                      }else{
                        return Center(
                          child: Text("Loading..."),
                        );
                      }
                    }
            
            ),
            

            Container(
              margin:EdgeInsets.all(20),
              child: Text("Artikel Lainnya",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),), 
            ),
            
             
             Container(
               margin: EdgeInsets.only(left:20,right:20),
              child:Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Image.asset("assets/images/${imgSlider[0]["image"]}"),
                  ),
                  
                  SizedBox(width:10.0),

                   Flexible(
                     flex: 2,
                   child:Text(imgSlider[0]["title"]),
                   ),
                ],
              ),
            ),

            SizedBox(height: 20.0),


            Container(
               margin: EdgeInsets.only(left:20,right:20),
              child:Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Image.asset("assets/images/${imgSlider[1]["image"]}"),
                  ),
                  
                  SizedBox(width:10.0),

                   Flexible(
                     flex: 2,
                   child:Text(imgSlider[1]["title"]),
                   ),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            Container(
               margin: EdgeInsets.only(left:20,right:20),
              child:Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Image.asset("assets/images/${imgSlider[2]["image"]}"),
                  ),
                  
                  SizedBox(width:10.0),

                   Flexible(
                     flex: 2,
                   child:Text(imgSlider[2]["title"]),
                   ),
                ],
              ),
            ),

            SizedBox(height: 40.0),
      

          ],
        ),),
    );
  }

  Future<RemoteConfig> _getBgRemote() async {
    
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    //print("${remoteConfig.getString("bg_read_page")}");
    //await remoteConfig.activateFetched();
    return remoteConfig;

  }


  Container isiArtikel(String warna){
    return Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color:warna == "yellow"?Colors.yellow[100]:warna == "grey"?Colors.grey[200]:Colors.white,
              ),
              child: ReadMoreText(
                  "Saat ini, Manchester United sedang berada dalam tren negatif. Kondisi itu diperburuk dengan banyaknya pemain kunci yang cedera. \n\nHal itu membuat manajemen Manchester United siap untuk hasil terburuk dari laga tersebut. Jika hal itu terjadi, Solskjaer berpeluang kehilangan pekerjaannya sebagai manajer Manchester United. \n\nSituasi tersebut membuat manajemen Manchester United bersiap untuk menunjuk manajer anyar. Sejauh ini, Allegri menjadi kandidat utama yang statusnya tidak terikat dengan klub mana pun. \n\nNamun, Allegri disebut meminta bayaran yang lebih besar dari yang ia terima di Juventus. Sebelumnya, Allegri mendapat bayaran sebesar 7,5 juta euro per musim. Allegri diprediksi meminta bayaran mencapai 10 juta euro per musim di Manchester United.",
                  trimLines: 10,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Read more',
                  //trimExpandedText: ' Less',
                  style: TextStyle(fontSize:16,height: 1.5,),
                  )
            );
  }

  Container artikelLain(){
    return Container(
        child: ListView.builder(
          //physics: NeverScrollableScrollPhysics,
          shrinkWrap: true,
          primary: false,
          itemCount: imgSlider.length,
          itemBuilder: (context,index){
            return Container(
              child:Row(
                children: <Widget>[
                  Image.asset("assets/images/${imgSlider[index]["image"]}"),
                  SizedBox(width:10.0),
                  Text(imgSlider[index]["title"]),
                ],
              ),
            );
          })
       );
  }
}