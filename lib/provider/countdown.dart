import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  int _year=0;
  int _second=0;
  int _day=0;
  int _month=0;
  int _hour=0;
  int _minute=0;
  bool _timerFinished = false;
  bool _showError = false;
  String _eventName = "";
  bool _showTextError = false;

  int get year => _year;
  int get month => _month;
  int get day => _day;
  int get hour => _hour;
  int get minute => _minute;
  bool get timerFinished => _timerFinished;
  bool get showError => _showError;
  String get eventName => _eventName;
  bool get showTextError => _showTextError;

  set showTextError(err){
    _showTextError = err;
    notifyListeners();
    Future.delayed(Duration(seconds: 5)).then((_){
      _showTextError = false;
      notifyListeners();
    });
  }
  
  
  
  

  Future<bool> initValues(
      {@required int year,
      @required int month,
      @required int day,
      @required int minute,
      @required int hour, @required String eventName}) async{
    _year = year;
    _month = month;
    _day = day;
    _hour = hour;
    _minute = minute;
    _eventName = eventName;
    await validateInput();
  }

  String getRandomString()
  {
    return "Hey! Thats not how a countdown works!";
  }

  validateInput() {
    var thisInstant = DateTime.now();
    var thisMoment = TimeOfDay.now();
    var days = thisInstant.day;
    var months = thisInstant.month;
    var years = thisInstant.year;
    var hours = thisMoment.hour;
    var minutes = thisMoment.minute;
    print(
        'years: $years, months: $months,days: $days,hours: $hours,minutes: $minutes');
    convertInput(days, months, years, hours, minutes);
  }

  void convertInput(days, months, years, hours, minutes) async{
    DateTime localTime = DateTime(years, months, days, hours, minutes);
    DateTime userTime = DateTime(_year, _month, _day, _hour, _minute);

    var difference = userTime.difference(localTime);

    var actualSeconds = difference.inSeconds;
    var actualMinutes = 0;
    var actualHours = 0;
    var actualDays = 0;
    while (actualSeconds >= 60) {
      actualSeconds -= 60;
      actualMinutes++;
      if (actualMinutes == 60) {
        actualMinutes = 0;
        actualHours++;
      }
      if (actualHours == 24) {
        actualHours = 0;
        actualDays++;
      }
    }

    _day = actualDays;
    _hour = actualHours;
    _minute = actualMinutes;
    _second = actualSeconds;
    print("Actualy D:"+_day.toString());
    print("Actualy H:"+_hour.toString());
    print("Actualy M:"+_minute.toString());
    print("Actualy S:"+_second.toString());
    if(actualSeconds<0 || (actualSeconds==0 && actualMinutes == 0 && actualHours == 0 && actualDays == 0))
    {
      _showError = true;
      notifyListeners();
      await Future.delayed(Duration(seconds:5)).then((_){
        _showError = false;
        notifyListeners();
      });


    }

  }

  Future<void> checkMinute(s) async {
    print(s);
    print(_minute);
    print(_hour);
    print(_day);
    if (s == 0 && _minute == 0 && _hour == 0 && _day == 0) {
      print('timer finished');
      _timerFinished = true;
      notifyListeners();
    } else if (s == 0 && _minute == 0 && _hour == 0) {
      _second = 61;
      _minute = 59;
      _hour = 23;
      _day--;
      print("Here");
      notifyListeners();
    } else if (s == 0 && _minute == 0) {
      _second = 61;
      _minute = 59;
      _hour--;
      
      print("Here");
      notifyListeners();
    } else if (s == 0) {
      _minute--;
      _second = 61;
      
      print("Here");
      notifyListeners();
    }
  }

  Stream<int> secondStream() async* {
    while (_second >= 0) {
      

      checkMinute(_second);
      if (_timerFinished) {
        break;
      }
      await Future.delayed(Duration(seconds: 1));
      yield _second -= 1;
    }
  }
}
