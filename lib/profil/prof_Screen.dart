import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
final _picker=ImagePicker();
FirebaseFirestore firestore = FirebaseFirestore.instance;
var burc,ad,saglik1,olumlu1,film1,stil1,baslik1,baslik2,baslik3,baslik4,baslik5,baslik6;
String ask1="";
var resimUrl;
File imageFile;
String kariyer1="";
bool resim=false;
class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  Future<String>getAsk()async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/gets/"+burc+"/ask"));
    var jsonData = await json.decode(data.body);
    var abaslik=jsonData[0]["Baslik"];
    var ask=jsonData[0]["Yorum"];
    setState(() {
      ask1=ask.toString();
      baslik1=abaslik.toString();
    });
  }
  Future<String>getSaglik()async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/gets/"+burc+"/saglık"));
    var jsonData = await json.decode(data.body);
    var sbaslik=jsonData[0]["Baslik"];
    var saglik=jsonData[0]["Yorum"];
    setState(() {
      saglik1=saglik.toString();
      baslik2=sbaslik.toString();
    });
  }
  Future<String>getKariyer()async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/gets/"+burc+"/kariyer"));
    var jsonData = json.decode(data.body);
    var baslik=jsonData[0]["Baslik"];
    var kariyer=jsonData[0]["Yorum"];
    setState(() {
      kariyer1=kariyer.toString();
      baslik3=baslik.toString();
    });
  }
  Future<String>getStil()async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/gets/"+burc+"/stil"));
    var jsonData = json.decode(data.body);
    var baslik=jsonData[0]["Baslik"];
    var stil=jsonData[0]["Yorum"];
    setState(() {
      stil1=stil.toString();
      baslik4=baslik.toString();
    });
  }
  Future<String>getOlum()async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/gets/"+burc+"/OLUMLU%20YONLER"));
    var jsonData = json.decode(data.body);
    var baslik=jsonData[0]["Baslik"];
    var olum=jsonData[0]["Yorum"];
    setState(() {
      olumlu1=olum.toString();
      baslik5=baslik.toString();
    });
  }
  Future<String>getFilm()async{
    var data=await http.get(Uri.parse("https://burc-yorumlari.herokuapp.com/gets/"+burc+"/FİLM%20ÖNERİLERİ"));
    var jsonData = json.decode(data.body);
    var baslik=jsonData[0]["Baslik"];
    var film=jsonData[0]["Unluler"];
    setState(() {
      film1=film.toString();
      baslik6=baslik.toString();
    });
    print(film1);
  }
  Future getGallery(BuildContext context)async{
    final pickedFile=await _picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile=File(pickedFile.path);
      resim=true;
    });
    var ref=FirebaseStorage.instance.ref().child("users").child(FirebaseAuth.instance.currentUser.email).child("profil.png");
    UploadTask uploadTask=ref.putFile(imageFile);
    resimUrl=await ref.getDownloadURL();
    print("URL ADRESİ: ${resimUrl}");
  }
  @override
  Widget build(BuildContext context) {
    firestore.collection("users").doc(FirebaseAuth.instance.currentUser.email).get().then((docSnap){
      setState(() {
        ad=docSnap.data()["_adSoyad"];
        burc=docSnap.data()["_burç"];
      });
    });
    return Scaffold(
      appBar:  AppBar(
        title: Text("Burç Yorumları"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              getGallery(context);
            },
          ),
        ],
        //backgroundColor: Colors.purple,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.yellow],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        elevation: 20,
        titleSpacing: 20,
      ),
      backgroundColor:Color(0xFFffd600),
     body: Column(
       children: [
         Container(
           height: MediaQuery.of(context).size.height-450,
           decoration: BoxDecoration(
             image: DecorationImage(image:
             imageFile==null?AssetImage(("resim/profil_back.png")):NetworkImage(resimUrl)),
             gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 colors: [
                   Colors.yellow[900],
                   Colors.orange[800],
                   Colors.yellow[400]
                 ]
             ),
             borderRadius:BorderRadius.vertical(bottom: Radius.elliptical(30, 30))
           ),
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Text("Hoşgeldin, ${ad.toString().toUpperCase()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
               ],
             ),
           ),
         ),
         SizedBox(height: 50,),
         Text("Burcunuz: ${burc}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
         SizedBox(height: 10,),
         Text("Bilgi Almak İstediğin Konuyu Seç Yorumun Gelsin",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
         SizedBox(height: 30,),
         Divider(),
         Padding(
           padding: const EdgeInsets.only(left:10.0,right: 10.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               ClipOval(
                 child: Material(
                   color: Colors.transparent, // Button color
                   child: InkWell(
                     splashColor: Colors.pink, // Splash color
                     onTap: () {
                       getSaglik();
                       showReview(context, saglik1, baslik2);
                     },
                     child: SizedBox(width: 56, height: 56, child: Image.network("https://image.flaticon.com/icons/png/512/2966/2966486.png")),
                   ),
                 ),
               ),
               ClipOval(
                 child: Material(
                   color: Colors.transparent, // Button color
                   child: InkWell(
                     splashColor: Colors.pink,
                     // Splash color
                     onTap: () {
                       getAsk();
                       showReview(context, ask1, baslik1);
                     },
                     child: SizedBox(width: 56, height: 56, child:Image.network("https://image.flaticon.com/icons/png/512/833/833472.png")),
                   ),
                 ),
               ),
               ClipOval(
                 child: Material(
                   color: Colors.transparent, // Button color
                   child: InkWell(
                     splashColor: Colors.pink, // Splash color
                     onTap: () {
                       getKariyer();
                       showReview(context, kariyer1, baslik3);
                     },
                     child: SizedBox(width: 56, height: 56, child: Image.network("https://image.flaticon.com/icons/png/512/1589/1589131.png")),
                   ),
                 ),
               ),
             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.only(left: 16.0,right: 16),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text("Sağlık",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
               Text("Aşk",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
               Text("Kariyer",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
             ],
           ),
         ),
         SizedBox(height: 27,),
         Padding(
           padding: const EdgeInsets.only(left:10.0,right: 10.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               ClipOval(
                 child: Material(
                   color: Colors.transparent, // Button color
                   child: InkWell(
                     splashColor: Colors.pink, // Splash color
                     onTap: () {
                       getStil();
                       showReview(context, stil1, baslik4);
                     },
                     child: SizedBox(width: 56, height: 56, child: Image.network("https://image.flaticon.com/icons/png/512/2258/2258437.png")),
                   ),
                 ),
               ),
               ClipOval(
                 child: Material(
                   color: Colors.transparent, // Button color
                   child: InkWell(
                     splashColor: Colors.pink, // Splash color
                     onTap: () {
                       getOlum();
                       showReview(context, olumlu1, baslik5);
                     },
                     child: SizedBox(width: 56, height: 56, child:Image.network("https://image.flaticon.com/icons/png/512/1533/1533913.png")),
                   ),
                 ),
               ),
               ClipOval(
                 child: Material(
                   color: Colors.transparent, // Button color
                   child: InkWell(
                     splashColor: Colors.pink, // Splash color
                     onTap: () {
                       getFilm();
                       showReview(context,film1,baslik6);
                     },
                     child: SizedBox(width: 56, height: 56, child: Image.network("https://image.flaticon.com/icons/png/512/922/922698.png")),
                   ),
                 ),
               ),
             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.only(left: 20,right: 20),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text("Stil",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
               Text("Olumlu Yönler",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
               Text("Film Önerisi",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
             ],
           ),
         ),
       ],
     ),
    );
  }
}
Future<bool> showReview(context,String ad,String baslik) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                height: 350.0,
                width: 200.0,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(height: 150.0),
                          Container(
                            height: 100.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                color: Colors.yellow),
                          ),
                          Positioned(
                              top: 50.0,
                              left: 94.0,
                              child: Container(
                                height: 90.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45.0),
                                    border: Border.all(
                                        color: Colors.white,
                                        style: BorderStyle.solid,
                                        width: 2.0),
                                    image: DecorationImage(
                                        image:
                                        NetworkImage("https://image.flaticon.com/icons/png/512/2647/2647303.png"),
                                        fit: BoxFit.cover)),
                              ))
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            baslik,
                            style: TextStyle(
                              fontFamily: 'Quicksand-Regular',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(ad,style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),),
                      ),
                      SizedBox(height: 10.0),
                      Divider(),
                      FlatButton(
                          child: Center(
                            child: Text(
                              'Tamam',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14.0,
                                  color: Colors.orangeAccent),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.transparent
                      )
                    ],
                  ),
                )));
      });
}
