
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/forgetPassword.dart';
import 'package:note_app/views/signUpScreen.dart';

import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController loginEmailController=TextEditingController();
  TextEditingController loginPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
        "Login Screen",
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
                  controller: loginEmailController,
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
                  controller: loginPasswordController,
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

                var loginEmail=loginEmailController.text.trim();
                var loginPassword=loginPasswordController.text.trim();

                try{
                  final User? firebaseUser=(await FirebaseAuth.instance.
                  signInWithEmailAndPassword(email: loginEmail,
                      password: loginPassword)).user;
                  if (firebaseUser!=null){
                    Get.to(()=>HomeScreen());
                  }else {
                    print ('check Email and password');
                  }
                }on FirebaseAuthException catch(e){
                  print("Error $e");
                }
              },
                child: Text("Login",style:TextStyle(
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
                  Get.to(()=>ForgetPasswordScreen());
                },
                child: Container(child: Card(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Forgot Password"),
                )),),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: (){
                 Get.to(()=>SignUpScreen());
                },
                child: Container(child: Card(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Don't have an Account Sign UP"),
                )),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

