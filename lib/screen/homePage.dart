import 'package:blood_donation_project/screen/about.dart';
import 'package:blood_donation_project/screen/contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_donation_project/custom/customGrid_Button.dart';
import 'package:blood_donation_project/screen/activities_post.dart';
import 'package:blood_donation_project/screen/bottomNavigationbar_custom_End_Drawer.dart';
import 'package:blood_donation_project/screen/blood_post.dart';
import 'package:blood_donation_project/screen/sigin_Up.dart';
import 'package:blood_donation_project/screen/bloodSearch.dart';
import 'package:blood_donation_project/screen/profile.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();



  //-----------Slider images---------
  List imageList = [
    {"id":1, "image_path":"assets/images/slide1.jpg"},
    {"id":2, "image_path":"assets/images/slide2.jpg"},
    {"id":3, "image_path":"assets/images/slide3.jpg"},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Icon(
              Icons.menu_outlined,
              size: 35,
            ),
          ),
        ],
      ),
      endDrawer: Custom_end_Drawer(),
      body: ListView(
        children: [

          //----------------------Carousel slide-----------------
          Stack(
            children: [
              InkWell(
                onTap: () {
                  print(currentIndex);
                },
                child: CarouselSlider(
                  items: imageList
                      .map(
                        (item) => Image.asset(
                      item['image_path'],
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  )
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
                      child: Container(
                        width: currentIndex == entry.key ? 17 : 7,
                        height: 7.0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == entry.key
                                ? Colors.black
                                : Colors.teal),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),



          SizedBox(height: 60,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 270,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorsResource.MIDDEL_HOMEPAGE,
                border: Border.all(width: 2,color: ColorsResource.COLOR_PRIMARY),
              ),
              child:Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing:20,
                  children:[
                    CustomGrid(image: Image.asset("assets/images/search.png",color: ColorsResource.RED_DEEP_ONE,), titel: "Blood Search", onTap: () => BloodSearch()),
                    CustomGrid(image: Image.asset("assets/images/post.png",color: ColorsResource.RED_DEEP_ONE), titel: "Post for blood", onTap: () => Blood_Post()),
                    CustomGrid(image: Image.asset("assets/images/account.png",color: ColorsResource.RED_DEEP_ONE), titel: "Profile", onTap: () => Profile(isDonner: false, donerEmail: FirebaseAuth.instance.currentUser!.email)),
                    CustomGrid(image: Image.asset("assets/images/activities.png",color: ColorsResource.RED_DEEP_ONE), titel: "Activities", onTap: () => Activities_post()),
                    CustomGrid(image: Image.asset("assets/images/contact.png",color: ColorsResource.RED_DEEP_ONE), titel: "Contact", onTap: () => Contact()),
                    CustomGrid(image: Image.asset("assets/images/about.png",color: ColorsResource.RED_DEEP_ONE), titel: "About", onTap :() => About()),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
