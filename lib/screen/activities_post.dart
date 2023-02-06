
import 'package:blood_donation_project/model/activities_post_CRUD.dart';
import 'package:blood_donation_project/screen/activities_post_input.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Activities_post extends StatefulWidget {
  const Activities_post({Key? key}) : super(key: key);

  @override
  State<Activities_post> createState() => _Activities_postState();
}

class _Activities_postState extends State<Activities_post> {

  final Stream <QuerySnapshot> collectionReference = Activities_CRUD.read_activities();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Container(
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 20,),
                  Text("Post", style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),),
                ],
              )
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Activities_Input()));
          },
          backgroundColor: ColorsResource.COLOR_PRIMARY,
        ),
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

        body: StreamBuilder(
            stream: collectionReference,
            builder: (BuildContext context,
                AsyncSnapshot <QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                children: snapshot.data!.docs.map((e){
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30,right: 30,top: 30,bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: ColorsResource.COLOR_PRIMARY,
                                  ),
                                  child: Icon(Icons.person,color: Colors.white,),
                                ),
                                SizedBox(width: 20,),
                                Text(e["name"],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(e["titel"],style: TextStyle(fontSize: 18),),
                          SizedBox(height: 20,),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(e["img"],fit: BoxFit.cover,),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(e["date"] ?? "",style: TextStyle(fontSize: 12),),
                              const SizedBox(width: 15,),
                              Text(e["time"] ?? "",style: TextStyle(fontSize: 12)),
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                }).toList(),
                );
              }
              return Container();
            }
        ),
    );
  }
}
