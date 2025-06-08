import 'package:dice_pizza/domain/entities/user.dart';
import 'package:dice_pizza/infraestructure/models/dummy_auth_response.dart';

class UserMapper {
  static User toUserEntity(UserResponse u) => User(
    accessToken: u.accessToken,
    refreshToken: u.refreshToken,
    id: u.id,
    firstName: u.firstName,
    lastName: u.lastName,
    maidenName: u.maidenName,
    age: u.age,
    gender: u.gender,
    email: u.email,
    phone: u.phone,
    username: u.username,
    password: u.password,
    birthDate: u.birthDate,
    image: u.image,
  );
}
