import 'package:tasawk/src/core/service/graphql/api_service.dart';
import 'package:tasawk/src/core/service/graphql/graph_queries/admin/users_queries.dart';
import 'package:tasawk/src/features/admin/users/data/models/get_all_users_response.dart';

class UsersDataSource {
  UsersDataSource(this._graphql);

  final ApiService _graphql;
  Future<GetAllUsersResponse> getAllUsers() async {
    final res =
        await _graphql.getAllUsers(UsersQueries().getAllUsersMapQuery());
    return res;
  }

  Future<void> deleteUser({required String userId}) async {
    final res = await _graphql
        .deleteUser(UsersQueries().deleteUserMapQuery(userId: userId));
    return res;
  }
}
