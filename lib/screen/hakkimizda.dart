import 'package:flutter/material.dart';

class hakkimizda extends StatefulWidget {
  @override
  _hakkimizdaState createState() => _hakkimizdaState();
}

class _hakkimizdaState extends State<hakkimizda> {
  @override

  Widget build(BuildContext context) {
    var ekranbilgisi=MediaQuery.of(context);
    final double ekranYuksekligi=ekranbilgisi.size.height;
    final double ekranGenislik=ekranbilgisi.size.width;
    return Scaffold(
      appBar:  AppBar(

        title: Text("Hakkımızda"),
        centerTitle: true,
        //backgroundColor: Colors.purple,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow, Colors.red],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        elevation: 20,
        titleSpacing: 20,
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset("resim/hak.png",
            fit: BoxFit.cover,
            width: ekranGenislik,
            height: ekranYuksekligi,
            alignment: Alignment.center,),
          ),


        ],
      ),
    );
  }

}
