import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetMiniProfile extends StatelessWidget {
  final String documentId;

  const GetMiniProfile(this.documentId);

  @override
  Widget build(BuildContext context) {
    final _fullnameCtrl = TextEditingController();
    final _descCtrl = TextEditingController();
    final _passwordCtrl = TextEditingController();

    var fullname = "";
    var desc = "";
    var password = "";

    CollectionReference users = FirebaseFirestore.instance.collection('user');

     Future<void> updateProfile() {
      return users
        .doc(documentId)
        .update({'fullname': fullname, 'description': desc, 'password': password})
        .then((value) => print("Profile has been updated"))
        .catchError((error) => print("Failed to update user: $error"));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            double fullWidth = MediaQuery.of(context).size.width;

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: fullWidth*0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset(
                        'assets/images/User.jpg'),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin:const EdgeInsets.only(bottom: 15), 
                            child: Text(data['username'], style: const TextStyle(color: Color(0xFF212121), fontSize: 22, fontWeight: FontWeight.bold))
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: fullWidth*0.5,
                            child: Text(data['fullname'], maxLines: 1, overflow: TextOverflow.ellipsis, 
                              style: const TextStyle(color: Color(0xFF212121), fontSize: 16)
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: fullWidth*0.5,
                            child: Text(data['email'], maxLines: 1, overflow: TextOverflow.ellipsis, 
                              style: const TextStyle(color: Color(0xFF212121), fontSize: 16)
                            ),
                          ),
                          Container(
                            margin:const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerRight,
                            width: fullWidth*0.5,
                            child: Text(data['description'], maxLines: 3, overflow: TextOverflow.ellipsis, 
                              style: const TextStyle(color: Color(0xFF212121), fontSize: 14)
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: fullWidth,
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    textColor: Colors.white,
                    leading: const Icon(Icons.edit,size: 22),
                    title: const Text('Edit Profile'),
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Fullname", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: _fullnameCtrl,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: data['fullname'],
                            fillColor: const Color(0xFF5A5d5e),
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: true,
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Description", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: _descCtrl,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: data['description'],
                            fillColor: const Color(0xFF5A5d5e),
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: true,
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Password", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: _passwordCtrl,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: data['password'],
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
                                if(_fullnameCtrl.text.isEmpty){
                                  fullname = data['fullname'];
                                } else {
                                  fullname = _fullnameCtrl.text;
                                }
                                if(_descCtrl.text.isEmpty){
                                  desc = data['description'];
                                } else {
                                  desc = _descCtrl.text;
                                }
                                if(_passwordCtrl.text.isEmpty){
                                  password = data['password'];
                                } else {
                                  password = _passwordCtrl.text;
                                }
                                updateProfile();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const NavBar()),
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
                      )
                    ]
                  )
                )
              ]
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFF1C40F).withOpacity(0.9),
                  const Color.fromARGB(255, 244, 140, 13).withOpacity(0.9),
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            )
          );
        }

        return const Text("loading");
      },
    );
  }
}