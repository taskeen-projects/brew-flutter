import 'package:flutter/material.dart';
import 'package:brew/screens/home/brew_tile.dart';
import 'package:brew/models/brew.dart';
import 'package:brew/services/database.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget{
  @override
  _BrewListState createState()=>_BrewListState();
  }
  
class _BrewListState extends State <BrewList> {
    
  @override
  Widget build(BuildContext context) {
    final brews= Provider.of<List<Brew>>(context) ?? [];
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder:(context, index){
        return BrewTile(brew:brews[index]);
      });
    
    
  }
  }