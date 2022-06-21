import 'package:oda_first_app/doamin/user.dart';
import 'package:oda_first_app/utility/shared_preference.dart';

class AppUrl {


  


  
  static const String baseUrl =
      'http://192.168.252.231:8000/api/v1/';

  static const String login = 'http://192.168.252.231:8000/api/v1/connexion';
  static const String register =
      'http://192.168.252.231:8000/api/v1/inscription';
  static const String forgotPassword = baseUrl + '/forgot_password';
  static const String addVulnerability =
      'http://192.168.252.231:8000/api/v1/personne-vulnerable';
  static const String editProfiles =
      'http://192.168.252.231:8000/api/v1/personne-affiliee/}';
}
