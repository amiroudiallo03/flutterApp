import 'package:flutter/material.dart';
import 'package:oda_first_app/providers/auth_provider.dart';
import 'package:oda_first_app/providers/user_profider.dart';
import 'package:oda_first_app/screens/dashboard.dart';
import 'package:oda_first_app/screens/login.dart';
import 'package:oda_first_app/screens/editprofiles.dart';
import 'package:oda_first_app/screens/register.dart';
import 'package:oda_first_app/screens/uiprofiles.dart';
import 'package:oda_first_app/screens/vulnerable.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login Registration',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),  
          home: Login(),
          routes: {
            '/login': (context) => Login(),
            '/register': (context) => Register(),
            '/dashboard': (context) => DashBoard(),
            '/vulnerability': (context) => Vulnerability(),
            '/editprofiles': (context) => EditProfile(),
            '/profileeightpage': (context) => ProfileEightPage(),
          },
        ));
  }
}
