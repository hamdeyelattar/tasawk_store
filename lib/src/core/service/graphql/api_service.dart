import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tasawk/src/core/app/upload_image/model/upload_image_response.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/create_category_response.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/get_all_categories_response.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/get_all_product_response.dart';
import 'package:tasawk/src/features/admin/dashbord/data/models/categories_number_response.dart';
import 'package:tasawk/src/features/admin/dashbord/data/models/porducts_number_response.dart';
import 'package:tasawk/src/features/admin/dashbord/data/models/users_number_response.dart';
import 'package:tasawk/src/features/admin/users/data/models/get_all_users_response.dart';
import 'package:tasawk/src/features/auth/data/models/login_response.dart';
import 'package:tasawk/src/features/auth/data/models/sign_up_response.dart';
import 'package:tasawk/src/features/auth/data/models/user_role_response.dart';
part 'api_service.g.dart';

const String baseUrl = 'https://api.escuelajs.co';
const String graphql = '/graphql';
const String userRole = '/api/v1/auth/profile';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(graphql)
  Future<LoginResponse> login(
    @Body() Map<String, dynamic> mutation,
  );
  @GET('/api/v1/auth/profile')
  Future<UserRoleResponse> userRole();

  @POST('/api/v1/files/upload')
  Future<UploadImageResource> uploadImage(
    @Body() FormData file,
  );
  @POST(graphql)
  Future<SignUpResponse> signUp(
    @Body() Map<String, dynamic> mutation,
  );
  @POST(graphql)
  Future<ProductsNumberResponse> numberOfProducts(
    @Body() Map<String, dynamic> query,
  );
  @POST(graphql)
  Future<CategoriesNumberResponse> numberOfCategories(
    @Body() Map<String, dynamic> query,
  );
  @POST(graphql)
  Future<UsersNumberResponse> numberOfUsers(
    @Body() Map<String, dynamic> query,
  );
  @POST(graphql)
  Future<CategoriesGetAllResponse> getAllCategories(
    @Body() Map<String, dynamic> query,
  );
  @POST(graphql)
  Future<CreateCategoryResponse> createCategory(
    @Body() Map<String, dynamic> mutation,
  );
  @POST(graphql)
  Future<void> deleteCategory(
    @Body() Map<String, dynamic> mutation,
  );
  @POST(graphql)
  Future<void> updateCategory(
    @Body() Map<String, dynamic> mutation,
  );

  ///--------------Products---------------
  @POST(graphql)
  Future<GetAllProductResponse> getAllProducts(
    @Body() Map<String, dynamic> mutation,
  );
  @POST(graphql)
  Future<void> createProduct(
    @Body() Map<String, dynamic> mutation,
  );
  @POST(graphql)
  Future<void> deleteProduct(
    @Body() Map<String, dynamic> mutation,
  );
  @POST(graphql)
  Future<void> updateProduct(
    @Body() Map<String, dynamic> mutation,
  );
  //--------users--------
  @POST(graphql)
  Future<GetAllUsersResponse> getAllUsers(
    @Body() Map<String, dynamic> query,
  );
  @POST(graphql)
  Future<void> deleteUser(
    @Body() Map<String, dynamic> query,
  );
}
