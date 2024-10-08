import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/update_category_request_body.dart';
import 'package:tasawk/src/features/admin/add_categories/data/repos/categories_admin_repos.dart';

part 'update_category_event.dart';
part 'update_category_state.dart';
part 'update_category_bloc.freezed.dart';

class UpdateCategoryBloc
    extends Bloc<UpdateCategoryEvent, UpdateCategoryState> {
  UpdateCategoryBloc(this._repos) : super(const _Initial()) {
    on<NewUpdateCategoryEvent>(updateCategory);
  }
  final CategoriesAdminRepos _repos;

  FutureOr<void> updateCategory(
    NewUpdateCategoryEvent event,
    Emitter<UpdateCategoryState> emit,
  ) async {
    final res = await _repos.updateCategory(body: event.body);
    res.when(
      success: (_) {
        emit(const UpdateCategoryState.success());
      },
      failure: (error) {
        emit(UpdateCategoryState.error(error: error));
      },
    );
  }
}
