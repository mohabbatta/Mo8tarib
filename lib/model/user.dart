import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  int uid=0;
  String uPassword;
  final String key;
  final String email;
  String gender=" ";
  //final String imageLink;
  Map<String,String> name;
  List<int> phone=[];

  User(this.key, this.uid, this.name, this.gender, this.uPassword, this.phone,this.email);

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
        snapshot.documentID,
        snapshot.data['id'],
        snapshot.data['name'],
        snapshot.data['gender'],
        snapshot.data['uPassword'],
        snapshot.data['phone'],
        snapshot.data['email']
    );}

  void addUser(String fname,String lname,String email,String password){



  }

}
