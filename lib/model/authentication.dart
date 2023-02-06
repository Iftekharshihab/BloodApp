
import 'package:firebase_auth/firebase_auth.dart';
class AuthenticationService{

  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStageChange =>_firebaseAuth.authStateChanges();

  //-----------------Sign Up function-------------

  Future<String?> SignUp ({required String email, required String password}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword( email: email, password: password);
      return 'Sign Up';
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  //---------------------Sign In function----------
  Future<String?> SignIn ({required String email, required String password})async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'Sing In';
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  //-------------------------Sign out function-------------
  Future <String?> SignOut() async{
    try{
      await _firebaseAuth.signOut();
      return "Sign Out";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  //-----------------------------------get user----------
  User? getUser(){
    try{
      return _firebaseAuth.currentUser;
    }on FirebaseAuthException{
      return null;
    }
  }
}