import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/users/data/models/get_all_users_response.dart';
import 'package:tasawk/src/features/admin/users/data/repos/users_repo.dart';

part 'get_all_user_event.dart';
part 'get_all_user_state.dart';
part 'get_all_user_bloc.freezed.dart';

class GetAllUsersBloc extends Bloc<GetAllUsersEvent, GetAllUsersState> {
  GetAllUsersBloc(this._repo) : super(const GetAllUsersState.loading()) {
    on<FetchAllUsersEvent>(_getAllUsers);
    on<SearchForUserEvent>(_searchForUser);
  }
  final UsersRepo _repo;
  final searchController = TextEditingController();
  List<UsersModel> usersList = [];
  FutureOr<void> _getAllUsers(
    FetchAllUsersEvent event,
    Emitter<GetAllUsersState> emit,
  ) async {
    if (event.isNotLoading) {
      emit(const GetAllUsersState.loading());
    }

    final result = await _repo.getAllUsers();

    result.when(
      success: (users) {
        if (users.data.usersList.isEmpty) {
          emit(const GetAllUsersState.empty());
        } else {
          usersList = users.data.usersList;
          emit(GetAllUsersState.success(userList: usersList));
        }
      },
      failure: (error) {
        emit(GetAllUsersState.error(error: error));
      },
    );
  }

  FutureOr<void> _searchForUser(
    SearchForUserEvent event,
    Emitter<GetAllUsersState> emit,
  ) async {
    final res = usersList
        .where(
          (e) =>
              e.name!.toLowerCase().startsWith(
                    event.searchName!.toLowerCase().trim(),
                  ) ||
              e.email!
                  .toLowerCase()
                  .startsWith(event.searchName!.toLowerCase().trim()),
        )
        .toList();
    if (res.isEmpty) {
      emit(const GetAllUsersState.empty());
    } else {
      emit(GetAllUsersState.success(userList: res));
    }
  }
}
