
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/loginScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  TextEditingController forgetPasswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 300,
                child: Lottie.asset("assets/animation.json"),
              ),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: forgetPasswordController,
                  decoration: InputDecoration(hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder()
                  ),
                ),

              ),
              SizedBox(
                height: 10.0,
              ),

              ElevatedButton(
                onPressed: ()async{
               var recoverEmail=forgetPasswordController.text.trim();
               try{
               await  FirebaseAuth.instance.sendPasswordResetEmail(
                     email: recoverEmail).then((value) => {
                       print("Email sent"),
                   Get.off(()=>LoginScreen())
                 });
               }on FirebaseAuthException catch(e){
                 print ("Error $e");
               }
              },
                child: Text("Forgot Password",
                style:TextStyle(
                    color: Colors.white,letterSpacing: 2,fontSize:18
                ),),
                style: ElevatedButton.styleFrom(minimumSize: Size(300, 45),
                    backgroundColor: Color(0xFF2196F3)
                ),

              ),


            ],
          ),
        ),
      ),
    );
  }
}

