import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/common/animations/animate_do.dart';
import 'package:tasawk/src/core/common/toast/show_toast.dart';
import 'package:tasawk/src/core/common/widgets/custom_linear_button.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/language/lang_keys.dart';
import 'package:tasawk/src/core/routes/app_routes.dart';
import 'package:tasawk/src/core/shared_widgets/app_loader.dart';
import 'package:tasawk/src/core/style/fonts/font_weight_helper.dart';
import 'package:tasawk/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFadeInRight(
      duration: 500,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (userRole) {
              ShowToast.showToastErrorTop(
                message: context.translate(
                  LangKeys.loggedSuccessfully,
                ),
              );
              if (userRole == 'admin') {
                context.pushNamedAndRemoveUntil(AppRoutes.homeAdmin);
              } else {
                context.pushNamedAndRemoveUntil(AppRoutes.homeCustomerScreen);
              }
            },
            error: (message) {
              ShowToast.showToastErrorTop(message: message);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () {
              return const AppLoader();
            },
            orElse: () {
              return CustomLinearButton(
                width: context.width,
                height: 50.h,
                onPressed: () {
                  validateLogin(context);
                },
                child: TextApp(
                  text: context.translate(LangKeys.login),
                  theme: context.textStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeightHelper.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void validateLogin(BuildContext context) {
    if (context.read<AuthBloc>().formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            const AuthEvent.loginEvent(),
          );
    }
  }
}
