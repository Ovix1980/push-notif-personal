import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  @override
  ImageCarouselState createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {

  String _title;

  List imgSlider = [
    {"image":"foto-headline-1.jpg","title":"Mendag: Stok Bahan Pokok Aman sampai Lebaran"},
    {"image":"foto-headline-2.jpg","title":"Suspect Pasien di Jabar, negatif corona"},
    {"image":"foto-headline-3.jpg","title":"Virus Corona Positif Ada di Indonesia"},
  ];

  @override
  void initState() {
    _title = imgSlider[0]["title"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
             CarouselSlider(
  viewportFraction: 1.0,
  height: 400.0,
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 3),
  autoPlayCurve: Curves.easeInOut,
  onPageChanged: (i){
    setState(() {
      _title = imgSlider[i]["title"];
    });
  },
  items: imgSlider.map((i) {
    return Builder(
      builder: (BuildContext context) {
        //print("${i["image"]}");
        return Container(
          height:400.0,
          width: MediaQuery.of(context).size.width,
          //margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            //color: Colors.amber
          ),
          child: Image.asset("assets/images/${i["image"]}",fit:BoxFit.fitHeight),
          
        );
      },
    );
  }).toList(),
),

          Positioned(
            bottom:20.0,
            //left: 20.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0x0FFffa000),
              ),
              child: Text(_title,style: TextStyle(fontSize: 16.0,color:Colors.white),),
            ),
            
          )

        ],
      ),
    );
  }
}