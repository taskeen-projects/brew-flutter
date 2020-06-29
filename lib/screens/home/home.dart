import 'package:brew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew/screens/home/brew_list.dart';
import 'package:brew/models/brew.dart';
import 'package:brew/screens/home/settings.dart';
import 'dart:async';


class Home extends StatelessWidget {
  final AuthService _auth= AuthService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder:(context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 60.0),
          child: SettingForm()     
        );
        });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Coffee'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person),
                label:Text('LogOut'),
                onPressed: ()async{
                  await _auth.signOut();
                },),
                FlatButton.icon(
                  icon:Icon(Icons.settings),
                   label: Text('settings'),
                  onPressed:()=> _showSettingsPanel(),
                  )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage('assets/cup.png'),
            fit: BoxFit.cover),
          ),
          child:BrewList(),
        )
      )
    );
    
  }
}