import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:note_app/views/homeScreen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController noteController=TextEditingController();
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(

        "Edit Note",
          style: TextStyle(color: Colors.white),
      ),
      ),
      body: Container(
        child: Column(
          children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: noteController..text=Get.arguments["note"].toString(), 
            ),
          ),
          ElevatedButton(
            style:ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00BCD4)
            ),
            onPressed: ()async{
              await FirebaseFirestore.instance.collection("notes").doc(
                  Get.arguments["docId"].toString()).update(
                  {
                   "note":noteController.text.trim(),
                  }
              ).then((value) => Get.offAll(HomeScreen()),);
            },
            child: Text("Edit",style: TextStyle(color: Colors.white),),
        )
      ],
      ),
      ),
    );
  }
}
