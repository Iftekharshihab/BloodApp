import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_donation_project/model/activities_post_CRUD.dart';
import 'package:blood_donation_project/screen/activities_post.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class Activities_Input extends StatefulWidget {
  const Activities_Input({Key? key}) : super(key: key);

  @override
  State<Activities_Input> createState() => _Activities_InputState();
}

class _Activities_InputState extends State<Activities_Input> {
  final _activities_titel = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  //------------------------------Account user name---------
  String name = "";
  void getData () async{
    User? user = await FirebaseAuth.instance.currentUser;
    var vari =await FirebaseFirestore.instance.collection("Doner Sing_Up").doc(user!.email).get();
    setState(() {
      name = vari.data()!["downer_name"];
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData ();
  }

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

  //---------------------------------------Photo and input upload--------
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
/*            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Text("Your Image Uploading..."),
                  );
                }
            );*/
            break;
          case TaskState.success:
            EasyLoading.dismiss();
            //--------------------------------registration function-----------
            registration(ref);
            break;
          case TaskState.canceled:
            EasyLoading.dismiss();
            EasyLoading.showError("Image Upload Failed");
/*            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Text("Image Upload Failed"),
                  );
                }
            );*/

            break;

        }
      });

    } catch (e) {
      print('error occured');
    }
  }

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
        padding: EdgeInsets.only(left: 30,right: 30,top: 30),
        children: [
          Form(
            key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: Colors.black,
                    controller: _activities_titel,
                    decoration: InputDecoration(
                      labelText: "About activities",
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
                      contentPadding: EdgeInsets.only(top: 10,left: 15),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'This field is required';
                      }
                    },
                  ),
                  SizedBox(height: 20,),

                  file != null ? Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(file!,fit: BoxFit.cover,),
                  )
                      :Container(

                  ),
                  SizedBox(height: 20,),
                  InkWell(
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
                    child:Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 150,
                      child: Text("Choice Image",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                      decoration: BoxDecoration(
                        color: ColorsResource.GREEN,
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
                  Center(
                    child: InkWell(
                      onTap: ()async{
                        if(_formkey.currentState!.validate()){
                          uploadFile();

                        }
                      },child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorsResource.COLOR_PRIMARY,
                        ),
                        child: Text("Upload Post",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
  void registration (var ref)async{
    String  image_url= await ref.getDownloadURL();

        var response = await Activities_CRUD.activities_add(
         img: image_url,
          titel: _activities_titel.text,
            post_name: name ?? "",

        );
        if(response.code == 200){
          //-----------------------------Easy loading---------
          EasyLoading.showSuccess("Activities post Success");

          /*showDialog(context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              });*/
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Activities_post()));
        }
        else{
          //------------------------Easyloading--------

          EasyLoading.showError("Failed");

          /*showDialog(context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              });*/
        }
      }

  }

