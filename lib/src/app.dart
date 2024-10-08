import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tasawk/src/core/app/connectivity_controller.dart';
import 'package:tasawk/src/core/app/cubit/app_cubit.dart';
// import 'package:tasawk/src/core/app/env_variables.dart';
import 'package:tasawk/src/core/language/app_localizations_setup.dart';
import 'package:tasawk/src/core/routes/app_routes.dart';
import 'package:tasawk/src/core/service/shared_pref/pref_keys.dart';
import 'package:tasawk/src/core/service/shared_pref/shared_pref.dart';
import 'package:tasawk/src/core/style/theme/app_theme.dart';
import 'package:tasawk/src/features/auth/presentation/screens/login_screen.dart';
import 'package:tasawk/src/injector.dart';

class Tasawk extends StatefulWidget {
  const Tasawk({super.key});

  @override
  State<Tasawk> createState() => _TasawkState();
}

class _TasawkState extends State<Tasawk> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return ValueListenableBuilder(
    //   valueListenable: ConnectivityController.instance.isConnected,
    //   builder: (_, value, __) {
    //     if (value) {
    return BlocProvider(
      create: (context) => sl<AppCubit>()
        ..changeThemeMode(themeMode: SHP().getBoolean(PrefKeys.themeMode))
        ..getSavedLang(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final cubit = context.read<AppCubit>();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              onGenerateRoute: AppRoutes.onGenerateRoute,
              initialRoute: SHP().getString(PrefKeys.accessToken) != null
                  ? SHP().getString(PrefKeys.userRole) != 'admin'
                      ? AppRoutes.homeCustomerScreen
                      : AppRoutes.homeAdmin
                  : AppRoutes.login,
              theme: cubit.isDark ? themeLight() : themeDark(),
              navigatorKey: sl<GlobalKey<NavigatorState>>(),
              locale: Locale(cubit.currentLangCode),
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              home: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                child: const LoginScreen(),
              ),
            );
          },
        ),
      ),
    );

    // builder: (context, child) {
    //   ConnectivityController.instance.init();
    //   return child!;
    // },
    //   );
    // } else {
    //   return const MaterialApp(
    //     title: 'Not Network',
    //     debugShowCheckedModeBanner: false,
    //     home: NoNetWorkScreen(),
    //   );
    // }
    //   },
    // );
  }
}
