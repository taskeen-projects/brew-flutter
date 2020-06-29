import 'package:brew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:brew/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:brew/models/users.dart';

class Wrapper extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User>(context);
    print(user);
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
    
  }
}