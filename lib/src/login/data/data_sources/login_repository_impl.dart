import 'package:dio/dio.dart';

import '../../../../core/config/app_constant.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../../domain/repositories/login_repository.dart';
import '../models/login_response.dart';

class LoginRepositoryImpl extends LoginRepository {
  final Dio dio = Dio();

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
    bool isStudent = false,
    bool isTeacher = false,
    bool isParent = false,
  }) async {
    String url = '${AppConstant.serverUrl}/o/login/';

    Map<String, dynamic> data = {
      'is_teacher': isTeacher,
      'is_parent': isParent,
      'is_student': isStudent,
      'username': email,
      'password': password,
      'grant_type': 'password',
      'client_id': AppConstant.clientId,
      'client_secret': AppConstant.clientSecret
    };

    return await dio.post(url, data: data).then((value) {
      return LoginResponse(
          data: value.data, status: value.statusCode?.toString() ?? '');
    }).onError((Response<dynamic> error, stackTrace) {
      throw {
        'status': error.statusCode.toString(),
        'data': error.data,
      };
    }).catchError((onError) {
      final error = onError as DioException;

      if (error.response != null && error.response!.data != null) {
        throw {
          'status': error.response?.statusCode ?? '400',
          'data': error.response!.data,
        };
      }

      throw error;
    });
  }

  @override
  Future<void> saveTokens(
      {required String accessToken, required String refreshToken}) async {
    await LocalStorage.storeLocalStorage('_token', accessToken);
    await LocalStorage.storeLocalStorage('_refreshToken', refreshToken);
  }
}
