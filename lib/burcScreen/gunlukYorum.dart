import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class gunlukYorum extends StatefulWidget {
  String gelenAd;
  gunlukYorum({this.gelenAd});
  @override
  _gunlukYorumState createState() => _gunlukYorumState();
}
class _gunlukYorumState extends State<gunlukYorum> {
  String secburc;
  String _chosenValue;
  String ad="";
  String mtto="";
  String gzgn="";
  String yorum="";
  String zaman="";
  @override
  Future<String>getGunluk(String ad)async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/get/"+ad));
    var jsonData = json.decode(data.body);
    BurcYorum gunluk=BurcYorum(jsonData[0]["Burc"], jsonData[0]["Mottosu"], jsonData[0]["Gezegeni"], jsonData[0]["GunlukYorum"]);
    setState(() {
      ad=gunluk.ad;
      mtto=gunluk.motto;
      gzgn=gunluk.gzgn;
      yorum=gunluk.yorum;
    });
  }
  Future<String>getHaftalik(String ad)async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/get/"+ad+"/haftalik"));
    var jsonData = json.decode(data.body);
   BurcYorum haftalik=BurcYorum(jsonData[0]["Burc"].toString(), jsonData[0]["Mottosu"].toString(), jsonData[0]["Gezegeni"].toString(), jsonData[0]["Yorum"].toString());
    setState(() {
      ad=haftalik.ad;
      mtto=haftalik.motto;
      gzgn=haftalik.gzgn;
     yorum=haftalik.yorum;
    });
  }
  Future<String>getAylik(String ad)async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/get/"+ad+"/aylik"));
    var jsonData = json.decode(data.body);
    BurcYorum haftalik=BurcYorum(jsonData[0]["Burc"].toString(), jsonData[0]["Mottosu"].toString(), jsonData[0]["Gezegeni"].toString(), jsonData[0]["Yorum"].toString());
    setState(() {
      ad=haftalik.ad;
      mtto=haftalik.motto;
      gzgn=haftalik.gzgn;
      yorum=haftalik.yorum;
    });
  }
  Future<String>getYillik(String ad)async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/get/"+ad+"/yillik"));
    var jsonData = json.decode(data.body);
    BurcYorum haftalik=BurcYorum(jsonData[0]["Burc"].toString(), jsonData[0]["Mottosu"].toString(), jsonData[0]["Gezegeni"].toString(), jsonData[0]["Yorum"].toString());
    setState(() {
      ad=haftalik.ad;
      mtto=haftalik.motto;
      gzgn=haftalik.gzgn;
      yorum=haftalik.yorum;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(

        title: Text(widget.gelenAd +" Burcu Yorumları"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Column(
                    children: [
                      Image.asset("resim/1.png"),
                      DropdownButton<String>(
                        focusColor:Colors.white,
                        value: _chosenValue,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor:Colors.black,
                        items: <String>[
                          "Günlük",
                          "Haftalık",
                          "Aylık",
                          "Yıllık"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color:Colors.black),),
                          );
                        }).toList(),
                        hint:Text(
                          "Zaman Seçiniz",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue = value;
                            zaman=_chosenValue;
                            if(_chosenValue=="Günlük")
                              getGunluk(widget.gelenAd);
                            if(_chosenValue=="Haftalık")
                              getHaftalik(widget.gelenAd);
                            if(_chosenValue=="Aylık")
                              getAylik(widget.gelenAd);
                            if(_chosenValue=="Yıllık")
                              getYillik(widget.gelenAd);
                          });
                        },
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Text('Burcunuz: ${widget.gelenAd}\n\n'
                          +"Zaman: "+zaman+"\n\n"
                              +"Mottonuz: "+mtto+"\n\n"
                            +"Gezegeniniz: "+gzgn+"\n\n"
                            +"Yorum: "+yorum
                            ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class BurcYorum{
  String ad;
  String motto;
  String gzgn;
  String yorum;
  BurcYorum(this.ad, this.motto, this.gzgn, this.yorum);
}