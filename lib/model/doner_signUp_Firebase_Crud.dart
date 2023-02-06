
import 'package:blood_donation_project/model/doner_signUp_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection("Doner Sing_Up");

class Doner_Firebase_Crud {

  static Future<Response> signUpDoner({
     String? name,
     String? phone,
     String? email,
     String? date_of_Birth,
     String? gender,
     String? blood_group,
     String? times_blood_donet,
     String? last_donet_time,
     String? divisiton,
     String? distric,
     String? upazila,
     String? union,
    String? img_url,
   // String? doc_Id,
    String? position,

  }) async {
    Response response = Response();

    String? userEmail = FirebaseAuth.instance.currentUser!.email;

    DocumentReference documentReferencer =
    _collection.doc(userEmail);



    Map<String, dynamic> setdata = <String, dynamic>{
      'downer_name': name,
      'phone': phone,
      'email': email,
      'date of birth': date_of_Birth,
      'gender':gender,
      'blood group': blood_group,
      'times blood donate': times_blood_donet,
      'last donate time': last_donet_time,
      'division': divisiton,
      'district': distric,
      'upazilla': upazila,
      'union': union,
      'images_url': img_url,
      //'documnet_id':doc_Id,
      'position': position,

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



  static Stream<QuerySnapshot> readsignUpDoner() {
    CollectionReference readData = _collection;
    return readData.snapshots();
  }


  //-------------Update  Donate date ---------------------------

  static Future<Response> Last_Donate_Date_Update({

    String? times_blood_donet,
    String? last_donet_time,
  }) async {
    Response response = Response();

    String? userEmail = FirebaseAuth.instance.currentUser!.email;

    DocumentReference documentReferencer =
    _collection.doc(userEmail);

    Map<String, dynamic> data = <String, dynamic>{
      'times blood donate': times_blood_donet,
      'last donate time': last_donet_time,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated ";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  //-------------Update  profile ---------------------------

  static Future<Response> Update_Profile({

    String? name,
    String? phone,
    String? email,
   // String? date_of_Birth,
    //String? gender,
    String? blood_group,
    String? times_blood_donet,
    String? last_donet_time,
    /*String? divisiton,
    String? distric,
    String? upazila,
    String? union,
    String? img_url,
    String? doc_Id,
    String? position,*/
  }) async {
    Response response = Response();

    String? userEmail = FirebaseAuth.instance.currentUser!.email;

    DocumentReference documentReferencer =
    _collection.doc(userEmail);

    Map<String, dynamic> data = <String, dynamic>{
      'downer_name': name,
      'phone': phone,
      'email': email,
      //'date of birth': date_of_Birth,
     // 'gender':gender,
      'blood group': blood_group,
      'times blood donate': times_blood_donet,
      'last donate time': last_donet_time,
      /*'division': divisiton,
      'district': distric,
      'upazilla': upazila,
      'union': union,
      'images_url': img_url,
      'documnet_id':doc_Id,
      'position': position,*/
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated ";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }


/*

  //------------------------read Single doner----------

  static Future<DocumentSnapshot> singleDoner_read({required String? id,})async {
    CollectionReference notesItemCollection = _collection;
    DocumentReference documentReferencer = _collection.doc(id);
    DocumentSnapshot documentSnapshot=await documentReferencer.get();
    return documentSnapshot;
  }
  static late DocumentSnapshot donnerDoc;
  static singleDonner(String? userEmail) async {
    donnerDoc = await Doner_Firebase_Crud.singleDoner_read(id: userEmail);
  }
*/

}

