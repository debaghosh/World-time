import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:google_fonts/google_fonts.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    Navigator.pushNamed(context, '/');
    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {

    //argument data from the loading page
    data = data.isNotEmpty?data:ModalRoute.of(context).settings.arguments;
    print(data);


    if(data['isDaytime']==null){
      print("TRY AGAIN!");
    }

    String bgImage = data['isDaytime']==1? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime']==1? Colors.pinkAccent:Colors.indigo[700];
    Color textColor = data['isDaytime']==1? Colors.black:Colors.white;
    

    return Scaffold(
      backgroundColor: bgColor,
      body:SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: _onRefresh,

          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit:BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: [
                  FlatButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'location':result['location'],
                            'flag':result['flag'],
                            'time': result['time'],
                            'isDaytime':result['isDaytime'],
                          };
                        });

                        },
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.red,
                      ),
                      label:Text("Edit Location",
                      textAlign: TextAlign.center,
                      style:TextStyle(
                            color: textColor,
                            letterSpacing: .5
                      ),
                      ),
                  ),
                  SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: textColor,
                          fontFamily: 'Lora',
                      ),),

                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                    child: Center(
                      child: Text(data['time'],
                        style: TextStyle(
                            fontSize: 30.0,
                            letterSpacing: 2.0,
                            color: textColor,
                            fontFamily: 'Lora',
                        ),),
                    ),
                  )
                ],
              ),
            ),
          )
      )
    ),
    );
  }
}
