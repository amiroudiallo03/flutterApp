import 'package:flutter/cupertino.dart';
import 'package:oda_first_app/doamin/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(userId: -1);

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
