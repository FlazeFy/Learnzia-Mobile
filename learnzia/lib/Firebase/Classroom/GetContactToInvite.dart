import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/main.dart';

class GetContactToInvite extends StatefulWidget {
  @override
  GetContactToInvite({Key key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override
    _GetContactToInviteState createState() => _GetContactToInviteState();
}

class _GetContactToInviteState extends State<GetContactToInvite> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _contact = FirebaseFirestore.instance.collection('contact').where('type', isNotEqualTo: 'classroom').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _contact,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if((data['id_user_1'] != passIdUser)&&(data['id_user_2'] == passIdUser)){
              return CheckMember(passIdFriend : data['id_user_1'], passIdClass: widget.passIdClass);
            } else if((data['id_user_2'] != passIdUser)&&(data['id_user_1'] == passIdUser)){
              return CheckMember(passIdFriend : data['id_user_2'], passIdClass: widget.passIdClass);
            }
            return SizedBox();
          }).toList(),
        );
      },
    );
  }
}

class CheckMember extends StatefulWidget {
  @override
  CheckMember({Key key, this.passIdFriend, this.passIdClass}) : super(key: key);
  final String passIdFriend;
  final String passIdClass;

  @override
    _CheckMemberState createState() => _CheckMemberState();
}

class _CheckMemberState extends State<CheckMember> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _contact = FirebaseFirestore.instance.collection('classroom-relation').where('id_user', isNotEqualTo: passIdUser).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _contact,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        int i = 0;
        int count = 0;
        int max =  snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if((data['id_user'] == widget.passIdFriend)&&(data['id_classroom'] == widget.passIdClass)&&(i <= max)){
              i++;
              count++;
            } else {
              i++;
            }
        
            if(i == max){
              print(count.toString());
              if(count != 0){
                return InkWell(
                  child: Card(
                    color: containerColor,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                      child: Row(
                        children: [ 
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/images/User.jpg', width: 50),
                            ),
                          ),
                          Expanded(                 
                            child: Column (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetUsername(passDocumentId: data['id_user'], textColor: const Color(0xFFF1c40f)),
                                Text("This will show same classroom with you", style: TextStyle(color: Colors.white)) //Not finished
                              ]
                            )
                          ),
                          Spacer(),
                        ]
                      )    
                    )
                  ),
                  onTap: () { 
                    // 
                  },                   
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
            
          }).toList(),
        );
      },
    );
  }
}