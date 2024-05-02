
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/services/signUpServices.dart';
import 'package:note_app/views/loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController userNameController=TextEditingController();
  TextEditingController userPhoneController=TextEditingController();
  TextEditingController userEmailController=TextEditingController();
  TextEditingController userPasswordController=TextEditingController();

  User? currentUser= FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "SignUp Screen",
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
                height: 250,
                child: Lottie.asset("assets/animation.json"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(hintText: "User Name",
                      prefixIcon: Icon(Icons.person),
                      enabledBorder: OutlineInputBorder()
                  ),
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPhoneController,
                  decoration: InputDecoration(hintText: "Phone",
                      prefixIcon: Icon(Icons.phone),
                      enabledBorder: OutlineInputBorder()
                  ),
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder()
                  ),
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPasswordController,
                  decoration: InputDecoration(hintText: "Password",
                      suffixIcon:Icon(Icons.visibility),
                      prefixIcon: Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder()
                  ),
                ),

              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(onPressed: ()async{

                var userName=userNameController.text.trim();
                var userPhone=userPhoneController.text.trim();
                var userEmail=userEmailController.text.trim();
                var userPassword=userPasswordController.text.trim();

               await  FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: userEmail, password: userPassword).then((value) =>{
                      log("user created"),
                      SignUpUser(userName,userPhone,userEmail,userPassword),

                    });


              },
                child: Text("Sign Up",
                style:TextStyle(
                  color: Colors.white,letterSpacing: 2,fontSize:18
              ),),
                style: ElevatedButton.styleFrom(minimumSize: Size(300, 45),
                    backgroundColor: Color(0xFF2196F3)
                ),

              ),

              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>LoginScreen());
                },
                child: Container(child: Card(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Already have an Account: Login!"),
                )),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

