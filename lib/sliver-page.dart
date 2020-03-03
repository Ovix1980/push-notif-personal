import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: Icon(Icons.arrow_back_ios),
              backgroundColor: Colors.blue,
              centerTitle: true,
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              title: Text("Custom App Bar"),
              flexibleSpace: ImageCarousel(),
            ),
            

          ];
        },
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );
  }

  

}



class ImageCarousel extends StatefulWidget {
  @override
  ImageCarouselState createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {

  var imgSlider = [
    "https://cdn2.tstatic.net/jogja/foto/bank/images/corona-virus-dilawan-menggunakan-obat-hiv.jpg",
    "https://www.sciencemag.org/sites/default/files/styles/inline__450w__no_aspect/public/Coronavirus_bats_cave_collection_1280x720.jpg?itok=qPZJdc5r",
    "https://foreignpolicy.com/wp-content/uploads/2020/01/Wuhan-China-outbreak-coronavirus-temperature-GettyImages-1196116329.jpg?w=800&h=533&quality=90"

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child:CarouselSlider(
  viewportFraction: 1.0,
  height: 400.0,
  items: imgSlider.map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          //margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.amber
          ),
          child: Image.network(i,fit: BoxFit.cover,),
        );
      },
    );
  }).toList(),
),
    );
  }
}

