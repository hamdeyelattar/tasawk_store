import 'package:tasawk/src/core/service/graphql/api_result.dart';
import 'package:tasawk/src/core/utils/app_strings.dart';
import 'package:tasawk/src/features/admin/add_categories/data/data_source/categories_admin_data_source.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/create_category_request_body.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/create_category_response.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/get_all_categories_response.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/update_category_request_body.dart';

class CategoriesAdminRepos {
  const CategoriesAdminRepos(this._dataSource);

  final CategoriesAdmindataSource _dataSource;
  Future<ApiResult<CategoriesGetAllResponse>> getAllCategoriesAdmin() async {
    try {
      final res = await _dataSource.getAllCategoriesAdmin();
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }

  Future<ApiResult<CreateCategoryResponse>> createCategory({
    required CreateCategoryRequestBody body,
  }) async {
    try {
      final res = await _dataSource.createCategory(body);
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }

  Future<ApiResult<void>> deleteCategory({
    required String categoryId,
  }) async {
    try {
      final res = await _dataSource.deleteCategory(categoryId);
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }

  Future<ApiResult<void>> updateCategory({
    required UpdateCategoryRequestBody body,
  }) async {
    try {
      final res = await _dataSource.updateCategory(body);
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }
}
