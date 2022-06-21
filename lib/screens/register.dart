import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
// import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:oda_first_app/providers/auth_provider.dart';

import 'package:oda_first_app/utility/validator.dart';
import 'package:provider/provider.dart';

import '../doamin/user.dart';
import '../providers/user_profider.dart';
import '../utility/widgets.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final nomcontroller = TextEditingController();
  final prenomcontroller = TextEditingController();
  final telcontroller = TextEditingController();
  final pwdcontroller = TextEditingController();
  final pwd2controller = TextEditingController();
  bool _obsecure = true;

  int _currentStep = 0;

  void initState() {
    _obsecure = true;
    super.initState();
  }

  StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    String? _nom;
    String? _prenoms;
    String? _tel;
    String? _email;
    String? _pwd1;
    String? _pwd2;

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
        const Text("Registering ... please wait")
      ],
    );

    // tapped(int step) {
    //   setState(() => _currentStep = step);
    // }

    // cancel() {
    //   _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    // }

    // switchStepsType() {
    //   setState(() => stepperType == StepperType.vertical
    //       ? stepperType = StepperType.horizontal
    //       : stepperType = StepperType.vertical);
    // }

    // ignore: prefer_typing_uninitialized_variables
    var doRegister = () {
      final form = _formKey.currentState;
      if (_formKey.currentState!.validate()) {
        form!.save();
        // auth.loggedInStatus = Status.Authenticating;
        // auth.notify();

        // Future.delayed(loginTime).then((_) {
        //   Navigator.pushReplacementNamed(context, '/login');
        //   auth.loggedInStatus = Status.LoggedIn;
        //   auth.not.ify();
        // });
        // if (nomcontroller.text.isEmpty ||
        //     prenomcontroller.text.isEmpty ||
        //     telcontroller.text.isEmpty ||
        //     emailcontroller.text.isEmpty ||
        //     pwdcontroller.text.isEmpty ||
        //     pwd2controller.text.isEmpty) {
        //   Flushbar(
        //     title: 'Champs incomplet',
        //     message: "Veillez remplir tous les champs",
        //     duration: const Duration(seconds: 3),
        //   ).show(context);
        // }

        if (pwdcontroller.text == pwd2controller.text) {
          auth
              .register(_nom.toString(), _prenoms.toString(), _tel.toString(),
                  _email.toString(), _pwd1.toString(), _pwd2.toString())
              .then((response) {
            var resp = json.decode(response.body);
            print(response.statusCode);
            print(resp);
            var inscrit = false;
            if (response.statusCode == 200 || response.statusCode == 201) {
              User user = User.fromJson(resp['data']);
              Provider.of<UserProvider>(context, listen: false).setUser(user);
              Navigator.pushReplacementNamed(context, '/login');
              Flushbar(
                title: 'Inscription terminé',
                message: resp['message'],
                duration: const Duration(seconds: 3),
              ).show(context);
            } else {
              Flushbar(
                title: 'Registration fail',
                message: response.toString(),
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          });
        } else {
          Flushbar(
            title: 'Mismatch password',
            message: 'Please enter valid confirm password',
            duration: const Duration(seconds: 3),
          ).show(context);
        }
      } else {
        Flushbar(
          title: 'Invalid form',
          message: "Please complete the form properly",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    };
    continued() {
      _currentStep < 2 ? setState(() => _currentStep += 1) : doRegister();
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                const Text("Nom"),
                TextFormField(
                  autofocus: false,
                  obscureText: false,
                  onSaved: (value) => _nom = value,
                  controller: nomcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Enter Nom',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(Icons.person),
                      )),
                ),
                const SizedBox(height: 15.0),
                const Text("Prenom"),
                TextFormField(
                  autofocus: false,
                  obscureText: false,
                  onSaved: (value) => _prenoms = value,
                  controller: prenomcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Enter prenom',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(Icons.assignment),
                      )),
                ),
                const SizedBox(height: 15.0),
                const Text("Telephone"),
                TextFormField(
                  autofocus: false,
                  obscureText: false,
                  onSaved: (value) => _tel = value,
                  controller: telcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Enter Telephone',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(Icons.phone),
                      )),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text("Email"),
                TextFormField(
                  autofocus: false,
                  obscureText: false,
                  onSaved: (value) => _email = value,
                  controller: emailcontroller,
                  validator: (value) {
                    validateEmail(value.toString());
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(Icons.email),
                      )),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text("Password"),
                TextFormField(
                  autofocus: false,
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? "Password" : null,
                  onSaved: (value) => _pwd1 = value,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Password',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(Icons.lock),
                      )),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text("Password"),
                TextFormField(
                  autofocus: false,
                  obscureText: true,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter password" : null,
                  onSaved: (value) => _pwd2 = value,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(Icons.lock),
                      )),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons("Register", () {
                        doRegister();
                      }),
              ],
            )),
      ),
    );
  }
}
