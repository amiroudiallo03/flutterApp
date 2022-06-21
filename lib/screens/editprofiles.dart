import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oda_first_app/doamin/user.dart';
import 'package:oda_first_app/utility/shared_preference.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/user_profider.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nomcontroller = TextEditingController();
  final prenomcontroller = TextEditingController();
  final telcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    User user = Provider.of<UserProvider>(context).user;

    var editProfile = () {
      if (nomcontroller.text.isEmpty ||
          prenomcontroller.text.isEmpty ||
          telcontroller.text.isEmpty) {
        Flushbar(
          title: 'Champs incomplet',
          message: "Veillez remplir tous les champs",
          duration: const Duration(seconds: 3),
        ).show(context);
      } else {
        print('send');
        auth
            .editPerson(
                nomcontroller.text, prenomcontroller.text, telcontroller.text)
            .then((response) {
          print('response');

          if (response.statusCode == 200) {
            Navigator.pushReplacementNamed(context, '/profileeightpage');
            Flushbar(
              title: 'Profile modifier',
              message: "Votre profile a été bien modifié",
              duration: const Duration(seconds: 2),
            ).show(context);
          }
        });
      }
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Modifier profile"),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, ('/profileeightpage'));
            },
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    // child: Image.network(""),
                  ),
                  Align(
                    alignment: Alignment(0, 0.8),
                    child: MaterialButton(
                      minWidth: 0,
                      elevation: 0.5,
                      color: Colors.white,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.pink,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nomcontroller,
                    decoration: InputDecoration(
                        labelText: "Nom", hintText: "${user.nom}"),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: prenomcontroller,
                    decoration: InputDecoration(
                        labelText: "Prenom", hintText: "${user.prenoms}"),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                      controller: telcontroller,
                      decoration: InputDecoration(
                          labelText: "Telephone", hintText: "${user.tel}"),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "${user.email}",
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // InputDatePickerFormField(
                  //   firstDate: DateTime(DateTime.now().year - 5),
                  //   lastDate: DateTime(DateTime.now().year + 5),
                  //   initialDate: DateTime.now(),
                  //   fieldLabelText: "Date of Birth",
                  // ),
                  const SizedBox(height: 70.0),

                  MaterialButton(
                    child: Text("Modifier"),
                    color: Colors.orange,
                    onPressed: () {
                      editProfile();
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ), 
      ),
    );
  }
}
