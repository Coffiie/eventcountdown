import 'package:eventcountdown/provider/countdown.dart';
import 'package:eventcountdown/screens/count_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  int _year;
  int _month;
  int _day;
  int _hour;
  int _minute;

  Future<BuildContext> selectDate(context) async {
    DateTime _date = DateTime.now();
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1970),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      _year = pickedDate.year;
      _month = pickedDate.month;
      _day = pickedDate.day;

      print("year: $_year,month: $_month,day: $_day");
    }

    return context;
  }

  Future<void> selectTime(context) async {
    TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      _hour = pickedTime.hour;
      _minute = pickedTime.minute;
      print("hour: $_hour,minute: $_minute");
    }
  }

  @override
  Widget build(BuildContext context) {
    EventProvider  provider = Provider.of<EventProvider>(context,listen: false);
    var _themeColors = [Colors.cyan, Colors.cyanAccent];
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
            child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: _screenHeight / 2,
                width: _screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 100,
                        spreadRadius: 0,
                        color: _themeColors[1])
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextField(
                          decoration: InputDecoration(
                              labelText: "Enter event name",
                              labelStyle: TextStyle(
                                  fontSize: 20, color: _themeColors[0]))),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Mark your event!",
                                    style: TextStyle(
                                        fontSize: 20, color: _themeColors[0]))),
                            SizedBox(height: _screenHeight / 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Material(
                                  child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: _themeColors[1],
                                      ),
                                      height: _screenHeight / 12,
                                      width: _screenWidth / 4,
                                      child: InkWell(
                                        onTap: () async {
                                          await selectDate(context).then(
                                              (context) => selectTime(context));
                                           
                                           Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>CountDownScreen()));
                                           provider.initValues(year: this._year, month: this._month, day: this._day, minute: this._minute, hour: this._hour);       
                                          
                                        },
                                        splashColor: _themeColors[0],
                                        child: Center(
                                            child: Icon(
                                          Icons.add_alarm,
                                          color: _themeColors[0],
                                          size: _screenWidth / 6,
                                        )),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]))));
  }
}
