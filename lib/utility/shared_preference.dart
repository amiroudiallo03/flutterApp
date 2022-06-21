import 'package:oda_first_app/doamin/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('userId', user.userId.toInt());
    prefs.setString('nom', user.nom.toString());
    prefs.setString('prenoms', user.prenoms.toString());
    prefs.setString('email', user.email.toString());
    prefs.setString('tel', user.tel.toString());
    prefs.setString('type', user.type.toString());
    prefs.setString('token', user.token.toString());

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt("userId");
    String? nom = prefs.getString("nom");
    String? prenoms = prefs.getString("prenoms");
    String? email = prefs.getString("email");
    String? tel = prefs.getString("tel");
    String? type = prefs.getString("type");
    String? token = prefs.getString("token");
    String? renewalToken = prefs.getString("renewaltoken");

    return User(
        userId: int.parse(userId.toString()),
        nom: nom.toString(),
        prenoms: prenoms.toString(),
        email: email.toString(),
        tel: tel.toString(),
        type: type.toString(),
        token: token.toString(),
        renewaltoken: renewalToken.toString());
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('name');
    prefs.remove('prenoms');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('type');
    prefs.remove('token');
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token.toString();
  }
}
