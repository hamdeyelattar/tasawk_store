import 'package:tasawk/src/core/service/graphql/api_service.dart';
import 'package:tasawk/src/core/service/graphql/graph_queries/admin/categories_queries.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/create_category_request_body.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/create_category_response.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/get_all_categories_response.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/update_category_request_body.dart';

class CategoriesAdmindataSource {
  const CategoriesAdmindataSource(this._graphql);

  final ApiService _graphql;
  Future<CategoriesGetAllResponse> getAllCategoriesAdmin() async {
    final res = await _graphql.getAllCategories(
      CategoriesQueries().getAllCategories(),
    );
    return res;
  }

  Future<CreateCategoryResponse> createCategory(
    CreateCategoryRequestBody body,
  ) async {
    final res = await _graphql.createCategory(
      CategoriesQueries().createMapQuery(body: body),
    );
    return res;
  }

  Future<void> deleteCategory(String categoryId) async {
    final res = await _graphql.deleteCategory(
      CategoriesQueries().deleteMapQuery(categoryId: categoryId),
    );
    return res;
  }

  Future<void> updateCategory(UpdateCategoryRequestBody body) async {
    final res = await _graphql.updateCategory(
      CategoriesQueries().updateMapQuery(body: body),
    );
    return res;
  }
}
