import 'package:tasawk/src/core/service/graphql/api_result.dart';
import 'package:tasawk/src/core/utils/app_strings.dart';
import 'package:tasawk/src/features/admin/add_products/data/data_source/products_admin_data_source.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/create_product_request_body.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/get_all_product_response.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/update_product_request_body.dart';

class ProductsAdminRepo {
  ProductsAdminRepo(this._dataSource);

  final ProductsAdminDataSource _dataSource;
  Future<ApiResult<GetAllProductResponse>> getAllProducts() async {
    try {
      final res = await _dataSource.getAllProducts();
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }

  // create products
  Future<ApiResult<void>> createProducts({
    required CreateProductRequestBody body,
  }) async {
    try {
      final res = await _dataSource.createProduct(body: body);
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }

  Future<ApiResult<void>> deleteProduct({
    required String productId,
  }) async {
    try {
      final res = await _dataSource.deleteProduct(id: productId);
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }

  Future<ApiResult<void>> updateProductAdmin({
    required UpdateProductRequestBody body,
  }) async {
    try {
      final res = await _dataSource.updateProduct(body: body);
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure(errorMessage);
    }
  }
}
