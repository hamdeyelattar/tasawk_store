import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/get_all_product_response.dart';
import 'package:tasawk/src/features/admin/add_products/data/repos/products_admin_repo.dart';

part 'get_all_admin_product_event.dart';
part 'get_all_admin_product_state.dart';
part 'get_all_admin_product_bloc.freezed.dart';

class GetAllAdminProductBloc
    extends Bloc<GetAllAdminProductEvent, GetAllAdminProductState> {
  GetAllAdminProductBloc(this._repo)
      : super(const GetAllAdminProductState.loading()) {
    on<FetchAllAdminProductEvent>(_getAllProducts);
  }

  final ProductsAdminRepo _repo;

  FutureOr<void> _getAllProducts(
    FetchAllAdminProductEvent event,
    Emitter<GetAllAdminProductState> emit,
  ) async {
    if (event.isNotLoading) {
      emit(const GetAllAdminProductState.loading());
    }

    final result = await _repo.getAllProducts();

    result.when(
      success: (data) {
        if (data.productGetAllList.isEmpty) {
          emit(const GetAllAdminProductState.empty());
        } else {
          emit(
            GetAllAdminProductState.success(
              productList: data.productGetAllList,
            ),
          );
        }
      },
      failure: (error) {
        emit(GetAllAdminProductState.failure(errorMessage: error));
      },
    );
  }
}
