import 'package:blood_donation_project/model/authentication.dart';
import 'package:blood_donation_project/model/doner_signUp_Firebase_Crud.dart';
import 'package:blood_donation_project/model/doner_signUp_model.dart';
import 'package:blood_donation_project/screen/bloodPost_Input.dart';
import 'package:blood_donation_project/screen/blood_post.dart';
import 'package:blood_donation_project/screen/contact.dart';
import 'package:blood_donation_project/screen/sigin_Up.dart';
import 'package:blood_donation_project/screen/bloodSearch.dart';
import 'package:blood_donation_project/screen/homePage.dart';
import 'package:blood_donation_project/screen/sign_in.dart';
import 'package:blood_donation_project/screen/update_blood_donation_date.dart';
import 'package:blood_donation_project/screen/update_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:blood_donation_project/screen/profile.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Appbar_BottomNav extends StatefulWidget {
  const Appbar_BottomNav({Key? key}) : super(key: key);

  @override
  State<Appbar_BottomNav> createState() => _Appbar_BottomNavState();
}

class _Appbar_BottomNavState extends State<Appbar_BottomNav> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  final Pages = [
    Blood_Post(),
    BloodSearch(),
    Home(),
    Contact(),
    Profile(isDonner: false, donerEmail: FirebaseAuth.instance.currentUser!.email ),
  ];

  var _page = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        color: ColorsResource.COLOR_PRIMARY,
        buttonBackgroundColor:ColorsResource.COLOR_PRIMARY,
        backgroundColor:Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: [
          Icon(
            Icons.post_add_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.contact_phone_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
      body: Pages[_page],
    );
  }
}

//---------------------Custom End Drawer---------

//----------------------------using set state-------------

class Custom_end_Drawer extends StatefulWidget {
  const Custom_end_Drawer({Key? key}) : super(key: key);

  @override
  State<Custom_end_Drawer> createState() => _Custom_end_DrawerState();
}

class _Custom_end_DrawerState extends State<Custom_end_Drawer> {

  String? userId = FirebaseAuth.instance.currentUser!.email;

  String name = "";
  String phone_number = "";
  String blood_group = "";
  String email = "";
  String last_donation_date = "";
  String donate_times = "";
  String image = "";


  void getData () async{
    User? user = await FirebaseAuth.instance.currentUser;
    var vari =await FirebaseFirestore.instance.collection("Doner Sing_Up").doc(user!.email).get();
    setState(() {
      name = vari.data()!["downer_name"];
      phone_number = vari.data()!["phone"];
      blood_group = vari.data()!["blood group"];
      email = vari.data()!["email"];
      last_donation_date = vari.data()!["last donate time"];
      donate_times = vari.data()!["times blood donate"];
      image = vari.data()!["images_url"];
    });
  }

  //signout function
  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Sign_in()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Column(
          children: [
            Container(
              height: 230,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorsResource.RED_DEEP,
                    ColorsResource.RED_DEEP_ONE
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    phone_number,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.bloodtype_outlined,
                color: Colors.red,
              ),
              title: Text(
                "Blood group : "+blood_group,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.mail,
                color: Colors.red,
              ),
              title: Text(
                email,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: Colors.red,
              ),
              title: Text(
                "Last blood donation :\n"+last_donation_date,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.directions_walk_outlined,
                color: Colors.red,
              ),
              title: Text(
                "How many times blood donate :\n"+donate_times,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.create_outlined,
                color: Colors.red,
              ),
              title: Text(
                "Update blood donation date",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Update_donation_date(
                  doner_singup: Doner_SignUp (
                    last_donet_time: last_donation_date,
                    times_blood_donet:donate_times,
                  ),
                )));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.create_outlined,
                color: Colors.red,
              ),
              title: Text(
                "Update profile",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Update_profile(
                  doner_singup: Doner_SignUp(
                    img_url: image,
                    name: name,
                    phone:phone_number,
                    blood_group: blood_group,
                    email: email,
                    last_donet_time: last_donation_date,
                    times_blood_donet:donate_times,
                  /*  position: 'position',
                    date_of_Birth: 'date of birth',
                    gender: 'gender',
                    divisiton: 'division',
                    distric: 'district',
                    union: 'union',
                    upazila: 'upazilla',*/

                  ),
                )));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.people_outlined,
                color: Colors.red,
              ),
              title: Text(
                "About Developer",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.share_outlined,
                color: Colors.red,
              ),
              title: Text(
                "Share",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
              title: Text(
                "Log out",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onTap: () {
                signOut();
              },
            ),
          ],
        ),
      ],
    ));
  }
}
