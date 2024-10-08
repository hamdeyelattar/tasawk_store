import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/create_product_request_body.dart';
import 'package:tasawk/src/features/admin/add_products/data/repos/products_admin_repo.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';
part 'create_product_bloc.freezed.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  CreateProductBloc(this._repo) : super(const _Initial()) {
    on<NewCreateProductEvent>(_createproduct);
  }

  final ProductsAdminRepo _repo;

  FutureOr<void> _createproduct(
    NewCreateProductEvent event,
    Emitter<CreateProductState> emit,
  ) async {
    emit(const CreateProductState.loading());

    final result = await _repo.createProducts(body: event.body);

    result.when(
      success: (_) {
        emit(const CreateProductState.success());
      },
      failure: (error) {
        emit(CreateProductState.error(error: error));
      },
    );
  }
}
