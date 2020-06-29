import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
class Loading extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.brown[100],
      child:Center(
        child:SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        )
      )
    );
  }}