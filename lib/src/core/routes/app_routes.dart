import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawk/src/core/app/upload_image/cubit/upload_image_cubit.dart';
import 'package:tasawk/src/core/common/screens/under_build_screen.dart';
import 'package:tasawk/src/core/routes/base_routes.dart';
import 'package:tasawk/src/features/admin/home_admin/presentation/screen/home_admin_screen.dart';
import 'package:tasawk/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:tasawk/src/features/auth/presentation/screens/login_screen.dart';
import 'package:tasawk/src/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:tasawk/src/features/customer/customer_screen.dart';
import 'package:tasawk/src/injector.dart';

class AppRoutes {
  static const login = 'login';
  static const signUp = 'signup';
  static const homeAdmin = 'homeAdmin';
  static const homeCustomerScreen = 'homeCustomerScreen';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case login:
        return BaseRoute(
          page: BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: const LoginScreen(),
          ),
        );
      case signUp:
        return BaseRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<UploadImageCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<AuthBloc>(),
              ),
            ],
            child: const SignUpScreen(),
          ),
        );
      case homeAdmin:
        return BaseRoute(page: const HomeAdminScreen());
      case homeCustomerScreen:
        return BaseRoute(page: const HomeCustomerScreen());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
