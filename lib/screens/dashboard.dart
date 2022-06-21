import 'package:flutter/material.dart';
import 'package:oda_first_app/doamin/user.dart';
import 'package:oda_first_app/utility/shared_preference.dart';

import 'package:provider/provider.dart';

import '../providers/user_profider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("DASHBOARD PAGE"),
        elevation: 0.1,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notification_important)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/profileeightpage');
              },
              icon: Icon(Icons.person_outline_rounded)),
        ],
      ),
      body: Column(
        children: [
          Center(child: Text('${user.userId}')),
          SizedBox(
            height: 100,
          ),
          Center(child: Text('${user.email}')),
          SizedBox(height: 100),
          Center(child: Text('${user.tel}')),
          SizedBox(height: 100),
          Center(child: Text('${user.token}')),
          // RaisedButton(
          //   onPressed: () {
          //     // UserPreferences().removeUser();
          //     Navigator.pushReplacementNamed(context, '/login');
          //   },
          //   child: Text("Logout"),
          //   color: Colors.lightBlueAccent,
          // ),
          RaisedButton(
            onPressed: () {
              // UserPreferences().removeUser();
              Navigator.pushReplacementNamed(context, '/vulnerability');
            },
            child: Text("add person"),
            color: Colors.lightBlueAccent,
          )
        ],
      ),
    );
  }
}
