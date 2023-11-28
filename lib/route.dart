import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week2/news/newsUi.dart';
import 'package:week2/pages/auth/Signup.dart';
import 'package:week2/pages/maps/mappage.dart';

class RouteGen{
  static Route<dynamic> generateRoute (RouteSettings settings){
    //final object arg = settings.arguments;

    switch(settings.name){

      case '/': //map sample
        return MaterialPageRoute(builder: (_) =>  loginpage());
      case '/newsui':
        return MaterialPageRoute(builder: (_) => NewsUi());
      case'/newsdetail':
        return MaterialPageRoute(builder: (_) => NewsUi());
      default:
        return _errorRoute(); //if routing error
    }
  }
  static Route<dynamic>_errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}