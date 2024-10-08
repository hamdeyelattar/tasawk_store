import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/add_categories/data/repos/categories_admin_repos.dart';

part 'delete_category_event.dart';
part 'delete_category_state.dart';
part 'delete_category_bloc.freezed.dart';

class DeleteCategoryBloc
    extends Bloc<DeleteCategoryEvent, DeleteCategoryState> {
  DeleteCategoryBloc(this._repo) : super(const DeleteCategoryState.initial()) {
    on<RemoveCategoryEvent>(_removeCategory);
  }
  final CategoriesAdminRepos _repo;

  FutureOr<void> _removeCategory(
    RemoveCategoryEvent event,
    Emitter<DeleteCategoryState> emit,
  ) async {
    emit(DeleteCategoryState.loading(categoryId: event.categoryId));
    final res = await _repo.deleteCategory(categoryId: event.categoryId);
    res.when(
      success: (_) {
        emit(const DeleteCategoryState.success());
      },
      failure: (error) {
        emit(DeleteCategoryState.error(error: error));
      },
    );
  }
}
