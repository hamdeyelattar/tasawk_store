import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/features/admin/users/data/repos/users_repo.dart';

part 'delete_user_event.dart';
part 'delete_user_state.dart';
part 'delete_user_bloc.freezed.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  DeleteUserBloc(this._repo) : super(const DeleteUserState.initial()) {
    on<RemoveUserEvent>(_deleteUser);
  }
  final UsersRepo _repo;

  FutureOr<void> _deleteUser(
    RemoveUserEvent event,
    Emitter<DeleteUserState> emit,
  ) async {
    final res = await _repo.deleteUser(userId: event.userId);
    res.when(
      success: (_) {
        emit(const DeleteUserState.success());
      },
      failure: (error) {
        emit(DeleteUserState.error(error: error));
      },
    );
  }
}
