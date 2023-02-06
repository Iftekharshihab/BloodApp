import 'package:blood_donation_project/custom/custom_profile_Firebase.dart';
import 'package:blood_donation_project/screen/about.dart';
import 'package:blood_donation_project/screen/bottomNavigationbar_custom_End_Drawer.dart';
import 'package:blood_donation_project/screen/bloodPost_Input.dart';
import 'package:blood_donation_project/screen/blood_post.dart';
import 'package:blood_donation_project/screen/sigin_Up.dart';
import 'package:blood_donation_project/screen/bloodSearch.dart';
import 'package:blood_donation_project/screen/homePage.dart';
import 'package:blood_donation_project/screen/profile.dart';
import 'package:blood_donation_project/screen/sign_in.dart';
import 'package:blood_donation_project/screen/update_blood_donation_date.dart';
import 'package:blood_donation_project/screen/update_profile.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation project',
      theme: ThemeData(
        fontFamily: 'Lato'
      ),
      home: Splash_screen(),
      builder: EasyLoading.init(),
    );
  }
}


class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async{
      if (await FirebaseAuth.instance.currentUser != null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Appbar_BottomNav()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Sign_in()), (route) => false);
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 300,
              child: Image.asset("assets/images/slide3.jpg"),
            ),
            SizedBox(height: 20,),
            CircularProgressIndicator(color: ColorsResource.COLOR_PRIMARY,),
          ],
        ),
      ),
    );
  }
}

