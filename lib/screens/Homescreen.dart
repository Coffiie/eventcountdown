import 'package:eventcountdown/provider/countdown.dart';
import 'package:eventcountdown/screens/count_down.dart';
import 'package:eventcountdown/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _year;
  int _month;
  int _day;
  int _hour;
  int _minute;

  TextEditingController _textEditingController;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _textEditingController = TextEditingController();
    super.initState();
  }

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
    EventProvider provider = Provider.of<EventProvider>(context, listen: false);
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          height: _screenHeight,
          width: _screenWidth,
          child: Image.asset(
            "assets/bgimage.jpg",
            fit: BoxFit.cover,
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white),
            ),
            margin: EdgeInsets.only(left: 10, right: 10),
            height: _screenHeight / 2,
            width: _screenWidth,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _textEditingController,
                      decoration: InputDecoration(
                         
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          helperText: "Example: John's birthday!",
                          labelText: "Enter event name (Optional)",
                          focusColor: Colors.white,
                          helperStyle: TextStyle(color: Colors.white),
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.white))),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("Mark your event!",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))),
                        SizedBox(height: _screenHeight / 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18.0)),
                                  //color: themeColors[0],
                                ),
                                height: _screenHeight / 12,
                                width: _screenWidth / 4,
                                child: GestureDetector(
                                  onTap: () async {
                                    try {
                                      await selectDate(context).then(
                                          (context) => selectTime(context));

                                      await provider.initValues(
                                          year: this._year,
                                          month: this._month,
                                          day: this._day,
                                          minute: this._minute,
                                          hour: this._hour,
                                          eventName: _textEditingController.text
                                              .trim());
                                      if (!provider.showError) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CountDownScreen()),
                                                    );
                                      }
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
                                  //splashColor: themeColors[1],
                                  child: Center(
                                      child: Icon(
                                    Icons.add_alarm,
                                    color: Colors.white,
                                    size: _screenWidth / 10,
                                  )),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          Consumer<EventProvider>(builder: (context, data, child) {
            if (data.showError) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            return FadeTransition(
              opacity: _animation,
              child: Container(

                padding: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  'Hey! Thats not how a countdown works!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            );
          }),
        ],
      ),
    ]));
  }

  @override
  void dispose() {
    _controller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}
