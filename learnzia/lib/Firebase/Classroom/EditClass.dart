import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Widgets/dropdown.dart';
import 'package:learnzia/main.dart';

String typeClassCtrl;
String categoryClassCtrl;

class EditClass extends StatefulWidget {
  const EditClass({Key key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override
  _EditClassState createState() => _EditClassState();
}

class _EditClassState extends State<EditClass> {
  final Stream<QuerySnapshot> _classStream = FirebaseFirestore.instance.collection('classroom').snapshots();

  final classroomNameCtrl = TextEditingController();
  final classroomDescCtrl = TextEditingController();

  var classCategory ="";
  var classType ="";
  var className ="";
  var classDesc ="";
  
  CollectionReference classroom = FirebaseFirestore.instance.collection('classroom');

  Future<void> updateClass(String id) {
    return classroom
      .doc(id)
      .update({
        'classname': className, 
        'description': classDesc,
        'type': classType.toLowerCase(), 
        'category': classCategory.toLowerCase(), 
      })
      .then((value) => print("Profile has been updated"))
      .catchError((error) => print("Failed to update classroom: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _classStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Container(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children:const [
                        Text("Category :", style: TextStyle(color: Colors.white, fontSize: 16)),
                        Spacer(),
                        DropDownCategory2()
                      ]
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children:const [
                        Text("Type :", style: TextStyle(color: Colors.white, fontSize: 16)),
                        Spacer(),
                        DropDownType()
                      ]
                    )
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Class Name", style: TextStyle(color: mainColor)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 5, right: 40),
                    child: TextField(
                      controller: classroomNameCtrl,
                      decoration: InputDecoration(
                        hintText: data['classname'],
                        border: const OutlineInputBorder(),
                        fillColor: const Color(0xFF5A5d5e),
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Class Description", style: TextStyle(color: mainColor)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 5, right: 40),
                    child: TextField(
                      controller: classroomDescCtrl,
                      decoration: InputDecoration(
                        hintText: data['description'],
                        border: const OutlineInputBorder(),
                        fillColor: const Color(0xFF5A5d5e),
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            //Class category and type need to be fixed
                            if(classroomNameCtrl.text.isEmpty){
                              className = data['classname'];
                            } else {
                              className = classroomNameCtrl.text;
                            }
                            if(classroomDescCtrl.text.isEmpty){
                              classDesc = data['description'];
                            } else {
                              classDesc = classroomDescCtrl.text;
                            }
                            if(categoryClassCtrl.isEmpty){
                              classCategory = data['category'];
                            } else {
                              classCategory = categoryClassCtrl;
                            }
                            if(typeClassCtrl.isEmpty){
                              classType = data['type'];
                            } else {
                              classType = typeClassCtrl;
                            }
                            updateClass(widget.passIdClass);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NavBar()),
                            );
                        
                            return showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        ClipRRect(
                                          child: Image.asset(
                                            'assets/icons/Wrong.png', width: 20),
                                        ),
                                        const Text('Classroom profile updated'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                          );
                            
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Background color
                          ),
                          icon: const Icon(Icons.save, size: 18),
                          label: const Text("Save Changes"),
                        )
                      )
                    ],
                  ),
    
                ],
              )  
              
            );
          }).toList(),
        );
      },
    );
  }
}