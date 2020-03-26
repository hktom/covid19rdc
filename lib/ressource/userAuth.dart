import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  dynamic currentUserKey;

  Future<void> currentuserkey(key) async {
    dynamic me = await auth.currentUser();
    currentUserKey =  key=="email"? me.email:me.uid;
  }

     Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logOut() async {
    await auth.signOut();
  }

  Future<void> logEmailPassword({email, password}) async {
    await auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  Future<void> createEmailPassword({email, password})async{
    await auth.createUserWithEmailAndPassword(
          email: email.trim(), 
          password: password.trim());

  }

  Future<bool> checkLog() async {
    return await auth.currentUser() == null? false: true;
  }
}