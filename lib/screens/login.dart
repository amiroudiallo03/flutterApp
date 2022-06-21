import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:oda_first_app/doamin/user.dart';
import 'package:oda_first_app/providers/user_profider.dart';
import 'package:oda_first_app/utility/validator.dart';
import 'package:oda_first_app/utility/widgets.dart';
import 'package:provider/provider.dart';
import 'package:oda_first_app/providers/auth_provider.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  bool _obsecure = true;

  void initState() {
    _obsecure = true;
    super.initState();
  }
  // final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    String? email, password;

    //   void showPassword() {
    //   setState(() {
    //     obsecureText = !obsecureText;
    //   });
    // }

    var doLogin = () {
      final form = _formKey.currentState;

      if (_formKey.currentState!.validate()) {
        form!.save();

        final Future<Map<String, dynamic>> respose =
            auth.login(email.toString(), password.toString());
        respose.then((response) {
          print(response);

          if (response['status'] == true) {
            print("true response");
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (response['status'] == false) {
            print('false response');
            Flushbar(
              title: 'echec de la connexion',
              message: 'Email ou mot de passe incorrect',
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: 'invalid form',
          message: 'Please complete the form properly',
          duration: Duration(seconds: 3),
        ).show(context);
      }
    };

    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
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
                  const Text("Email"),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    // validator: validateEmail(_username!),
                    onSaved: (value) => email = value,
                    controller: emailcontroller,
                    validator: (value) {
                      validateEmail(value.toString());
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Email',
                        prefixIcon: const Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.email),
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text("Password"),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: _obsecure,
                    validator: (value) =>
                        value!.isEmpty ? "Please enter password" : null,
                    onSaved: (value) => password = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obsecure = !_obsecure;
                                print(_obsecure);
                              });
                            },
                            icon: Icon(
                              _obsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            )),
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.lock),
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  auth.loggedInStatus == Status.Authenticating
                      ? loading
                      : longButtons("Login", () {
                          doLogin();
                        }),
                  const SizedBox(
                    height: 8.0,
                  ),
                  forgotLabel(context)
                ],
              ),
            ),
          ),
        ));
  }
}

var loading = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    const CircularProgressIndicator(),
    const Text("Login ... please wait")
  ],
);

forgotLabel(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {},
        child: Text("forgot password",
            style: const TextStyle(fontWeight: FontWeight.w300)),
      ),
      FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/register');
        },
        child: Text("Sign up",
            style: const TextStyle(fontWeight: FontWeight.w300)),
      )
    ],
  );
}
