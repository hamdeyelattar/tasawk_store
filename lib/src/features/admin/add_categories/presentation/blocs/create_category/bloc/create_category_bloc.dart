import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/create_category_request_body.dart';
import 'package:tasawk/src/features/admin/add_categories/data/repos/categories_admin_repos.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';
part 'create_category_bloc.freezed.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  CreateCategoryBloc(this._repos) : super(const CreateCategoryState.initial()) {
    on<NewCreateCategoryEvent>(createCategory);
  }
  final CategoriesAdminRepos _repos;

  FutureOr<void> createCategory(
    NewCreateCategoryEvent event,
    Emitter<CreateCategoryState> emit,
  ) async {
    emit(const CreateCategoryState.loading());
    final res = await _repos.createCategory(
      body: event.body,
    );
    res.when(
      success: (data) {
        emit(const CreateCategoryState.success());
      },
      failure: (error) {
        emit(CreateCategoryState.error(error: error));
      },
    );
  }
}
