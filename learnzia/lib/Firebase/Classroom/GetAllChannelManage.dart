import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetAllChannelManage extends StatefulWidget {
  @override
  const GetAllChannelManage({Key key, this.passDocumentId, this.passIdClass}) : super(key: key);
  final String passDocumentId;
  final String passIdClass;

  @override
    _GetAllChannelManageState createState() => _GetAllChannelManageState();
}

class _GetAllChannelManageState extends State<GetAllChannelManage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('channel').orderBy('datetime', descending: false).snapshots();
  String channelName;
  String channelDesc;

  CollectionReference channel= FirebaseFirestore.instance.collection('channel');
  final edit_channelnameCtrl = TextEditingController();
  final edit_channeldescCtrl = TextEditingController();
  final validation = TextEditingController();

  Future<void> editChannel(String id) {
    return channel
      .doc(id)
      .update({
        'channel_name': channelName, 
        'channel_description': channelDesc,
      })
      .then((value) => print("Successfully edit channel"))
      .catchError((error) => print("Failed to update channel: $error"));
  }

  Future<void> deleteChannel(String id) {
    return channel
      .doc(id)
      .delete()
      .then((value) => print("Successfully delete channel"))
      .catchError((error) => print("Failed to delete channel: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_classroom'] == widget.passDocumentId){
              return Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('#${data['channel_name']}', style: TextStyle(color: mainColor, fontSize: 16)),
                        Text(data['channel_description'], style: const TextStyle(color: Colors.white, fontSize: 14)),
                      ],  
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child:IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Edit Channel'),
                            actions: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Channel Name", style: TextStyle(color: mainColor)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: TextField(
                                  controller: edit_channelnameCtrl,
                                  decoration: InputDecoration(
                                    hintText: "#${data['channel_name']}",
                                    border: const OutlineInputBorder(),
                                    fillColor: const Color(0xFF5A5d5e),
                                    hintStyle: const TextStyle(color: Colors.white),
                                    filled: true,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Channel Description", style: TextStyle(color: mainColor)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: TextField(
                                  controller: edit_channeldescCtrl,
                                  decoration: InputDecoration(
                                    hintText: data['channel_description'],
                                    border: const OutlineInputBorder(),
                                    fillColor: const Color(0xFF5A5d5e),
                                    hintStyle: const TextStyle(color: Colors.white),
                                    filled: true,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    if(edit_channelnameCtrl.text.isEmpty){
                                      channelName = data['channel_name'];
                                    } else {
                                      channelName = edit_channelnameCtrl.text;
                                    }
                                    if(edit_channeldescCtrl.text.isEmpty){
                                      channelDesc = data['channel_description'];
                                    } else {
                                      channelDesc = edit_channeldescCtrl.text;
                                    }
                                    editChannel(document.id);
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Success', style: TextStyle(fontWeight: FontWeight.bold)),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                ClipRRect(
                                                  child: Image.asset(
                                                    'assets/icons/Channel.png', width: 20),
                                                ),
                                                Text('Successfully update ${{channelName}} channel'),
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
                                  label: const Text("Update"),
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: mainColor,
                      ) 
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child:IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.white,
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning'),
                            actions: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Are you sure want to delete ${data['channel_name']} channel", style: const TextStyle(color: Colors.black)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: TextField(
                                  controller: validation,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    fillColor: Color(0xFF5A5d5e),
                                    hintStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Please type the same channel name for validationl", style: TextStyle(color: mainColor, fontSize: 12)),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(validation.text == data['channel_name']){
                                      deleteChannel(document.id);
                                      return showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Success', style: TextStyle(fontWeight: FontWeight.bold)),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  ClipRRect(
                                                    child: Image.asset(
                                                      'assets/icons/Channel.png', width: 20),
                                                  ),
                                                  Text('Successfully delete ${validation.text} channel'),
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
                                    } else {
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
                                                  const Text('Delete failed. Please input same channel name!'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Try again'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red, // Background color
                                  ),
                                  child: const Text("Yes, delete this"),
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.red,
                      ) 
                    ),
                  
                  ],
                )
              );
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}