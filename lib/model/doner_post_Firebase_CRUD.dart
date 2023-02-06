import 'package:blood_donation_project/custom/date.dart';
import 'package:blood_donation_project/model/doner_signUp_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection("Blood request post");


class Request_CRUD{

  //-----------------------------------------------Create-----------------
  static Future<Response> request_blood({
    String? post_name,
    String? blood_group,
    String? patient_problem,
    String? ammount_blood,
    String? address_blood_donation,
    String? blood_donation_date,
    String? blood_donation_time,
    String? number,
    String? hemoglobin,
    String? reference,
    String? other,

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
      "blood group": blood_group,
      "problem":patient_problem,
      "blood amount": ammount_blood,
      "address" : address_blood_donation,
      "date_donate": blood_donation_date,
      'time_donate': blood_donation_time,
      "number": number,
      "hemoglobin": hemoglobin,
      "reference": reference,
      "other": other,

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

  static Stream<QuerySnapshot> read_blood_post() {
    CollectionReference readData = _collection;
    return readData.snapshots();
  }


}
