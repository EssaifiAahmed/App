import 'package:flutter/material.dart';
import './screen/userInterface.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interset Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
    )
  );
}

