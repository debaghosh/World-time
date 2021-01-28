import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;
  int isDaytime;

  WorldTime({this.location,this.flag,this.url});

  Future <void> getTime() async{

    try{
        Response response = await get('http://worldtimeapi.org/api/timezone/$url');
        Map data = jsonDecode(response.body);
        DateTime utcTime = DateTime.parse(data['utc_datetime']);
        DateTime locationTime = utcTime.add( Duration(seconds: data['raw_offset']));

        isDaytime = locationTime.hour > 4 && locationTime.hour < 18 ? 1 : 0;
        isDaytime??=1;

        time = DateFormat.jm().format(locationTime);
      }
      catch(e){
        print('found error $e');
        time = 'Could not get time data 😓';

      }

  }

}