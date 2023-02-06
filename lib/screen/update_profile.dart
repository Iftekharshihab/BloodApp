import 'package:blood_donation_project/model/authentication.dart';
import 'package:blood_donation_project/model/doner_signUp_model.dart';
import 'package:blood_donation_project/screen/homePage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:blood_donation_project/screen/sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blood_donation_project/custom/date.dart';
import 'package:blood_donation_project/model/doner_signUp_Firebase_Crud.dart';
import 'package:blood_donation_project/screen/bottomNavigationbar_custom_End_Drawer.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class Update_profile extends StatefulWidget {
  final Doner_SignUp ? doner_singup;
   Update_profile({Key? key, this.doner_singup}) : super(key: key);

  @override
  State<Update_profile> createState() => _Update_profileState();
}

class _Update_profileState extends State<Update_profile> {
  final nameContoller = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final bloodDonateControler = TextEditingController();
  final positionController = TextEditingController();

  clear (){
    nameContoller.clear();
    phoneController.clear();
    emailController.clear();
    bloodDonateControler.clear();
    phoneController.clear();
    positionController.clear();
  }

  bool _isvisiable = false;

  //--------------------Form key------------
  final _formkey = GlobalKey<FormState>();

  //-----------------Date--------------
  String date="Birth date";

  //----------------------last date blood donate----------
  String donateDate="Last donate data";
  //---------------------------Radia button--------
  String ? _gender;

  //-----------------------Blood Choice-----------
  String? BloodChoice;
  List BloodItem = [
    "AB+",
    "AB-",
    "O+",
    "O-",
    "B+",
    "B-",
    "A+",
    "A-",
  ];

  //-------------------- drop down permanent address-----------
  String? DivisionChoose;
  String? DistrictChoise;
  String? UpazilasChoise;
  String? unionChoise;

  List DivisionItem = [
    "Dhaka",
    "Chittagong",
    "Rajshahi",
    "Sylhet",
    "Khulna",
    "Barisal",
    "Rangpur",
    "Mymensingh",
  ];
  List DistrictItem = [
    "Dhaka",
    "Gazipur",
    "Kishoreganj",
    "Manikganj",
    "	Munshiganj",
    "Narayanganj",
    "Narsingdi",
    "Tangail",
    "Faridpur",
    "Gopalganj",
    "Madaripur",
    "Rajbari",
    "Shariatpur",
  ];
  List Upazilas = [
    "Dohar",
    "Keraniganj",
    "Dhamrai",
    "Nawabganj",
    "Savar",
  ];
  List Union = [
    'Kagirbag',
    'pachgocia',
    'dagonbhuiyan',
  ];

  //----------------------------Init State----------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameContoller.value = TextEditingValue(text: widget.doner_singup!.name.toString());
  // String file = widget.doner_singup!.img_url.toString();
    phoneController.value = TextEditingValue(text: widget.doner_singup!.phone.toString());
    date = widget.doner_singup!.date_of_Birth.toString();
    positionController.value = TextEditingValue(text: widget.doner_singup!.position.toString());
    _gender = widget.doner_singup!.gender.toString();
    BloodChoice = widget.doner_singup!.blood_group.toString();
    bloodDonateControler.value = TextEditingValue(text: widget.doner_singup!.times_blood_donet.toString());
    donateDate = widget.doner_singup!.last_donet_time.toString();
   /*  DivisionChoose = widget.doner_singup!.divisiton.toString();
     DistrictChoise = widget.doner_singup!.distric.toString();
     UpazilasChoise = widget.doner_singup!.upazila.toString();
     unionChoise = widget.doner_singup!.union.toString();*/
     emailController.value = TextEditingValue(text: widget.doner_singup!.email.toString());
  }



/*


  //------------------------- images section--------------
  String fileName="";
  File? file;
  final picker = ImagePicker();
  //-------------------------------camera function-------
  void _chooseCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
//----------------------galery function-----------
  void _chooseGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (file == null) return;
    DateTime dateTime = DateTime.now();

    final destination = 'user/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination).child('$dateTime');

      await ref.putFile(file!).snapshotEvents.listen((event) {
        switch(event.state)  {
          case TaskState.running:
            EasyLoading.show(status: "Your Image Uploading...");
*/
/*            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Text("Your Image Uploading..."),
                  );
                }
            );*//*

            break;
          case TaskState.success:
            EasyLoading.dismiss();
            registration(ref);
            break;
          case TaskState.canceled:
            EasyLoading.dismiss();
            EasyLoading.showError("Image Upload Failed");
*/
/*            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Text("Image Upload Failed"),
                  );
                }
            );*//*


            break;

        }
      });

    } catch (e) {
      print('error occured');
    }
  }


*/




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 10,),

            Center(
              child: Text("Update Profile",style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black,
                      offset: Offset(3, 4),
                    ),
                  ]
              ),
              ),
            ),

            //------------------------------Images section-------------
    /*        Center(
              child:Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 250,
                  ),

                  file != null ? Container(
                    height: 150,
                    width: 200,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(file!),
                    ),
                  )
                      :Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigoAccent.shade100,
                    ),
                    child: Text("No Images select",style: TextStyle(fontSize: 20),),
                  ),
                  Positioned(
                    left: 150,
                    top: 130,
                    child: InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text("Choice option"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          _chooseCamera();
                                        },child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.camera_alt),SizedBox(width: 10,),
                                          Text("Camera")
                                        ],
                                      ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          _chooseGallery();
                                        },child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.collections_outlined,
                                          ),SizedBox(width: 10,),
                                          Text("Gallery"),
                                        ],
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.indigo,
                        child: Icon(Icons.camera_alt, size: 25,
                          color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
*/
            Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(height: 20,),

                  //-----------------------------------Name---------
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameContoller,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person,color: Colors.grey,),
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 15,top: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),

                  //------------------------------Phone number--------
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.call,color: Colors.grey,),
                      labelText: "Phone Number",
                      labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 15,top: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),


               /*   //-------------------Birth date---------------
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () async{
                      DateTime ? datetime = await getDate(context);
                      String ? day;
                      String ? month;
                      String ? year;

                      datetime!.day<10 ? day = '0${datetime.day}' : day = '${datetime.day}';
                      datetime.month <10 ? month = '0${datetime.month}' : month = '${datetime.month}';
                      year = '${datetime.year}';
                      date = '$day - $month - $year';
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color:Colors.black26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(date,style: TextStyle(fontSize: 18),),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(Icons.calendar_month,color: Colors.grey,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
*/
                  //----------------Position-------------
             /*     SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: positionController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.assignment_ind_outlined,color: Colors.grey,
                      ),
                      labelText: "Position",
                      labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 15,top: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),
*/
                  //------------------------Select gender-------------
/*

                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text("Your gender",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: "Male",
                            groupValue: _gender,
                            onChanged: (String ? variable){
                              setState(() {
                                _gender = variable!;
                              });
                            },
                          ),
                          Text("Male"),
                        ],
                      ),

                      Row(
                        children: [
                          Radio(
                            value: "Female",
                            groupValue: _gender,
                            onChanged: (String? variable){
                              setState(() {
                                _gender = variable;
                              });
                            },
                          ),
                          Text("Female"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: "Other",
                            groupValue: _gender,
                            onChanged: (String ? variable){
                              setState(() {
                                _gender = variable;
                              });
                            },
                          ),
                          Text("Other"),
                        ],
                      ),
                    ],
                  ),
*/

                  //-------------------------select blood group-------------

                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color:Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButton(
                        hint: Text("Select blood group", style: TextStyle(color: Colors.black),),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black26,),
                        iconSize: 30,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        value: BloodChoice,
                        onChanged: (value){
                          setState(() {
                            BloodChoice = value as String?;
                          });
                        },
                        items: BloodItem.map((valueItem){
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  //------------------------blood donate times --------------

                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: bloodDonateControler,
                    decoration: InputDecoration(
                      labelText: "How many times have you donate blood?",
                      labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 15,top: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),

                  //------------------------last date blood donate--------------
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () async{
                      DateTime ? datetime = await getDate(context);
                      String ? day;
                      String ? month;
                      String ? year;

                      datetime!.day<10 ? day = '0${datetime.day}' : day = '${datetime.day}';
                      datetime.month <10 ? month = '0${datetime.month}' : month = '${datetime.month}';
                      year = '${datetime.year}';
                      donateDate = '$day - $month - $year';
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color:Colors.black26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(donateDate,style: TextStyle(fontSize: 18),),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(Icons.calendar_month,color: Colors.grey,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

               /*   SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child:  Text("Address",style: TextStyle(fontSize: 20),),
                    ),
                  ),


                  SizedBox(height: 20,),
                  //-------------------------Drop down section------------
                  //------------------------------Division
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButton(
                        hint: Text("Division", style: TextStyle(color: Colors.black,),),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black26,),
                        iconSize: 30,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        value: DivisionChoose,
                        onChanged: (value){
                          setState(() {
                            DivisionChoose = value as String?;
                          });
                        },
                        items: DivisionItem.map((valueItem){
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),


                  //----------------------District------------
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButton(
                        hint: Text("District", style: TextStyle(color: Colors.black,),),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black26,),
                        iconSize: 30,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        value: DistrictChoise,
                        onChanged: (value){
                          setState(() {
                            DistrictChoise = value as String?;
                          });
                        },
                        items: DistrictItem.map((valueItem){
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  //-------------------------Upazila----------
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButton(
                        hint: Text("Upazilas", style: TextStyle(color: Colors.black,),),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black26,),
                        iconSize: 30,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        value: UpazilasChoise,
                        onChanged: (value){
                          setState(() {
                            UpazilasChoise = value as String?;
                          });
                        },
                        items: Upazilas.map((valueItem){
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  //-------------------------Union-----------------
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButton(
                        hint: Text("Union", style: TextStyle(color: Colors.black, ),),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black26,),
                        iconSize: 30,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        value: unionChoise,
                        onChanged: (value){
                          setState(() {
                            unionChoise = value as String?;
                          });
                        },
                        items: Union.map((valueItem){
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
*/
            //------------------------Email address---------
            SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-z0-9!.@]')),
              ],
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.email_rounded,color: Colors.grey,),
                labelText: "Email Address ",
                labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.black26,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.black26,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 15,top: 10),
              ),
              validator: (value) {
                if(value!.isEmpty){
                  return 'Enter your email';
                }
                else if(!value.contains('@') || !value.contains('.')){
                  return 'Invalid Email';
                }else{
                  return null;
                }
              },
            ),

            SizedBox(height: 20,),

            SizedBox(height: 20,),
            InkWell(
              onTap: () async{
                if (_formkey.currentState!.validate()) {
                  var response = await Doner_Firebase_Crud.Update_Profile(
                    //img_url: image_url ?? " ",
                    name: nameContoller.text,
                    phone: phoneController.text,
                    //date_of_Birth:date,
                  //  gender:_gender,
                    blood_group: BloodChoice.toString(),
                    times_blood_donet: bloodDonateControler.text,
                    last_donet_time: donateDate,
                    /* divisiton: DivisionChoose.toString(),
                      distric: DistrictChoise.toString(),
                      upazila: UpazilasChoise.toString(),
                      union: unionChoise.toString(),*/
                    email:emailController.text,
                    //  doc_Id :emailController.text,
                    //  position: positionController.text,


                  );
                  if(response.code == 200){
                    //-----------------------------Easy loading---------
                    EasyLoading.showSuccess("Update profile");

                    /*showDialog(context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              });*/
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Appbar_BottomNav()));
                  }
                  else{
                    //------------------------Easyloading--------

                    EasyLoading.showError("Update Failed");

                    /*showDialog(context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              });*/
                  }
                  clear();
                 // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Appbar_BottomNav()), (route) => false);
                }
              },child: Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child:  Text("Update",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorsResource.RED_DEEP,
              ),
            ),
            ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },child:  Text("Skip",style: TextStyle(fontSize: 20),),
                    ),
                  ),

          ],
        ),
      ),
      ],
      ),
      ) ,
    );
  }



  /*void registration (var ref)async{
    String  image_url= await ref.getDownloadURL();
        var response = await Doner_Firebase_Crud.Update_Profile(
          //img_url: image_url ?? " ",
          name: nameContoller.text,
          phone: phoneController.text,
          date_of_Birth:date,
          gender:_gender,
          blood_group: BloodChoice.toString(),
          times_blood_donet: bloodDonateControler.text,
          last_donet_time: donateDate,
         *//* divisiton: DivisionChoose.toString(),
          distric: DistrictChoise.toString(),
          upazila: UpazilasChoise.toString(),
          union: unionChoise.toString(),*//*
          email:emailController.text,
        //  doc_Id :emailController.text,
        //  position: positionController.text,


        );
        if(response.code == 200){
          //-----------------------------Easy loading---------
          EasyLoading.showSuccess("Update profile");

          *//*showDialog(context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              });*//*
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Appbar_BottomNav()));
        }
        else{
          //------------------------Easyloading--------

          EasyLoading.showError("Update Failed");

          *//*showDialog(context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              });*//*
        }
      }*/

  }

