
import 'package:brew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:brew/services/auth.dart';
import 'package:brew/shared/loading.dart';
import 'package:async/async.dart';
class SignIn extends StatefulWidget{
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();

}
class _SignInState extends State<SignIn>{
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  String error='';
  String email='';
  String password='';
   bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
             label: Text('Register'),
             onPressed: ()=>widget.toggleView(),
             ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:50.0),
        child:Form(
           key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Email'),
                validator: (val) =>val.isEmpty? 'Enter correct Email':null,
                onChanged:(val){
                  setState(() => email= val);
                },
                
          ),
              SizedBox(height: 20.0),
              
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) =>val.length<6 ? 'Enter correct password':null,
                obscureText: true,
                onChanged:(val){
                  setState(() => password= val);
                }
                
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text('Sign in'),
                onPressed:() async{
                  if(_formKey.currentState.validate()){
                    setState(()=> loading= true);
                    dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error= 'Could not sign in with those credentials';
                        loading= false;
                      });
                    }
                  }
                  
                }
              ),
              SizedBox( height: 12.0),
              Text(
                error,
                style: TextStyle(color:Colors.red,
                fontSize: 14.0),
              )
            ],
          )
        )
         
      )
    );
      }
}
    