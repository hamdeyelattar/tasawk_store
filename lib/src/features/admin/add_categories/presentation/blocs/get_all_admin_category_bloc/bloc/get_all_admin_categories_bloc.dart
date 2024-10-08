import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/get_all_categories_response.dart';
import 'package:tasawk/src/features/admin/add_categories/data/repos/categories_admin_repos.dart';

part 'get_all_admin_categories_event.dart';
part 'get_all_admin_categories_state.dart';
part 'get_all_admin_categories_bloc.freezed.dart';

class GetAllAdminCategoriesBloc
    extends Bloc<GetAllAdminCategoriesEvent, GetAllAdminCategoriesState> {
  GetAllAdminCategoriesBloc(
    this._repo,
  ) : super(const GetAllAdminCategoriesState.loading()) {
    on<FetchAdminCategoriesEvent>(_fetchAdminCategories);
  }
  final CategoriesAdminRepos _repo;

  FutureOr<void> _fetchAdminCategories(
    FetchAdminCategoriesEvent event,
    Emitter<GetAllAdminCategoriesState> emit,
  ) async {
    if (event.isNotLoading) {
      emit(const GetAllAdminCategoriesState.loading());
    }

    final res = await _repo.getAllCategoriesAdmin();
    res.when(
      success: (data) {
        if (data.categoriesList.isEmpty) {
          emit(const GetAllAdminCategoriesState.empty());
        } else {
          emit(GetAllAdminCategoriesState.success(categoryModel: data));
        }
      },
      failure: (error) {
        emit(GetAllAdminCategoriesState.error(error: error));
      },
    );
  }
}
