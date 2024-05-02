

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:note_app/views/createNoteScreen.dart';

import 'package:note_app/views/editNoteScreen.dart';
import 'package:note_app/views/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         backgroundColor: Colors.blue,
         title: Text("Home Screen",
           style:TextStyle(color: Colors.white) ,),
         actions: [
         GestureDetector(
           onTap: (){
            FirebaseAuth.instance.signOut();
            Get.off(()=>LoginScreen());
          },
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Icon(Icons.logout),
             ),
         ),
         ],
       ),
      body:Container(
        child: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("notes")
              .where("userId",isEqualTo:userId?.uid).snapshots() ,
           builder: (Context, AsyncSnapshot<QuerySnapshot>snapshot){
            
             if(snapshot.hasError){
               return Text("something went wrong ");
             }
             if (snapshot.connectionState==ConnectionState.waiting){
               return Center(child: CupertinoActivityIndicator());
             }
             if (snapshot.data!.docs.isEmpty){
               return Center(
                   child: Text("No Data Found "),
               );
             }if (snapshot!=null && snapshot.data!=null){
               return ListView.builder(
                 itemCount: snapshot.data!.docs.length,
                   itemBuilder:(context,index){

                   var note=Text(snapshot.data!.docs[index]["note"]);
                   var noteid=Text(snapshot.data!.docs[index]["userId"]);
                   var docId=snapshot.data!.docs[index].id;

                   return Card(child: ListTile(
                     title:note ,
                     subtitle: noteid,
                     trailing: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         GestureDetector(
                          onTap: (){
                            Get.to(()=>EditNoteScreen(),arguments: {
                              "note":note,
                              "docId":docId,
                            }

                            );
                          },
                           child: Icon(Icons.edit),
                         ),
                         SizedBox(width: 10.0,),
                         GestureDetector(
                           onTap: ()async{
                           await FirebaseFirestore.instance.collection("notes").doc(docId).delete();
                           },
                             child: Icon(Icons.delete)),
                     ],),
                   ),
                   );
                   }
               );
             }
             return Container();
           },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FloatingActionButton.extended(

          backgroundColor: Colors.blueAccent,
          onPressed: (){
            Get.to(()=>CreateNoteScreen());
          },
          label: Text("Add",
            style: TextStyle(color: Colors.white,fontSize: 20.0),),
        ),
      ),
    );
  }
}
