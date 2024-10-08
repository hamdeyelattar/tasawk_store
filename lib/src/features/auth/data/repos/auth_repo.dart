import 'package:tasawk/src/core/language/lang_keys.dart';
import 'package:tasawk/src/core/service/graphql/api_result.dart';
import 'package:tasawk/src/features/auth/data/data_source/auth_data_source.dart';
import 'package:tasawk/src/features/auth/data/models/login_request.dart';
import 'package:tasawk/src/features/auth/data/models/login_response.dart';
import 'package:tasawk/src/features/auth/data/models/sign_up_request_body.dart';
import 'package:tasawk/src/features/auth/data/models/sign_up_response.dart';
import 'package:tasawk/src/features/auth/data/models/user_role_response.dart';

class AuthRepos {
  AuthRepos(this._authDataSource);

  final AuthDataSource _authDataSource;

  // login
  Future<ApiResult<LoginResponse>> login(LoginRequestBody body) async {
    try {
      final res = await _authDataSource.login(body: body);
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(LangKeys.loggedError);
    }
  }

  Future<UserRoleResponse> userRole(String token) async {
    final response = await _authDataSource.userRole(token);
    return response;
  }

  //SignUp
  Future<ApiResult<SignUpResponse>> signUp(SignUpRequestBody body) async {
    try {
      final response = await _authDataSource.signUp(body: body);

      return ApiResult.success(response);
    } catch (error) {
      return const ApiResult.failure('Please, try agian we have error');
    }
  }
}
