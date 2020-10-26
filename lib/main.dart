import 'package:driving_test_scheduler/screens/addTestCenter_paid.dart';
import 'package:driving_test_scheduler/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:driving_test_scheduler/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getString('status');
  print(status);
  runApp(MaterialApp( debugShowCheckedModeBanner:false,theme: new ThemeData(
      primaryColor: Color(0xFF0d6898),
      primaryTextTheme: TextTheme(
          title: TextStyle(
              color: Colors.white
          )
      )
  ),home: status == null ? LoginScreen():Dashboard() ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: '',
      theme: new ThemeData(
          primaryColor: Color(0xFF0d6898),
          primaryTextTheme: TextTheme(
              title: TextStyle(
                  color: Colors.white
              )
          )
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
