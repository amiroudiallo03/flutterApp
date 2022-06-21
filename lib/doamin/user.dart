class User {
  User({
    
    required this.userId,
    this.nom,
    this.prenoms,
    this.email,
    this.tel,
    this.type,
    this.token,
    this.renewaltoken,
  });

  int userId;
  String? nom;
  String? prenoms;
  String? email;
  String? tel;
  String? type;
  String? token;
  String? renewaltoken;

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData["userId"],
      nom: responseData["nom"],
      prenoms: responseData["prenoms"],
      email: responseData["email"],
      tel: responseData["tel"],
      type: responseData["type"],
      token: responseData["token"],
      renewaltoken: responseData["renewaltoken"],
    );
  }
}
