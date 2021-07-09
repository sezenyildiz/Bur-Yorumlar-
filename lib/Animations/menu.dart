import 'package:burc_yorum/burcScreen/burcDetay.dart';
import 'package:burc_yorum/burcScreen/yorumGunluk.dart';
import 'package:burc_yorum/profil/prof_Screen.dart';
import 'package:burc_yorum/screen/HomeLogin.dart';
import 'package:burc_yorum/screen/hakkimizda.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
FirebaseFirestore firestore=FirebaseFirestore.instance;
class Menu extends StatefulWidget {
  const Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("burclar").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot>querySnapshot) {
            if (!querySnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var list=querySnapshot.data.docs;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  String burcadi=list[index]["burc_adı"];
                  String burctarih=list[index]["burc_tarih"];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BurcDetay(burcAd:burcadi)));
                        },
                        leading:Image.asset("resim/"+burcadi+".png",width: 64,height: 64,),
                        title: Text(burcadi,style: TextStyle(fontSize:24,fontWeight: FontWeight.w400,color: Colors.pink.shade500),),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top:4.0,bottom: 4),
                          child: Text(burctarih,style: TextStyle(fontSize:18,fontWeight: FontWeight.w300,color: Colors.black),),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color:Colors.pink,),
                      ),
                    ),
                  );
                },
              );
            }
          }
      ),
      floatingActionButton: BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: true,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(Icons.accessibility, color: Colors.black),
            title: "Profilim",
            titleColor: Colors.white,
            subtitle: "Profilinize Gitmek İçin Tıklayınız",
            subTitleColor: Colors.white,
            backgroundColor: Colors.deepOrange,
            onTap: () =>  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilScreen())),
          ),
          MenuItem(
            child: Icon(Icons.brush, color: Colors.black),
            title: "Burç Yorumları",
            titleColor: Colors.white,
            subtitle: "Günlük Burç Yorumları",
            subTitleColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GunlukYorum())),
          ),
          MenuItem(
            child: Icon(Icons.keyboard_voice, color: Colors.black),
            title: "Hakkımızda",
            titleColor: Colors.white,
            subtitle: "Uygulamamız ile İlgili Detaylar",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue.shade900,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => hakkimizda())),
          ),
          MenuItem(
            child: Icon(Icons.exit_to_app, color: Colors.black),
            title: "Çıkış",
            titleColor: Colors.white,
            subtitle: "Çıkış",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue,
            onTap: () => showAlertDialog(context),
          )
        ],
      ),
    );
  }
}
showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Hayır"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Evet"),
    onPressed:  () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Çıkış Yap"),
    content: Text("Çıkış Yapmak İstiyor Musunuz?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
