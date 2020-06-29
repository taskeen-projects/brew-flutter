import 'package:flutter/material.dart';
import 'package:brew/shared/constants.dart';
import 'package:brew/models/users.dart';
import 'package:provider/provider.dart';
import 'package:brew/services/database.dart';
import 'package:brew/shared/loading.dart';
import 'dart:async';
import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/src/widgets/async.dart';

class SettingForm extends StatefulWidget{
  @override
  _SettingFormState createState()=>_SettingFormState();
  }
  
class _SettingFormState extends State <SettingForm> {
    final _formKey=GlobalKey<FormState>();
    final List<String> sugars=['0','1','2','3','4'];
    final List<int> strengths=[100,200,300,400,500,600,700,800,900];
    String _currentName;
    String  _currentSugars;
    int  _currentStrength;
  @override
  Widget build(BuildContext context) {
    User user=Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
       
      builder: (context, snapshot){
        if(snapshot.hasData && snapshot.data!= null){
          UserData userData=snapshot.data;
        
        return Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
            Text('Update your brew setting',
            style: TextStyle(fontSize: 18.0),),
            SizedBox(height:10.0),
            TextFormField(
              initialValue:userData.name,
              decoration:textInputDecoration,
              validator: (val)=> val.isEmpty? 'Please enter name':null,
              onChanged: (val)=> setState(()=> _currentName=val),
            ),
            SizedBox(height:10.0),
            DropdownButtonFormField(
              value: _currentSugars ?? userData.sugar,
              decoration: textInputDecoration,
              items: sugars.map((sugar){
                return DropdownMenuItem(
                  value:sugar,
                  child:Text('$sugar,sugars'));
                }).toList(),
              onChanged: (val) =>setState(() => _currentSugars=val),),
              // slider
              SizedBox(height:10.0),
              Slider(
                value: (_currentStrength ?? userData.strength).toDouble(),
                activeColor: Colors.brown[_currentStrength ?? userData.strength],
                inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                min: 100.0,
                max:900.0,
                divisions: 8,
                onChanged: (val)=>setState(()=>_currentStrength=val.round()),

              ),
              SizedBox(height:10.0),
              RaisedButton(
              color: Colors.pink[400],
              child: Text('update',
              style: TextStyle(color:Colors.white),),
              onPressed:()async{
                if(_formKey.currentState.validate()){
                  await DatabaseService (uid: user.uid).updateUserData(
                  _currentName ?? snapshot.data.name ,
                  _currentSugars ?? snapshot.data.sugar ,
                  _currentStrength ?? snapshot.data.strength 
                  );
                  Navigator.pop(context);
                }
              }
            ),
          ],
          )
      );
        } else{
          
          return Loading();
        }}
    );
}}
