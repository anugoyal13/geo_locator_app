import 'package:flutter/material.dart';
import 'package:geo_locator_app/Homepage.dart';
 class firstpage extends StatefulWidget {


   @override
   _firstpageState createState() => _firstpageState();
 }

 class _firstpageState extends State<firstpage> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("welcome"),
       ),
       body: Center(child: MaterialButton(
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (_)=>Homepage()));

        },
         child: Text("Check current Location"),
       )),

     );
   }
 }