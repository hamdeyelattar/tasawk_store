import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/app/upload_image/cubit/upload_image_cubit.dart';
import 'package:tasawk/src/core/common/bottom_sheet/custom_bottom_sheet.dart';
import 'package:tasawk/src/core/common/widgets/custom_container_linear_admin.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/extensions/string_exetension.dart';
import 'package:tasawk/src/core/style/fonts/font_family_helper.dart';
import 'package:tasawk/src/core/style/fonts/font_weight_helper.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/get_all_admin_category_bloc/bloc/get_all_admin_categories_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/get_all_admin_product/bloc/get_all_admin_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/update_product/bloc/update_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/widgets/delete/delete_product_widget.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/widgets/update/update_product_bottom_sheet.dart';
import 'package:tasawk/src/injector.dart';

class ProductAdminItem extends StatelessWidget {
  const ProductAdminItem({
    required this.imageUrl,
    required this.title,
    required this.categoryName,
    required this.price,
    required this.productId,
    required this.imageList,
    required this.description,
    required this.categoryId,
    super.key,
  });
  final String imageUrl;
  final String title;
  final String categoryName;
  final String description;
  final String price;
  final String productId;
  final String categoryId;
  final List<String> imageList;
  @override
  Widget build(BuildContext context) {
    return CustomContainerLinearAdmin(
      height: 250.h,
      width: 165.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DeleteProductWidget(
                productId: productId,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  CustomBottomSheet.showModalBottomSheetContainer(
                    context: context,
                    widget: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => sl<UpdateProductBloc>(),
                        ),
                        BlocProvider(
                          create: (context) => sl<UploadImageCubit>(),
                        ),
                        BlocProvider(
                          create: (context) => sl<GetAllAdminCategoriesBloc>()
                            ..add(
                              const GetAllAdminCategoriesEvent
                                  .fetchAdminCategories(
                                isNotLoading: false,
                              ),
                            ),
                        ),
                      ],
                      child: UpdateProductBottomSheet(
                        imageList: imageList,
                        categoryName: categoryName,
                        title: title,
                        price: price,
                        description: description,
                        productId: productId,
                        categoryId: categoryId,
                      ),
                    ),
                    whenComplete: () {
                      context.read<GetAllAdminProductBloc>().add(
                            const GetAllAdminProductEvent.getAllProducts(
                              isNotLoading: false,
                            ),
                          );
                    },
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                  size: 25,
                ),
              ),
            ],
          ),
          Flexible(
            child: Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl.imageProductFormate(),
                height: 200.h,
                width: 120.w,
              ),
            ),
          ),
          10.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TextApp(
              text: title,
              theme: context.textStyle.copyWith(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.bold,
                fontFamily: FontFamilyHelper.poppinsEnglish,
              ),
              maxLines: 1,
            ),
          ),
          5.ph,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: TextApp(
              text: categoryName,
              theme: context.textStyle.copyWith(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeightHelper.medium,
              ),
              maxLines: 1,
            ),
          ),
          5.ph,
          // Price
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                TextApp(
                  text: r'$ ',
                  theme: context.textStyle.copyWith(
                    color: Colors.yellowAccent,
                    fontSize: 13.sp,
                    fontWeight: FontWeightHelper.medium,
                  ),
                ),
                TextApp(
                  text: price,
                  theme: context.textStyle.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.medium,
                  ),
                ),
              ],
            ),
          ),
          10.ph,
        ],
      ),
    );
  }
}
