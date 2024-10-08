import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/app/upload_image/cubit/upload_image_cubit.dart';
import 'package:tasawk/src/core/common/toast/show_toast.dart';
import 'package:tasawk/src/core/common/widgets/custom_button.dart';
import 'package:tasawk/src/core/common/widgets/custom_drop_down.dart';
import 'package:tasawk/src/core/common/widgets/custom_text_field.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/core/style/fonts/font_family_helper.dart';
import 'package:tasawk/src/core/style/fonts/font_weight_helper.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/get_all_admin_category_bloc/bloc/get_all_admin_categories_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/data/models/update_product_request_body.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/update_product/bloc/update_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/widgets/update/update_product_image.dart';

class UpdateProductBottomSheet extends StatefulWidget {
  const UpdateProductBottomSheet({
    required this.imageList,
    required this.categoryName,
    required this.title,
    required this.price,
    required this.description,
    required this.productId,
    required this.categoryId,
    super.key,
  });

  final List<String> imageList;
  final String categoryName;
  final String title;
  final String price;
  final String description;
  final String productId;
  final String categoryId;

  @override
  State<UpdateProductBottomSheet> createState() =>
      _UpdateProductBottomSheetState();
}

class _UpdateProductBottomSheetState extends State<UpdateProductBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? categoryValueName;
  String? categoryValueId;
  @override
  void initState() {
    super.initState();

    categoryValueName = widget.categoryName;
    categoryValueId = widget.categoryId;
    _titleController.text = widget.title;
    _priceController.text = widget.price;
    _descriptionController.text = widget.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextApp(
                  text: 'Update Product',
                  theme: context.textStyle.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeightHelper.bold,
                    fontFamily: FontFamilyHelper.poppinsEnglish,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TextApp(
                text: 'Update a photos',
                theme: context.textStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.medium,
                  fontFamily: FontFamilyHelper.poppinsEnglish,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),
              UpdateProductImages(
                imageList: widget.imageList,
              ),
              SizedBox(height: 15.h),
              TextApp(
                text: 'Title',
                theme: context.textStyle.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.medium,
                  fontFamily: FontFamilyHelper.poppinsEnglish,
                ),
              ),
              SizedBox(height: 15.h),
              // Title
              CustomTextField(
                hintStyle: context.textStyle.copyWith(color: Colors.white),
                controller: _titleController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 2) {
                    return 'Please Selected Your Product Title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              TextApp(
                text: 'Price',
                theme: context.textStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.medium,
                  fontFamily: FontFamilyHelper.poppinsEnglish,
                ),
              ),
              SizedBox(height: 15.h),
              // Price
              CustomTextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                hintText: 'Price',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Selected Your Product Price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              TextApp(
                text: 'Description',
                theme: context.textStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.medium,
                  fontFamily: FontFamilyHelper.poppinsEnglish,
                ),
              ),
              SizedBox(height: 15.h),
              //Description
              CustomTextField(
                controller: _descriptionController,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                hintText: 'Description',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 2) {
                    return 'Please Selected Your Product description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              TextApp(
                text: 'Category',
                theme: context.textStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.medium,
                  fontFamily: FontFamilyHelper.poppinsEnglish,
                ),
              ),
              SizedBox(height: 15.h),
              BlocBuilder<GetAllAdminCategoriesBloc,
                  GetAllAdminCategoriesState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    success: (category) {
                      return CustomCreateDropDown(
                        items: category.categoryDropDownList,
                        hintText: '',
                        onChanged: (val) {
                          setState(() {
                            categoryValueName = val;

                            final catgeoryIdString = category.categoriesList
                                .firstWhere((e) => e.name == val)
                                .id!;
                            categoryValueId = catgeoryIdString;
                          });
                        },
                        value: categoryValueName,
                      );
                    },
                    orElse: () {
                      return CustomCreateDropDown(
                        items: const [''],
                        hintText: 'category',
                        onChanged: (val) {
                          setState(() {
                            categoryValueName = val;
                          });
                        },
                        value: categoryValueName,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 15.h),
              BlocConsumer<UpdateProductBloc, UpdateProductState>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: () {
                      context.pop();
                      ShowToast.showToastSuccessTop(
                        message: '${_titleController.text} Update Success',
                        seconds: 2,
                      );
                    },
                    error: (error) {
                      ShowToast.showToastErrorTop(
                        message: error,
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () {
                      return Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: ColorsDark.blueDark,
                          ),
                        ),
                      );
                    },
                    orElse: () {
                      return CustomButton(
                        onPressed: () {
                          _validUpdateProduct(context);
                        },
                        backgroundColor: ColorsDark.white,
                        lastRadius: 20,
                        threeRadius: 20,
                        textColor: ColorsDark.blueDark,
                        text: 'Update Product',
                        width: MediaQuery.of(context).size.width,
                        height: 50.h,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _validUpdateProduct(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<UpdateProductBloc>().add(
            UpdateProductEvent.updateProduct(
              body: UpdateProductRequestBody(
                title: _titleController.text,
                imageList: context.read<UploadImageCubit>().imageList.isEmpty
                    ? widget.imageList
                    : context.read<UploadImageCubit>().imageList,
                categoryId: double.parse(categoryValueId!),
                description: _descriptionController.text,
                price: double.parse(_priceController.text.trim()),
                productId: widget.productId,
              ),
            ),
          );
    }
  }
}
