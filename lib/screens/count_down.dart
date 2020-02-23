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
      body: Container(
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
                  FloatingActionButton(
                      backgroundColor: themeColors[0],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38.0),
                          side: BorderSide(color: themeColors[0])),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()))),
                ],
              ),
            ),
            SizedBox(
              height: _screenHeight / 5,
              width: _screenWidth,
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: themeColors[0],
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Consumer<EventProvider>(
                                builder: (context, provider, child) => Text(
                                  provider.day.toString(),
                                  style: TextStyle(fontSize: 65),
                                ),
                              )),
                          Text('days')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Consumer<EventProvider>(
                                builder: (context, provider, child) => Text(
                                  provider.hour.toString(),
                                  style: TextStyle(fontSize: 65),
                                ),
                              )),
                          Text('hours')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Consumer<EventProvider>(
                                builder: (context, provider, child) {
                                  print("Minute" + provider.minute.toString());
                                  return Text(
                                    provider.minute.toString(),
                                    style: TextStyle(fontSize: 65),
                                  );
                                },
                              )),
                          Text('minutes')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: StreamBuilder<int>(
                                stream: secondStream.secondStream(),
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(fontSize: 65),
                                  );
                                },
                              )),
                          Text('seconds')
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
    );
  }
}
