import 'package:tasawk/src/core/service/graphql/api_service.dart';
import 'package:tasawk/src/core/service/graphql/graph_queries/admin/products_queries.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/create_product_request_body.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/get_all_product_response.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/update_product_request_body.dart';

class ProductsAdminDataSource {
  ProductsAdminDataSource(this._graphql);

  final ApiService _graphql;
  Future<GetAllProductResponse> getAllProducts() async {
    final res = await _graphql
        .getAllProducts(ProductsQueries().getAllProductsMapQuery());
    return res;
  }

  Future<void> createProduct({required CreateProductRequestBody body}) async {
    final res = await _graphql
        .createProduct(ProductsQueries().createProductMap(body: body));
    return res;
  }

  Future<void> deleteProduct({required String id}) async {
    final res = _graphql.deleteProduct(
      ProductsQueries().deleteProductQuery(productId: id),
    );
    return res;
  }

  Future<void> updateProduct({required UpdateProductRequestBody body}) async {
    final res = _graphql.updateProduct(
      ProductsQueries().updateProductMap(body: body),
    );
    return res;
  }
}
