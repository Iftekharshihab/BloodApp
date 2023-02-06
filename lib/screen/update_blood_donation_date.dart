import 'package:blood_donation_project/screen/bottomNavigationbar_custom_End_Drawer.dart';
import 'package:blood_donation_project/screen/homePage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:blood_donation_project/custom/date.dart';
import 'package:blood_donation_project/model/doner_signUp_Firebase_Crud.dart';
import 'package:blood_donation_project/model/doner_signUp_model.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';

class Update_donation_date extends StatefulWidget {
  //------------Doner_SignUp class object---------------
  final Doner_SignUp ? doner_singup;

  Update_donation_date({Key? key, this.doner_singup}) : super(key: key);

  @override
  State<Update_donation_date> createState() => _Update_donation_dateState();
}

class _Update_donation_dateState extends State<Update_donation_date> {

  String  donateDate="Last donate data";
  final bloodDonateControler = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    bloodDonateControler.value = TextEditingValue(text: widget.doner_singup!.times_blood_donet.toString());
    donateDate =  widget.doner_singup!.last_donet_time.toString();
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
      body:  ListView(
        padding: EdgeInsets.only(left: 30,right: 30,top: 20),
        children: [
          Form(
            key: _formkey,
              child: Column(
                children: [
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
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: bloodDonateControler,
                    decoration: InputDecoration(
                      labelText: "How much donate",
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
                ],
              ),
          ),
          SizedBox(height: 40,),
          InkWell(
            onTap: () async{
                if(_formkey.currentState!.validate()){

                 var response = await Doner_Firebase_Crud.Last_Donate_Date_Update(
                    times_blood_donet: bloodDonateControler.text,
                    last_donet_time: donateDate,

                  );if (response.code == 200) {
                   EasyLoading.showSuccess("Date Update");
                  /*  showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(response.message.toString()),
                          );
                        });*/
                  } else {
                    EasyLoading.showError("Update Field");
                    /*showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(response.message.toString()),
                          );
                        });*/
                  }

                  bloodDonateControler.clear();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Appbar_BottomNav()), (route) => false);
                }

            },child: Padding(
            padding: const EdgeInsets.only(left: 30,right:30),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorsResource.RED_DEEP,
              ),
              child: Text("Update",style: TextStyle(fontSize: 20,color: Colors.white),),
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
    );
  }
}
