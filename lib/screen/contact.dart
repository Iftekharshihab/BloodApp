import 'package:blood_donation_project/screen/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 60,
        backgroundColor: ColorsResource.RED,
        leading: Image.asset("assets/icons/bloodLogo.png"),
        title: Text(
          "Blood Bank",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Doner Sing_Up").snapshots(),
                builder: (context,snapshot){
                  return !snapshot.hasData ? Center(child: CircularProgressIndicator(),):
                  ListView.builder(itemCount: snapshot.data!.docs.length,
                      itemBuilder:(context,index){
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(isDonner: true, donerEmail: data["email"])));
                          },
                          child: Card(
                              child:Padding(
                                padding: const EdgeInsets.only(left: 20,bottom: 10,top: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(data["images_url"]),
                                      ),
                                      height: 60,
                                      width: 60,
                                    ),SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data["downer_name"],style: TextStyle(fontSize: 20),),
                                      //  SizedBox(height: 5,),
                                      //  Text("Blood group: "+data["blood group"],style: TextStyle(fontSize: 18),),
                                      //  SizedBox(height: 5),
                                      //  Text("Last donate date: "+data["last donate time"],style: TextStyle(fontSize: 18),),
                                        SizedBox(height: 5,),
                                        Text("Address: "+data["division"]+","+data["district"],style: TextStyle(fontSize: 18),),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),
                        );
                      });
                }
            ),
          ),
        ],
      ),
    );
  }
}
