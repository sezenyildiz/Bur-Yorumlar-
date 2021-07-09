import 'package:burc_yorum/burcScreen/gunlukYorum.dart';
import 'package:flutter/material.dart';
class GunlukYorum extends StatefulWidget {
  const GunlukYorum({Key key}) : super(key: key);

  @override
  _GunlukYorumState createState() => _GunlukYorumState();
}

class _GunlukYorumState extends State<GunlukYorum> {
  @override
  Widget build(BuildContext context)=>DefaultTabController(
    length: 4,
    child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  AppBar(
        title: Text("Burç Yorumları"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        //backgroundColor: Colors.purple,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        elevation: 20,
        titleSpacing: 20,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 4/4,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Koç")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/1.png")),
                  Text("Koç",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Boğa")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/2.png")),
                  Text("Boğa",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"İkizler")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/3.png")),
                  Text("İkizler",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Yengeç")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/4.png")),
                  Text("Yengeç",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Aslan")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/5.png")),
                  Text("Aslan",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Terazi")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/6.png")),
                  Text("Terazi",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Akrep")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/7.png")),
                  Text("Akrep",style: TextStyle(
                    fontSize: 20.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Yay")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/8.png")),
                  Text("Yay",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Oğlak")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/9.png")),
                  Text("Oğlak",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Kova")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/10.png")),
                  Text("Kova",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Balık")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/11.png")),
                  Text("Balık",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>gunlukYorum(gelenAd:"Başak")));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("resim/12.png")),
                  Text("Başak",style: TextStyle(
                    fontSize: 17.0,
                  ),),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

