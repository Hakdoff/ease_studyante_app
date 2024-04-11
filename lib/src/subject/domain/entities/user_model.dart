class UserModel {
  final String pk;
  final String email;
  final String firstName;
  final String lastName;
  final String userName;
  final String getFullName;

  UserModel({
    required this.pk,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.getFullName,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      pk: map['pk'] as String,
      email: map['email'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      userName: map['username'] as String,
      getFullName: map['get_full_name'] as String,
    );
  }
}
