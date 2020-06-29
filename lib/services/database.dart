import 'dart:collection';
import 'package:brew/models/brew.dart';
import 'package:brew/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection= Firestore.instance.collection('brews');
  Future <void> updateUserData(String sugar, String name, int strength) async{
    return await brewCollection.document(uid).setData(
      {
        'sugar': sugar,
    'name': name,
    'strength': strength,
      }
    );
 }
 List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
   return snapshot.documents.map((doc){
     return Brew(
       name:doc.data['name'] ??'',
       strength:doc.data['strength']?? 0,
       sugar:doc.data['sugar']??'0',

     );
 }).toList();
 }
 UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
   return UserData(
     uid:uid, 
     name:snapshot.data['name'],
     sugar:snapshot.data['sugars'],
     strength: snapshot.data['strength']
   );
 }
 Stream<List<Brew>>get brews{
    return brewCollection.snapshots()
    .map( _brewListFromSnapshot);
}
Stream<UserData> get userData{
  return brewCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}
}