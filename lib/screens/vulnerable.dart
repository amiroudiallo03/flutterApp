import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:oda_first_app/providers/auth_provider.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:oda_first_app/providers/auth_provider.dart';

class Vulnerability extends StatefulWidget {
  @override
  State<Vulnerability> createState() => _VulnerabilityState();
}

class _VulnerabilityState extends State<Vulnerability> {
  final _formKey = GlobalKey<FormState>();
  final nomcontroller = TextEditingController();
  final prenomcontroller = TextEditingController();
  final villecontroller = TextEditingController();
  final temperaturecontroller = TextEditingController();
  final telcontroller = TextEditingController();

  DateTime? selectedDate;

  bool _obsecure = true;

  int _currentStep = 0;

  void initState() {
    _obsecure = true;
    super.initState();
  }

  StepperType stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
        const Text("Registering ... please wait")
      ],
    );

    var addVulnerable = () {
      var dateDeNaissance = (selectedDate.toString()).substring(0, 10);

      if (nomcontroller.text.isEmpty ||
          prenomcontroller.text.isEmpty ||
          telcontroller.text.isEmpty ||
          villecontroller.text.isEmpty ||
          temperaturecontroller.text.isEmpty) {
        Flushbar(
          title: 'Champs incomplet',
          message: "Veillez remplir tous les champs",
          duration: const Duration(seconds: 3),
        ).show(context);
      } else {
        auth
            .addPerson(
                nomcontroller.text,
                prenomcontroller.text,
                telcontroller.text,
                dateDeNaissance,
                temperaturecontroller.text,
                telcontroller.text)
            .then((response) {
          var resp = json.decode(response.body);
          print(response.statusCode);
          print(resp);
          if (response.statusCode == 200 || response.statusCode == 201) {
            Navigator.pushReplacementNamed(context, '/login');
            Flushbar(
              title: 'Personne vulnerable',
              message: "personne vulnérable bien éffectué !",
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });
      }
      ;
    };
    tapped(int step) {
      setState(() => _currentStep = step);
    }

    continued() {
      _currentStep < 2 ? setState(() => _currentStep += 1) : addVulnerable();
    }

    cancel() {
      _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ajouter une personne vulnerable'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, ('/dashboard'));
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
          child: Column(
              // padding: const EdgeInsets.all(30.0),
              children: [
            Expanded(
                child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                  Step(
                    title: new Text('Informations Personnels'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          controller: nomcontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nom',
                              prefixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(Icons.person),
                              )),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          controller: prenomcontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Prenom',
                              prefixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(Icons.assignment),
                              )),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          controller: villecontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ville',
                              prefixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(Icons.assignment),
                              )),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        DateTimeFormField(
                          onDateSelected: (DateTime value) {
                            selectedDate = value;
                          },
                          //dateFormat: format,
                          decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Date de naissance'),
                          // firstDate: DateTime.now(),
                          // // initialDate: DateTime.now(),
                          autovalidateMode: AutovalidateMode.always,
                          mode: DateTimeFieldPickerMode.date,
                        )
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Informations mediacales'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          controller: temperaturecontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Temperature',
                              prefixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(Icons.thermostat),
                              )),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Mobile'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          autofocus: false,
                          obscureText: false,
                          controller: telcontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: ' Enter mobile',
                              prefixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(Icons.person),
                              )),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ])),
            const SizedBox(
              height: 15.0,
            ),
          ])),
    );
  }
}
