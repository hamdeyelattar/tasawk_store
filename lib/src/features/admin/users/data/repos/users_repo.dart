import 'package:tasawk/src/core/service/graphql/api_result.dart';
import 'package:tasawk/src/core/utils/app_strings.dart';
import 'package:tasawk/src/features/admin/users/data/data_source/users_data_source.dart';
import 'package:tasawk/src/features/admin/users/data/models/get_all_users_response.dart';

class UsersRepo {
  UsersRepo(this._dataSource);

  final UsersDataSource _dataSource;
  Future<ApiResult<GetAllUsersResponse>> getAllUsers() async {
    try {
      final response = await _dataSource.getAllUsers();
      return ApiResult.success(response);
    } catch (error) {
      return const ApiResult.failure(errorMessage);
    }
  }

  Future<ApiResult<void>> deleteUser({required String userId}) async {
    try {
      final res = await _dataSource.deleteUser(userId: userId);
      return ApiResult.success(res);
    } catch (error) {
      return const ApiResult.failure(errorMessage);
    }
  }
}
