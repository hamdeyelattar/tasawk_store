import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawk/src/core/common/widgets/admin_app_bar.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/features/admin/users/presentation/bloc/delete_users/bloc/delete_user_bloc.dart';
import 'package:tasawk/src/features/admin/users/presentation/bloc/get_all_users/get_all_user_bloc.dart';
import 'package:tasawk/src/features/admin/users/presentation/refactors/user_body.dart';
import 'package:tasawk/src/injector.dart';

class UsersScreeen extends StatelessWidget {
  const UsersScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetAllUsersBloc>()
            ..add(
              const GetAllUsersEvent.getAllUsers(
                isNotLoading: true,
              ),
            ),
        ),
        BlocProvider(create: (context) => sl<DeleteUserBloc>()),
      ],
      child: const Scaffold(
        backgroundColor: ColorsDark.mainColor,
        appBar: AdminAppBar(
          isMain: true,
          backgroundColor: ColorsDark.mainColor,
          title: 'Users',
        ),
        body: UserBodyScreen(),
      ),
    );
  }
}
