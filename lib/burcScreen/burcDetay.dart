
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;
class BurcDetay extends StatefulWidget {
  String burcAd;
  BurcDetay({this.burcAd});

  @override
  State<BurcDetay> createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  String burc_ozk;
   Future burcDetay()async{
     firestore.collection("burclar").where("burc_adı",isEqualTo:widget.burcAd).get().then((value){
       setState(() {
         for(var docs in value.docs) {
           burc_ozk = docs.data()["burc_özk"];
         }
       });
     });
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    burcDetay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            primary: true,
            backgroundColor: Colors.pink,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.burcAd+" Burcu ve Genel Özellikleri"),
              background: Image.asset("resim/"+widget.burcAd+"_büyük.png",fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Genel Özellikler",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                  ),
                  Text(burc_ozk.replaceAll("#","\n\n"),style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w400),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
