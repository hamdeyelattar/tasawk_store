import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/dashbord/data/repos/dashboard_repo.dart';

part 'categories_number_event.dart';
part 'categories_number_state.dart';
part 'categories_number_bloc.freezed.dart';

class CategoriesNumberBloc
    extends Bloc<CategoriesNumberEvent, CategoriesNumberState> {
  CategoriesNumberBloc(this._repo)
      : super(const CategoriesNumberState.loading()) {
    on<CategoriesNumberEvent>(_getCategoriesNumber);
  }
  final DashBoardRepo _repo;
  FutureOr<void> _getCategoriesNumber(
    CategoriesNumberEvent event,
    Emitter<CategoriesNumberState> emit,
  ) async {
    emit(const CategoriesNumberState.loading());
    final res = await _repo.numberOfCategories();
    res.when(
      success: (categoriesData) {
        emit(
          CategoriesNumberState.success(
            numbers: categoriesData.categoriesNumbers,
          ),
        );
      },
      failure: (error) {
        emit(CategoriesNumberState.error(error: error));
      },
    );
  }
}
