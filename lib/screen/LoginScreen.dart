import 'package:burc_yorum/Animations/FadeAnime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
var kullanici = TextEditingController();
var sifre = TextEditingController();
var _adSoy = TextEditingController();
var _burc = TextEditingController();
var _cinsy;
var _bur;
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  @override
  void kayitOl() async{
    try {
      UserCredential _user=await auth.createUserWithEmailAndPassword(
          email: kullanici.text, password: sifre.text);
      User _newUser=_user.user;
      await _newUser.sendEmailVerification();
      Map<String,dynamic>ekle=Map();
      ekle["_adSoyad"]=_adSoy.text;
      ekle["_burc"]=_burc.text;
      ekle["_cinsiyet"]=_cinsy.toString();
      ekle["_burc"]=_bur.toString();
      firestore.collection("users").doc(FirebaseAuth.instance.currentUser.email).set(ekle).then((_){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Lütfen Mailinizi Onaylayınız."),
        ));
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MyHomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Şifreniz Minimum 6 Haneli Olmalıdır"),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Bu Mail Adresi ile Daha Önce Kayıt Yapılmış"),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.grey,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: FadeAnimation(1.2, Text("Kayıt Ol",
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              FadeAnimation(1.5, Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[300]))
                      ),
                      child: TextField(
                        controller: _adSoy,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                            hintText: "Adınız-Soyadınız"
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                      ),
                      child: TextField(
                        controller: kullanici,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                            hintText: "Mail Adresiniz"
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                      ),
                      child: TextField(
                        obscureText: true,
                        controller: sifre,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                            hintText: "Şifreniz"
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                      ),
                      child: DropdownButton<String>(
                        focusColor:Colors.white,
                        value: _cinsy,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor:Colors.black,
                        items: <String>[
                          'Erkek',
                          'Kız',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color:Colors.black),),
                          );
                        }).toList(),
                        hint:Text(
                          "Cinsiyetinizi Seçiniz",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _cinsy = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                      ),
                      child: DropdownButton<String>(
                        focusColor:Colors.white,
                        value: _bur,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor:Colors.black,
                        items: <String>[
                          'Akrep',
                          'Aslan',
                          'Balık',
                          'Başak',
                          'Boğa',
                          'Koç',
                          'Kova',
                          'Oğlak',
                          'Terazi',
                          'Yay',
                          'Yengeç',
                          'İkizler',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color:Colors.black),),
                          );
                        }).toList(),
                        hint:Text(
                          "Burcunuzu Seçiniz",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _bur = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(height: 40,),
              FadeAnimation(1.8, Center(
                child: Container(
                  width: 120,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue[800]
                  ),
                  child: Center(child: InkWell(
                    onTap: (){
                      print("basma lan");
                      kayitOl();
                    },
                      child: Text("Kayıt Ol", style: TextStyle(color: Colors.white.withOpacity(.7)),))),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}