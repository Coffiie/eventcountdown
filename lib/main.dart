import 'package:eventcountdown/provider/countdown.dart';
import 'package:eventcountdown/screens/Homescreen.dart';
import 'package:eventcountdown/screens/count_down.dart';
import 'package:eventcountdown/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
          providers: [ChangeNotifierProvider(create: (context)=> EventProvider()),],
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.white),
          title: 'Event countdown app',
          home:HomeScreen(),
        ),
    );
  }
}

