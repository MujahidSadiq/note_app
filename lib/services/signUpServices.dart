

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_app/views/loginScreen.dart';

SignUpUser(String userName, String userPhone,
           String userEmail, String userPassword
    )

async{
  User? userId=FirebaseAuth.instance.currentUser;

try{
  await FirebaseFirestore.instance.collection("users").doc(userId!.uid).set({
    "userName":userName,
    "userPhone":userPhone,
    "userEmail":userEmail,
    "userId":userId.uid,
    "createdAt":DateTime.now(),
  }).then((value) => {
    FirebaseAuth.instance.signOut(),
    Get.to(()=>LoginScreen()),
  });

}on FirebaseAuthException catch(e){
  print("Error $e");
}
}
