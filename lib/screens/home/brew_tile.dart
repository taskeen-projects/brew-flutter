import 'package:brew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew/models/brew.dart';
import 'package:brew/screens/home/brew_list.dart';


class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(top:8.0),
      child:Card(
        margin:EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
        child: ListTile(
          leading:CircleAvatar(
            radius:25.0,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffee.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugar} sugar(s)'),
        ),
      ))
    ;
    
  }}