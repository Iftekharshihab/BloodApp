import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_donation_project/custom/date.dart';
import 'package:blood_donation_project/model/doner_post_Firebase_CRUD.dart';
import 'package:blood_donation_project/screen/blood_post.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BloodPostinput extends StatefulWidget {
  const BloodPostinput({Key? key}) : super(key: key);

  @override
  State<BloodPostinput> createState() => _BloodPostinputState();
}

class _BloodPostinputState extends State<BloodPostinput> {

  //-------------------Controller ----------------
  final patient_problem = TextEditingController();
  final amount_of_blood = TextEditingController();
  final blood_donation_address = TextEditingController();
  final patient_relative_number = TextEditingController();
  final hemoglobin = TextEditingController();
  final reference = TextEditingController();
  final other = TextEditingController();

  final timeinput = TextEditingController();

  //---------------------------form key-------
  final _formkey = GlobalKey<FormState>();

  //-----------------Date--------------
  String date="Date of blood donation";
  //---------------Time--------------
  TimeOfDay selectedTime = TimeOfDay.now();


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

  //---------------------------------Account User name --------------

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

    //--------------Time controler k show korar jono inite state call kora hoyse.Not firebase ar jonno

    timeinput.text = "";
    getData ();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: ListView(
            padding: const EdgeInsets.only(left: 20,right: 20),
            children: [
              SizedBox(height: 20,),
             Center(
               child: Text("Send request for blood",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
             ),

              SizedBox(height: 30,),

              Form(
                key: _formkey,
                  child: Column(
                    children: [
                      //---------------------------------select blood dropdown------
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


                      //-----------Patient problem--------
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: patient_problem,
                        decoration: InputDecoration(
                          labelText: "Patient problem",
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

                      //--------------------------amount of blood-------------
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: amount_of_blood,
                        decoration: InputDecoration(
                          labelText: "Amount of blood",
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
                              )
                          ),
                          contentPadding: EdgeInsets.only(top: 10,left:15 ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                        },
                      ),

                      //---------------------Blood donation address----
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: blood_donation_address,
                        decoration: InputDecoration(
                          labelText: "Blood donation address",
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
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                        },
                      ),

                      //----------------Date of blood donation
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(date,style: TextStyle(fontSize: 18),),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //---------------------------Time---------
                      SizedBox(height: 20,),

                  TextFormField(
                    controller: timeinput, //editing controller of this TextField
                    decoration: InputDecoration(
                      labelText: "Time of blood donation",
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                    },
                    readOnly: true,  //set it true, so that user will not able to edit text

                     onTap: () async {
                      TimeOfDay? pickedTime =  await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if(pickedTime != null ){
                        print(pickedTime.format(context));   //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime = DateFormat('hh:mm a').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          timeinput.text = formattedTime; //set the value of text field.
                        });
                      }else{
                        print("Time is not selected");
                      }
                    },

                  ),




                      //---------------------Patient relative number----
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: patient_relative_number,
                        decoration: InputDecoration(
                          labelText: "Patient relative number",
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
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                        },
                      ),

                      //------------------------------Hemoglobin------------------
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: hemoglobin,
                        decoration: InputDecoration(
                          labelText: "Hemoglobin",
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
                      ),

                      //--------------------Reference------------------
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: reference,
                        decoration: InputDecoration(
                          labelText: "Reference",
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
                      ),

                      //--------------------Other------------------
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: other,
                        decoration: InputDecoration(
                          labelText: "Others......",
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
                      ),


                     //--------------------Cancel  post button----------

                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                       TextButton(
                           onPressed: (){
                             Navigator.pop(context);
                           },
                           child:  Text("CANCEL"),
                       ),

                         //--------------------- post button--------
                         TextButton(
                           onPressed: () async{
                             if(_formkey.currentState!.validate()){


                               var response = await Request_CRUD.request_blood(
                                 blood_group: BloodChoice,
                                 patient_problem: patient_problem.text,
                                 ammount_blood: amount_of_blood.text,
                                 address_blood_donation: blood_donation_address.text,
                                 blood_donation_date: date,
                                 blood_donation_time: timeinput.text,
                                 number: patient_relative_number.text,
                                 hemoglobin: hemoglobin.text,
                                 reference: reference.text,
                                 other: other.text,
                                 post_name: name ?? ""
                               );
                               if (response.code == 200) {
                                 EasyLoading.showSuccess("Success fully added database");
                                /* showDialog(
                                     context: context,
                                     builder: (context) {
                                       return AlertDialog(
                                         content: Text(response.message.toString()),
                                       );
                                     });*/
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Blood_Post()));
                               } else {
                                 EasyLoading.showError("Failed");
                                /* showDialog(
                                     context: context,
                                     builder: (context) {
                                       return AlertDialog(
                                         content: Text(response.message.toString()),
                                       );
                                     });*/
                               }
                             }
                           },
                           child:  Text("POST"),
                         ),
                       ],
                     ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
