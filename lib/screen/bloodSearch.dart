import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_donation_project/screen/profile.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';

class BloodSearch extends StatefulWidget {
  const BloodSearch({Key? key}) : super(key: key);

  @override
  State<BloodSearch> createState() => _BloodSearchState();
}

class _BloodSearchState extends State<BloodSearch> {

  String bloodChoice ="";

  //----------------Distric List-----------------
  String? DivisionChoose;
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
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              children: [

                //--------------------Boxes section------------
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        bloodChoice = "AB+";
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: bloodChoice == "AB+" ? ColorsResource.COLOR_PRIMARY :Colors.white,
                        border: Border.all(width: 1,color: ColorsResource.COLOR_PRIMARY)
                        ),
                        child: Text("AB+",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: bloodChoice == "AB+" ? Colors.white : ColorsResource.RED_DEEP_ONE),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        bloodChoice = "AB-";
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: bloodChoice == "AB-" ? ColorsResource.COLOR_PRIMARY :Colors.white,
                            border: Border.all(width: 1,color: ColorsResource.COLOR_PRIMARY)
                        ),
                        child: Text("AB-",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: bloodChoice == "AB-" ? Colors.white : ColorsResource.RED_DEEP_ONE),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        bloodChoice = "O+";
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: bloodChoice == "O+" ? ColorsResource.COLOR_PRIMARY :Colors.white,
                            border: Border.all(width: 1,color: ColorsResource.COLOR_PRIMARY)
                        ),
                        child: Text("O+",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: bloodChoice == "O+" ? Colors.white : ColorsResource.RED_DEEP_ONE),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        bloodChoice = "O-";
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: bloodChoice == "O-" ? ColorsResource.COLOR_PRIMARY :Colors.white,
                            border: Border.all(width: 1,color: ColorsResource.COLOR_PRIMARY)
                        ),
                        child: Text("O-",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: bloodChoice == "O-" ? Colors.white : ColorsResource.RED_DEEP_ONE),),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        bloodChoice = "B+";
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: bloodChoice == "B+" ? ColorsResource.COLOR_PRIMARY :Colors.white,
                            border: Border.all(width: 1,color: ColorsResource.COLOR_PRIMARY)
                        ),
                        child: Text("B+",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: bloodChoice == "B+" ? Colors.white : ColorsResource.RED_DEEP_ONE),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        bloodChoice = "B-";
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: bloodChoice == "B-" ? ColorsResource.COLOR_PRIMARY :Colors.white,
                            border: Border.all(width: 1,color: ColorsResource.COLOR_PRIMARY)
                        ),
                        child: Text("B-",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: bloodChoice == "B-" ? Colors.white : ColorsResource.RED_DEEP_ONE),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        bloodChoice = "A+";
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: bloodChoice == "A+" ? ColorsResource.COLOR_PRIMARY :Colors.white,
                            border: Border.all(width: 1,color: ColorsResource.COLOR_PRIMARY)
                        ),
                        child: Text("A+",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: bloodChoice == "A+" ? Colors.white : ColorsResource.RED_DEEP_ONE),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        bloodChoice = "A-";
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: bloodChoice == "A-" ? ColorsResource.COLOR_PRIMARY :Colors.white,
                            border: Border.all(width: 1,color: ColorsResource.COLOR_PRIMARY)
                        ),
                        child: Text("A-",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: bloodChoice == "A-" ? Colors.white : ColorsResource.RED_DEEP_ONE),),
                      ),
                    ),
                  ],
                ),

                //-----------------------------Dropdown------------

                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color:Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: DropdownButton(
                          hint: Text("Division", style: TextStyle(color: Colors.grey),),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.grey,),
                          iconSize: 30,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                            color: Colors.grey,
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

                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color:Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: DropdownButton(
                          hint: Text("Distric", style: TextStyle(color: Colors.grey),),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.grey,),
                          iconSize: 30,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                            color: Colors.grey,
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
                  ],
                ),

                SizedBox(height: 30,),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color:Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: DropdownButton(
                      hint: Text("Upazila", style: TextStyle(color: Colors.grey),),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.grey,),
                      iconSize: 30,
                      isExpanded: true,
                      underline: SizedBox(),
                      style: TextStyle(
                        color: Colors.grey,
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
              ],
            ),
          ),

          //--------------------------------List Donner-----------------

          Container(
            padding: EdgeInsets.only(left: 25,bottom: 15),
            alignment: Alignment.topLeft,
              child: Text("Donner List",style: TextStyle(fontSize: 30,color:ColorsResource.COLOR_PRIMARY ,fontWeight: FontWeight.bold),
              )),


          Container(
            height: 330,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Doner Sing_Up").snapshots(),
                builder: (context,snapshot){
                  return !snapshot.hasData ? Center(child: CircularProgressIndicator(),):
                      ListView.builder(itemCount: snapshot.data!.docs.length,
                        itemBuilder:(context,index){
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(isDonner: true, donerEmail: data["email"])));
                          },
                          child: Card(
                            child:Padding(
                              padding: const EdgeInsets.only(left: 20,bottom: 10,top: 10),
                              child: Row(
                                children: [
                                    Container(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(data["images_url"]),
                                      ),
                                      height: 60,
                                      width: 60,
                                    ),SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data["downer_name"],style: TextStyle(fontSize: 20),),
                                        SizedBox(height: 5,),
                                        Text("Blood group: "+data["blood group"],style: TextStyle(fontSize: 18),),
                                        SizedBox(height: 5),
                                        Text("Last donate date: "+data["last donate time"],style: TextStyle(fontSize: 18),),
                                        SizedBox(height: 5,),
                                        Text("Address: "+data["division"]+","+data["district"],style: TextStyle(fontSize: 18),),
                                      ],
                                    ),
                                  ],
                                ),
                            )
                             ),
                        );
                        });
                }
            ),
          ),

        ],
      ),
    );
  }
}
