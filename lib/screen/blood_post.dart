import 'package:blood_donation_project/model/doner_post_Firebase_CRUD.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLuncher;
import 'package:blood_donation_project/screen/bloodPost_Input.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Blood_Post extends StatefulWidget {
  const Blood_Post({Key? key}) : super(key: key);

  @override
  State<Blood_Post> createState() => _Blood_PostState();
}

class _Blood_PostState extends State<Blood_Post> {

  final Stream <QuerySnapshot> collectionReference = Request_CRUD.read_blood_post();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Container(
          child: Icon(Icons.edit,size: 30,),
        ),
        onPressed:() {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BloodPostinput()));
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
      body:StreamBuilder(
          stream: collectionReference,
          builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
            if(snapshot.hasData){
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
                        Text("Blood group: "+e["blood group"],style: TextStyle(fontSize: 20,),),
                        SizedBox(height: 20,),
                        Text("Patient Problem: "+e["problem"],style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("Amount of blood: "+e["blood amount"] + "beg",style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("Location of blood donation: "+e["address"],style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("Date of blood donation: "+e["date_donate"],style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("Time of blood donation: "+e['time_donate'],style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("Patient ralative number: "+e["number"],style: TextStyle(fontSize: 20,),),
                        SizedBox(height: 20,),
                        Text("Hemoglobin: "+e["hemoglobin"],style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("Reference: "+e["reference"],style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Text("Other: "+e["other"],style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _makecall(e["number"]);
                                  },
                                  icon: Image.asset(
                                    'assets/images/phone-message.png',
                                  ),
                                ),
                                Text(
                                  "Call",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _makesms(e["number"]);
                                  },
                                  icon: Image.asset('assets/images/message.png'),
                                ),
                                Text(
                                  "Message",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
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
            }return Container();
          }
      ),
    );
  }
}
Future<void> _makecall(String phone) async {
  final Uri lunchuri = Uri(scheme: 'tel', path: '+88${phone}');
  await UrlLuncher.launchUrl(lunchuri);
}

Future<void> _makesms(String message) async {
  final Uri lunchuri = Uri(
    scheme: 'sms',
    path: '+88${message}',
  );
  await UrlLuncher.launchUrl(lunchuri);
}