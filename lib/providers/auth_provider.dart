import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:oda_first_app/doamin/user.dart';
import 'package:oda_first_app/doamin/user.dart';
import '../utility/app_url.dart';
import '../utility/shared_preference.dart';
import 'package:provider/provider.dart';

import '../providers/user_profider.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _resgisteredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _resgisteredInStatus;

  set registeredInstatus(Status value) {
    _resgisteredInStatus = value;
  }

  Future<Response> register(String nom, String prenoms, String tel,
      String email, String pwd1, String pwd2) async {
    final Map<String, dynamic> apiBodyData = {
      'nom': nom,
      'prenoms': prenoms,
      'tel': tel,
      'email': email,
      'pwd1': pwd1,
      'pwd2': pwd2
    };

    return await post(Uri.parse(AppUrl.register),
        body: json.encode(apiBodyData),
        headers: {'Content-Type': 'application/json'});
  }

  notify() {
    notifyListeners();
  }

  Future<Response> addPerson(String nom, String prenoms, String ville,
      String dateDeNaissance, String temperature, String tel) async {
    var token = await UserPreferences.getToken();
    print(token);

    final Map<String, dynamic> apiBodyData = {
      "nom_personne_vulnerable": nom,
      "prenom_personne_vulnerable": prenoms,
      "telephone": tel,
      "date_naissance": dateDeNaissance,
      "temperature_normale": temperature
    };

    return await post(Uri.parse(AppUrl.addVulnerability),
        body: json.encode(apiBodyData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
  }

  Future<Response> editPerson(String nom, String prenoms, String tel) async {
    var token = await UserPreferences.getToken();
    var user = await UserPreferences().getUser();
    var userId = user.userId;

    final Map<String, dynamic> apiBodyData = {
      "nom": nom,
      "prenoms": prenoms,
      "tel": tel,
    };

    return await put(
        Uri.parse(
            "http://192.168.252.231:8000/api/v1/personne-affiliee/${userId}"),
        body: json.encode(apiBodyData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
        // 'X-ApiKey': 'ZGlzIzEyMw=='
      },
    );

    var etat = json.decode(response.body);
    print(etat);
    if (etat['success'] == true) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(response.statusCode);
      print(responseData['data']);

      User authUser = User.fromJson(responseData['data']);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
}
