class User {
  String accessToken;
  String refreshToken;
  final int id;
  final String firstName;
  final String lastName;
  final String? maidenName;
  final int? age;
  final String gender;
  final String? email;
  final String? phone;
  final String username;
  final String password;
  final String birthDate;
  final String image;

  ///String that contains the user's first name and last name
  @override
  String toString() {
    return ('$firstName $lastName');
  }

  ///Returns a url that contains a bigger version of the user's profile image
  String resizeImage() {
    final String resized =
        image.replaceRange(image.length - 3, image.length, '300');
    return resized;
  }

  User({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.firstName,
    required this.lastName,
    this.maidenName,
    this.age,
    required this.gender,
    this.email,
    this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
  });
  User copyWith(
      {String? accessToken,
      String? refreshToken,
      int? id,
      String? firstName,
      String? lastName,
      String? maidenName,
      int? age,
      String? gender,
      String? email,
      String? phone,
      String? username,
      String? password,
      String? birthDate,
      String? image}) {
    return User(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        maidenName: maidenName ?? this.maidenName,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        username: username ?? this.username,
        password: password ?? this.password,
        birthDate: birthDate ?? this.birthDate,
        image: image ?? this.image);
  }
}
