// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/common/loading/empty_screen.dart';
import 'package:tasawk/src/core/common/loading/loading_shimmer.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/get_all_admin_product/bloc/get_all_admin_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/widgets/create/create_product.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/widgets/product_admin_item.dart';

class AddProductsBody extends StatelessWidget {
  const AddProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 30.h,
      ),
      child: Column(
        children: [
          const CreateProduct(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<GetAllAdminProductBloc>().add(
                      const GetAllAdminProductEvent.getAllProducts(
                        isNotLoading: true,
                      ),
                    );
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20.h),
                  ),
                  BlocBuilder<GetAllAdminProductBloc, GetAllAdminProductState>(
                    builder: (context, state) {
                      return state.when(
                        empty: EmptyScreen.new,
                        failure: Text.new,
                        loading: () {
                          return SliverToBoxAdapter(
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 10,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 15,
                                childAspectRatio: 165 / 250,
                              ),
                              itemBuilder: (context, index) {
                                return LoadingShimmer(
                                  height: 220.h,
                                  width: 165.w,
                                );
                              },
                            ),
                          );
                        },
                        success: (list) {
                          return SliverToBoxAdapter(
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: list.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 15,
                                childAspectRatio: 165 / 250,
                              ),
                              itemBuilder: (context, index) {
                                return ProductAdminItem(
                                  imageUrl: list[index].images!.first,
                                  title: list[index].title ?? '',
                                  categoryName:
                                      list[index].category!.name ?? '',
                                  price: list[index].price.toString(),
                                  productId: list[index].id ?? '',
                                  imageList: list[index].images ?? [],
                                  description: list[index].description ?? '',
                                  categoryId: list[index].category!.id ?? '',
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20.h),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
