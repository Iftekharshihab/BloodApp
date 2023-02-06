import 'package:blood_donation_project/custom/date.dart';
import 'package:blood_donation_project/model/doner_signUp_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection("Activities post");

class Activities_CRUD{

  //-----------------------------------------------Create-----------------
  static Future<Response> activities_add({
    String ? post_name,
    String ? titel,
    String ? img,

  }) async {
    Response response = Response();

    String? userEmail = FirebaseAuth.instance.currentUser!.email;

    // (user email dila akata post hobe sudu)
/*
    DocumentReference documentReferencer =
    _collection.doc(userEmail);*/

    //--------Multipost ar jonno () ae kicu dita hobe na
    DocumentReference documentReferencer =
    _collection.doc();


    Map<String, dynamic> setdata = <String, dynamic>{
      "name":post_name,
      "titel" : titel,
      "img" : img,

      "date": get_Date(),
      "time": getTime(),
    };


    var result = await documentReferencer.set(setdata).whenComplete(() {

      response.code = 200;
      response.message = 'Successfully added to the database';
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
  //-------------------------------Read------------------

  static Stream<QuerySnapshot> read_activities() {
    CollectionReference readData = _collection;
    return readData.snapshots();
  }


}