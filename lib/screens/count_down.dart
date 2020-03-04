import 'package:eventcountdown/provider/countdown.dart';
import 'package:flutter/material.dart';
import 'package:eventcountdown/theme.dart';
import 'package:provider/provider.dart';

import 'Homescreen.dart';

class CountDownScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var secondStream = Provider.of<EventProvider>(context);

    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: _screenHeight,
          width: _screenWidth,
          child: Image.asset(
            'assets/bgimage.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20.0),
          height: _screenHeight,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _screenHeight / 10,
                width: _screenWidth,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen())),
                      child: Container(
                        
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          border: Border.all(color:Colors.white),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _screenHeight / 5.5,
                width: _screenWidth,
              ),
              Consumer<EventProvider>(builder: (context, provider, child) {
                return Text(
                  provider.eventName,
                  style: TextStyle(fontSize: 25,color: Colors.white),
                );
              }),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      // color: themeColors[0],

                      border: Border.all(color:Colors.white)
                    ),
                    height: _screenHeight / 2 / 2,
                    width: _screenWidth,
                    margin: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color:Colors.white),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Consumer<EventProvider>(
                                  builder: (context, provider, child) => Text(
                                    provider.day.toString(),
                                    style: TextStyle(
                                        fontSize: 65, color: Colors.white),
                                  ),
                                )),
                            Text('days', style: TextStyle(color: Colors.white))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color:Colors.white),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Consumer<EventProvider>(
                                  builder: (context, provider, child) => Text(
                                    provider.hour.toString(),
                                    style: TextStyle(
                                        fontSize: 65, color: Colors.white),
                                  ),
                                )),
                            Text('hours', style: TextStyle(color: Colors.white))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color:Colors.white),
                                    borderRadius: BorderRadius.all(
                                      
                                        Radius.circular(10.0))),
                                child: Consumer<EventProvider>(
                                  builder: (context, provider, child) {
                                    print(
                                        "Minute" + provider.minute.toString());
                                    return Text(
                                      provider.minute.toString(),
                                      style: TextStyle(
                                          fontSize: 65, color: Colors.white),
                                    );
                                  },
                                )),
                            Text('minutes',
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color:Colors.white),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: StreamBuilder<int>(
                                  stream: secondStream.secondStream(),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data.toString(),
                                      style: TextStyle(
                                          fontSize: 65, color: Colors.white),
                                    );
                                  },
                                )),
                            Text('seconds',
                                style: TextStyle(color: Colors.white))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ]),
    );
  }
}
