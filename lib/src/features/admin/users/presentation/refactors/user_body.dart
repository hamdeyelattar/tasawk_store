import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/common/loading/empty_screen.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/features/admin/users/presentation/bloc/get_all_users/get_all_user_bloc.dart';
import 'package:tasawk/src/features/admin/users/presentation/widgets/search_for_users.dart';
import 'package:tasawk/src/features/admin/users/presentation/widgets/table_for_users.dart';

class UserBodyScreen extends StatelessWidget {
  const UserBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Column(
        children: [
          // serarch for users
          const SearchForUsers(),
          20.ph,
          Flexible(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<GetAllUsersBloc>().add(
                      const GetAllUsersEvent.getAllUsers(isNotLoading: true),
                    );
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: BlocBuilder<GetAllUsersBloc, GetAllUsersState>(
                      builder: (context, state) {
                        return state.when(
                          loading: () {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          },
                          success: (userList) {
                            return TableForUsers(
                              usersList: userList,
                            );
                          },
                          empty: EmptyScreen.new,
                          error: Text.new,
                          search: (userList) {
                            return TableForUsers(
                              usersList: userList,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 25.h,
                    ),
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
