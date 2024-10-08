import 'package:tasawk/src/core/service/graphql/api_result.dart';
import 'package:tasawk/src/core/utils/app_strings.dart';
import 'package:tasawk/src/features/admin/dashbord/data/data_source/dashboard_data_source.dart';
import 'package:tasawk/src/features/admin/dashbord/data/models/categories_number_response.dart';
import 'package:tasawk/src/features/admin/dashbord/data/models/porducts_number_response.dart';
import 'package:tasawk/src/features/admin/dashbord/data/models/users_number_response.dart';

class DashBoardRepo {
  const DashBoardRepo(this._dataSource);

  final DashBoardDataSource _dataSource;
  //Get Number of Products
  Future<ApiResult<ProductsNumberResponse>> numberOfProducts() async {
    try {
      final res = await _dataSource.numberOfProducts();
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }

//Get Number of Categories
  Future<ApiResult<CategoriesNumberResponse>> numberOfCategories() async {
    try {
      final res = await _dataSource.numberOfCategories();
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }

//Get Number of Users
  Future<ApiResult<UsersNumberResponse>> numberOfUsers() async {
    try {
      final res = await _dataSource.numberOfUsers();
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }
}
