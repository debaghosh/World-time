import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void setupWorldTime() async{
    WorldTime instance = WorldTime(location: 'Kolkata' ,flag: 'india.png' ,url: 'Asia/Kolkata');
    await instance.getTime();
    String newTime = instance.time;


    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location':instance.location,
      'flag':instance.flag,
      'time': newTime,
      'isDaytime':instance.isDaytime,
    });

  }


  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Center(
        child: SpinKitDoubleBounce(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
