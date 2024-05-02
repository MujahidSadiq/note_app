import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {

  TextEditingController noteController=TextEditingController();
  User? userId=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text("Create Notes",
          style: TextStyle(color: Colors.white,
          ),
          ),
      ),
      body: Container(child:
        Column(
        children: [
          Container(child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(

              controller: noteController,
              maxLines: null,
              decoration: InputDecoration(hintText: "Add Notes",
              ),
            ),
          ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            style:ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: ()async{
              var note =noteController.text.trim();
              if (note!=""){
                try{
                  await  FirebaseFirestore.instance.collection("notes").doc().set({
                      "createAt":DateTime.now(),
                      "note":note,
                      "userId":userId!.uid,
                    });
                }catch (e){
                  print ("Error $e");
                }
              }
          },
              child: Text(
                'Save',
                style: TextStyle(
                    fontSize: 20,color: Colors.white,letterSpacing: 1.5),
              ),
          ),
        ],
        ),
      ),
    );
  }
}
