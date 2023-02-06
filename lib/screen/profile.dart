
import 'package:url_launcher/url_launcher.dart' as UrlLuncher;
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {

  //----------- doner ar profile show korar jonno is doner false
  // ---------- prothome j sign up korbe se current user hobe
  //------------ onno donar ar profile show korar jonno isDoner true hobe
  //------------- ar doner email diya documentation kora to tai doner email deya hoyese
  bool isDonner=false;
  String? donerEmail;
  Profile({Key? key,required this.isDonner,required this.donerEmail}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name = "";
  String position = "";
  String phone_number = "";
  String blood_group = "";
  String email = "";
  String last_donation_date = "";
  String donate_times = "";
  String image = "";
  String address = "";


  void getData () async{
    User? user = await FirebaseAuth.instance.currentUser;                 //---- akhane doc ar moode
                                                                          // ---user id dita hobe---
                                                                          //---user!.email dila current user
                                                                          // ar profile dekhabe shudu
    var vari =await FirebaseFirestore.instance.collection("Doner Sing_Up").doc(user_Id).get();
    setState(() {
      name = vari.data()!["downer_name"];
      phone_number = vari.data()!["phone"];
      blood_group = vari.data()!["blood group"];
      email = vari.data()!["email"];
      last_donation_date = vari.data()!["last donate time"];
      donate_times = vari.data()!["times blood donate"];
      image = vari.data()!["images_url"];
      position = vari.data()!['position'];
      address = vari.data()!["division"];
    });
  }

  //-----------------------akhane ata user id neya hoyse ce multiple doner ar profile show
  //---------------------- korar jonno
  String? user_Id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //--------------------- initstate ae profile show korar jornno chek korbe if else diya
    //--------------------   jodi true hoy onno joner profile show korbe
    //----------------------jodi false hoy tahole current user ar profile show korbe
    if(widget.isDonner){
      user_Id=widget.donerEmail;
    }else{
      user_Id= FirebaseAuth.instance.currentUser!.email;
    }
    //-----------ata single user ar data anar jonno
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          Column(
            children: [
              //---------------------Picture---------
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.indigo.shade200,Colors.indigoAccent.shade200]),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 85, left: 30),
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              color: Colors.black,
                              image: DecorationImage(
                                image: NetworkImage(
                                  image,
                                ),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 65, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              width: 200,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Text(
                                position,
                                style:
                                    TextStyle(fontSize: 22, color: Colors.grey),
                              ),
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //-------------------------call messege mail whatapp -------------

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Blood Group",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Text(
                        blood_group,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 50,
                    width: 3,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        "Donate Times",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Text(
                        donate_times+"X",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          _makecall(phone_number);
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
                          _makesms(phone_number);
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
              SizedBox(
                height: 30,
              ),
              ListTile(
                leading: Icon(
                  Icons.smartphone_outlined,
                ),
                title: Text(
                  "Number",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(phone_number, style: TextStyle(fontSize: 16)),
              ),
              ListTile(
                leading: Icon(
                  Icons.email_outlined,
                ),
                title: Text(
                  "Email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(email,
                    style: TextStyle(fontSize: 16)),
              ),
              ListTile(
                leading: Icon(
                  Icons.place_outlined,
                ),
                title: Text(
                  "Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle:
                    Text(address, style: TextStyle(fontSize: 16)),
              ),
              ListTile(
                leading: Icon(
                  Icons.date_range_outlined,
                ),
                title: Text(
                  "Last Donate",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  last_donation_date,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ]),
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
