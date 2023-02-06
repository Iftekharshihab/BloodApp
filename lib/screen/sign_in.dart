import 'package:blood_donation_project/model/authentication.dart';
import 'package:blood_donation_project/screen/bottomNavigationbar_custom_End_Drawer.dart';
import 'package:blood_donation_project/screen/homePage.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_donation_project/screen/sigin_Up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {

  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _isvisivility = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 60,
        backgroundColor: ColorsResource.RED,
        leading: Image.asset("assets/icons/bloodLogo.png"),
        title: Text(
          "Sing in",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: ListView(
        padding: EdgeInsets.only(top: 30,left: 30,right: 30),
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 150,),
                //---------------------Email------------------
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  autofocus: false,
                  cursorColor: Colors.black,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z0-9!@.]')),
                  ],
                  decoration: InputDecoration(
                    hintText: "Eamil",
                    hintStyle: TextStyle(fontSize: 18),
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.grey,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 15,top: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter your email';
                    }
                    else if(!value.contains('@') || !value.contains('.')){
                      return 'Invalid Email';
                    }
                    email = value;
                  },
                ),
                SizedBox(height: 30,),
                //------------------password--------------
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passController,
                  obscureText: _isvisivility ? false : true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(fontSize: 18),
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
                    suffixIcon:IconButton(
                      onPressed: (){
                        setState(() {
                          _isvisivility =! _isvisivility;
                        });
                      },
                      icon:  _isvisivility ? Icon(Icons.visibility,size: 22,color: Colors.grey,) : Icon(Icons.visibility_off,size: 22,color: Colors.grey,),
                    ),
                    contentPadding: EdgeInsets.only(left: 15,top: 10),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter password';
                    }else if(value.length < 8){
                      return 'At lest 8 chracter ';
                    }
                    password = value;
                  },
                ),

                SizedBox(height: 30,),

                InkWell(
                  onTap: ()async{
                    if(_formkey.currentState!.validate()) {
                      AuthenticationService authenticationService =
                      AuthenticationService(FirebaseAuth.instance);
                      authenticationService.SignIn(
                        email: _emailController.text.toString(),
                        password: _passController.text.toString(),
                      ).then((value) {
                        if (value == "Sing In") {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          String? userId = auth.currentUser!.uid;
                          EasyLoading.showSuccess("$value");
                          /* showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(value),
                                  );
                                });*/
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Appbar_BottomNav()));

                        }

                        else {
                          EasyLoading.showError("$value");
                          /*showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("$value"),
                                  );
                                }
                            );*/
                        }

                      });
                    }
                  },child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Text("Sign In",style: TextStyle(fontSize: 20,color: Colors.white),),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:ColorsResource.COLOR_PRIMARY,
                  ),
                ),
                ),


                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Don't have an account?",style: TextStyle(fontSize: 18,color: Colors.grey),),
                    TextButton(
                      onPressed: (){

                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Sign_UP()));
                      },
                      child: Text("Sign up.",style: TextStyle(fontSize: 18),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
