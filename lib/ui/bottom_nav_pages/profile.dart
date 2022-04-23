import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? _namecontroller;
  TextEditingController? _phonecontroller;
  TextEditingController? _agecontroller;

  setDataToTextField(data){
    return Column(
    children: [
    TextFormField(controller: _namecontroller=TextEditingController(text: data['name'])),
    TextFormField(controller: _phonecontroller=TextEditingController(text: data['phone'])),
    TextFormField(controller: _agecontroller=TextEditingController(text: data['age'])),
    ElevatedButton(onPressed: ()=>updateData(), child: Text("Update"))
    ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
      {
        "name":_namecontroller!.text,
        "phone":_phonecontroller!.text,
        "age":_agecontroller!.text,
      }
    ).then((value) => print("Updated Successfully"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }
            return setDataToTextField(data);
          },
        ),
      ),),
    );
  }
}
