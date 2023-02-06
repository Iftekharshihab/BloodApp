import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLuncher;
import 'package:blood_donation_project/model/doner_signUp_Firebase_Crud.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
class Custom_profile extends StatefulWidget {
  const Custom_profile({Key? key}) : super(key: key);

  @override
  State<Custom_profile> createState() => _Custom_profileState();
}

class _Custom_profileState extends State<Custom_profile> {

  //--------------firestore strem---------------
  final Stream <QuerySnapshot> collectionReference = Doner_Firebase_Crud.readsignUpDoner();
  String? user_id=FirebaseAuth.instance.currentUser!.phoneNumber;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:StreamBuilder(
            stream:FirebaseFirestore.instance.collection("SignUp")
                .where("user_id", isEqualTo: user_id).snapshots(),
            builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs.map((e) {
                    return Column(
                      children: [
                        //---------------------Picture---------
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                            ),
                            Container(
                              height: 150,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.redAccent,
                                    Colors.red,
                                    Colors.pink
                                  ],
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 85, left: 30),
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        border: Border.all(
                                          color: Colors.white, width: 3,),
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=",),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 75, left: 20),
                                  child: Column(
                                    children: [
                                      Text(e["downer_name"], style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Text("Apps Developer", style: TextStyle(
                                          fontSize: 20, color: Colors.grey),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //-------------------------call message mail whatsapp -------------

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Blood Group", style: TextStyle(
                                    color: Colors.black, fontSize: 25),),
                                Text(e["blood group"], style: TextStyle(color: Colors.red,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ), SizedBox(width: 15,),
                            Container(
                              height: 50,
                              width: 3,
                              color: Colors.black,
                            ), SizedBox(width: 15,),
                            Column(
                              children: [
                                Text("Donate Times", style: TextStyle(
                                    color: Colors.black, fontSize: 25),),
                                Text(e["times blood donate"]+"X", style: TextStyle(color: Colors.red,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    FlutterPhoneDirectCaller.callNumber(e["phone"]);

                                  },
                                  icon: Image.asset(
                                      'assets/images/phone-message.png'),
                                ),
                                Text("Call", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {

                                  },
                                  icon: Image.asset(
                                      'assets/images/whatsapp.png'),
                                ),
                                Text("Whatapp", style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {

                                  },
                                  icon: Image.asset('assets/images/gmail.png'),
                                ),
                                Text("email", style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _makesms(e["phone"]);
                                  },
                                  icon: Image.asset(
                                      'assets/images/message.png'),
                                ),
                                Text("Message", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        ListTile(
                          leading: Icon(
                            Icons.smartphone_outlined,
                          ),
                          title: Text("Number", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(
                              e["phone"], style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email_outlined,
                          ),
                          title: Text("Email", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(e["email"],
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.transgender_outlined,
                          ),
                          title: Text("Gender", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(
                              e["gender"],
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.date_range_outlined,
                          ),
                          title: Text("Last Donate", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(
                            e["last donate time"], style: TextStyle(fontSize: 16),),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.date_range,
                          ),
                          title: Text("Birthdate", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(
                            e["date of birth"], style: TextStyle(fontSize: 16),),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_city,
                          ),
                          title: Text("Divisiton", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(
                            e["division"], style: TextStyle(fontSize: 16),),
                        ),

                        ListTile(
                          leading: Icon(
                            Icons.location_history,
                          ),
                          title: Text("Distric", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(
                            e["district"], style: TextStyle(fontSize: 16),),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_history,
                          ),
                          title: Text("upazila", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(
                            e["upazilla"], style: TextStyle(fontSize: 16),),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_city_outlined,
                          ),
                          title: Text("union", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          subtitle: Text(
                            e["union"], style: TextStyle(fontSize: 16),),
                        ),

                      ],
                    );

                  }).toList(),
                );
              }
              return Container();
            },
        ),
      ),
    );
  }
}

Future <void> _makecall (String phone) async {
  final Uri lunchuri = Uri(
      scheme: 'tel',
      path: '+88${phone}'
  );
  await UrlLuncher.launchUrl(lunchuri);
}

Future <void> _makesms (String message) async{
  final Uri lunchuri = Uri(
    scheme: 'sms',
    path: '+88${message}',
  );
  await UrlLuncher.launchUrl(lunchuri);
}