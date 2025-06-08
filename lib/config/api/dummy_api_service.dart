import 'package:dice_pizza/config/api/dummy_request.dart';
import 'package:dice_pizza/config/errors/custom_exception.dart';
import 'package:dice_pizza/domain/entities/user.dart';
import 'package:dice_pizza/infraestructure/mappers/user_mapper.dart';
import 'package:dice_pizza/infraestructure/models/dummy_auth_response.dart';
import 'package:dio/dio.dart';

class DummyApiService {
  final Dio dio;
  String error = '';
  DummyApiService(this.dio);

  ///Logs in using a username and a password
  Future<User?> authenticate(DummyRequest request) async {
    Map<String, dynamic> data = {};
    try {
      await dio.post(request.endpoint.name, data: request.info).then((json) {
        data = json.data;
      });
    } on DioException catch (e) {
      CustomException.parseDioException(e);
    } catch (e, st) {
      CustomException.parseGenericException(e, st);
    }
    return parseUserResponse(data);
  }

  ///Retrieves the full information of the user its given an access token for
  Future<User?> getCurrentUser(DummyRequest request) async {
    dio.options.headers['Authorization'] = request.info['Authorization'];
    Map<String, dynamic> data = {};

    try {
      await dio.get(request.endpoint.name).then((json) {
        data = json.data;
      });
    } on DioException catch (e) {
      CustomException.parseDioException(e);
    } catch (e, st) {
      CustomException.parseGenericException(e, st);
    }
    return parseUserResponse(data);
  }

  ///Returns new access and refresh tokens using a valid refreshToken
  Future<Map<String, dynamic>> refreshToken(DummyRequest request) async {
    Map<String, dynamic> data = {};
    try {
      await dio.post(request.endpoint.name, data: request.info).then((json) {
        data = json.data;
      });
    } on DioException catch (e) {
      CustomException.parseDioException(e);
    } catch (e, st) {
      CustomException.parseGenericException(e, st);
    }
    return data;
  }

  ///Turns a Dio's [Response]'s data into a User entity
  User? parseUserResponse(Map<String, dynamic> json) {
    if (!json.containsKey('firstName')) {
      return null;
    }
    final readableResponse = UserResponse.fromJson(json);
    return UserMapper.toUserEntity(readableResponse);
  }

  ///Retrieves an error message from the api's response
  String parseError(Map<String, dynamic> json) {
    return json['message'] ?? '';
  }
}
