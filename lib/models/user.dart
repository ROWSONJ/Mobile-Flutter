class AppUser {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  AppUser({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      password: data['password'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }
}