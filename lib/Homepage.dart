import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'daterange_picker.dart';

//import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //String latitudeData='';
 // String longitudeData='';


  //@override
  // void initState(){
  //   super.initState();
  //   getCurrentLocation();
  // }
  String now = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());


  var locationMessage = '';
  String latitude;
  String longitude;
  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address _address;
  @override
  void initState(){
     super.initState();
      var locationOptions= LocationOptions(accuracy:LocationAccuracy.high,distanceFilter: 10);
     _streamSubscription=Geolocator.getPositionStream().listen((Position position) {
       setState(() {
         print(position);
         var lat = position.latitude;
         var long = position.longitude;
         latitude = "$lat";
         longitude = "$long";
         latitude = "$lat";
         longitude = "$long";

         setState(() {
           locationMessage = "Latitude: $lat and Longitude: $long";
           print(latitude.toString());
         });

         //String cords=position;
         final coordinates=new Coordinates(position.latitude, position.longitude);
         convertCoordinatesToAddress(coordinates).then((value)=>_address=value);
       });
     });
     }



   // void getCurrentLocation() async {
   // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   //  print(position.latitude);
   //  print(position.longitude);
   //  getAddressFromCoordinates(Coordinates(position.latitude, position.longitude));
   // }
   // getAddressFromCoordinates(Coordinates cords)async{
   //   var addresses = await Geocoder.local.findAddressesFromCoordinates(cords);
   //   var first = addresses.first;
   //   print(" ${first.addressLine}");
   // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Demo"),
      ),
      // body: Center(child: MaterialButton(
      //   onPressed: (){
      //     getCurrentLocation();
      //   },
      //   child: Text("current location"),
      //)
    //),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height:50),
              DateRangePickerWidget(),

              SizedBox(height:50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Checkin Date",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                      Text(DateFormat("dd/MM/yyyy",).format(DateTime.now()),style:TextStyle(fontSize: 15,)),
                    ],
                  ),
                  SizedBox(width: 50,),
                  Column(
                    children: [
                      Text("Checkin time",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                      Text(DateFormat("hh:mm").format(DateTime.now()),style:TextStyle(fontSize: 15,)),

                    ],
                  ),
                ],
              ),
              SizedBox(height:30),
              Text("Location",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
              //Text("Location lat:${_position?.latitude??'-'},lon:${_position?.longitude??'-'}"),
              Text(locationMessage,style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
              SizedBox(height:20),
              Text("Address from Coordinates",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
              SizedBox(height:20),
              Text("${_address?.addressLine??'-'}",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
              SizedBox(height:50),

              //Text(DateFormat("dd/MM/yyyy",).format(DateTime.now()),style:TextStyle(fontSize: 15,)),
              //SizedBox(height:50),
              //Text("Checkin time",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
              //Text(DateFormat("hh:mm").format(DateTime.now()),style:TextStyle(fontSize: 15,)),
              //SizedBox(height:50),
              // MaterialButton(
              //   onPressed: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (_)=>DateRangePickerWidget()));
              //   },
              //
              //     child: Text("attendence"))


            ],
          ),
        ),



        ),


    );

  }
  @override
  void dispose(){
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<Address>convertCoordinatesToAddress(Coordinates coordinates)async {
    var addresses= await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }
}
