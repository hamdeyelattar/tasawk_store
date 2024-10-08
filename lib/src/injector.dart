import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:tasawk/src/core/app/cubit/app_cubit.dart';
import 'package:tasawk/src/core/app/upload_image/cubit/upload_image_cubit.dart';
import 'package:tasawk/src/core/app/upload_image/data_source/upload_image_data_source.dart';
import 'package:tasawk/src/core/app/upload_image/repo/upload_image_repo.dart';
import 'package:tasawk/src/core/service/graphql/api_service.dart';
import 'package:tasawk/src/core/service/graphql/dio_factory.dart';
import 'package:tasawk/src/features/admin/add_categories/data/data_source/categories_admin_data_source.dart';
import 'package:tasawk/src/features/admin/add_categories/data/repos/categories_admin_repos.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/create_category/bloc/create_category_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/delete_category/bloc/delete_category_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/get_all_admin_category_bloc/bloc/get_all_admin_categories_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/update_category/bloc/update_category_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/data/data_source/products_admin_data_source.dart';
import 'package:tasawk/src/features/admin/add_products/data/repos/products_admin_repo.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/crate_product/bloc/create_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/delete_product/bloc/delete_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/get_all_admin_product/bloc/get_all_admin_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/update_product/bloc/update_product_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/data/data_source/dashboard_data_source.dart';
import 'package:tasawk/src/features/admin/dashbord/data/repos/dashboard_repo.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/categories_number/categories_number_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/products_number/products_number_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/users_number/users_number_bloc.dart';
import 'package:tasawk/src/features/admin/users/data/data_source/users_data_source.dart';
import 'package:tasawk/src/features/admin/users/data/repos/users_repo.dart';
import 'package:tasawk/src/features/admin/users/presentation/bloc/delete_users/bloc/delete_user_bloc.dart';
import 'package:tasawk/src/features/admin/users/presentation/bloc/get_all_users/get_all_user_bloc.dart';
import 'package:tasawk/src/features/auth/data/data_source/auth_data_source.dart';
import 'package:tasawk/src/features/auth/data/repos/auth_repo.dart';
import 'package:tasawk/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  await _initCore();
  await _initAuth();
  await _initDashBoard();
  await _initCategoriesAdmin();
  await _initProductsAdmin();
  await _initUsersAdmin();
}

Future<void> _initCore() async {
  final dio = DioFactory.getDio();
  final navigatorKey = GlobalKey<NavigatorState>();
  sl
    ..registerFactory(AppCubit.new)
    ..registerLazySingleton<ApiService>(() => ApiService(dio))
    ..registerSingleton<GlobalKey<NavigatorState>>(navigatorKey)
    ..registerFactory(() => UploadImageCubit(sl()))
    // ..registerFactory(ShareCubit.new)
    ..registerLazySingleton(() => UploadImageRepo(sl()))
    ..registerLazySingleton(() => UploadImageDataSource(sl()));
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(() => AuthBloc(sl()))
    ..registerLazySingleton(() => AuthRepos(sl()))
    ..registerLazySingleton(() => AuthDataSource(sl()));
}

Future<void> _initDashBoard() async {
  sl
    ..registerFactory(() => ProductsNumberBloc(sl()))
    ..registerFactory(() => CategoriesNumberBloc(sl()))
    ..registerFactory(() => UsersNumberBloc(sl()))
    ..registerLazySingleton(() => DashBoardRepo(sl()))
    ..registerLazySingleton(() => DashBoardDataSource(sl()));
}

Future<void> _initCategoriesAdmin() async {
  sl
    ..registerFactory(() => GetAllAdminCategoriesBloc(sl()))
    ..registerFactory(() => CreateCategoryBloc(sl()))
    ..registerFactory(() => DeleteCategoryBloc(sl()))
    ..registerFactory(() => UpdateCategoryBloc(sl()))
    ..registerLazySingleton(() => CategoriesAdminRepos(sl()))
    ..registerLazySingleton(() => CategoriesAdmindataSource(sl()));
}

Future<void> _initProductsAdmin() async {
  sl
    ..registerFactory(() => GetAllAdminProductBloc(sl()))
    ..registerFactory(() => CreateProductBloc(sl()))
    ..registerFactory(() => DeleteProductBloc(sl()))
    ..registerFactory(() => UpdateProductBloc(sl()))
    ..registerLazySingleton(() => ProductsAdminRepo(sl()))
    ..registerLazySingleton(() => ProductsAdminDataSource(sl()));
}

Future<void> _initUsersAdmin() async {
  sl
    ..registerLazySingleton(() => UsersRepo(sl()))
    ..registerLazySingleton(() => UsersDataSource(sl()))
    ..registerFactory(() => GetAllUsersBloc(sl()))
    ..registerFactory(() => DeleteUserBloc(sl()));
}
