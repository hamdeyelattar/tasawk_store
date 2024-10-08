import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/core/service/shared_pref/pref_keys.dart';
import 'package:tasawk/src/core/service/shared_pref/shared_pref.dart';
import 'package:tasawk/src/features/auth/data/models/login_request.dart';
import 'package:tasawk/src/features/auth/data/models/login_response.dart';
import 'package:tasawk/src/features/auth/data/models/sign_up_request_body.dart';
import 'package:tasawk/src/features/auth/data/repos/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repos) : super(const _Initial()) {
    on<_LoginEvent>(_login);
    on<SignUpEvent>(_signUp);
  }
  final AuthRepos _repos;
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FutureOr<void> _login(_LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final res = await _repos.login(
      LoginRequestBody(
        email: email.text.trim(),
        password: password.text,
      ),
    );
    await res.when(
      success: (LoginResponse loginData) async {
        //user token
        final token = loginData.data!.login!.accessToken ?? '';
        //Save token in shp
        await SHP().setString(PrefKeys.accessToken, token);
        //get user role
        final user = await _repos.userRole(token);

        await SHP().setInt(PrefKeys.userId, user.id);
        await SHP().setString(PrefKeys.userRole, user.userRole ?? '');
        emit(AuthState.success(userRole: user.userRole ?? ''));
      },
      failure: (error) {
        AuthState.error(error: error);
      },
    );
  }

  // signup and login to take user token
  FutureOr<void> _signUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _repos.signUp(
      SignUpRequestBody(
        email: email.text.trim(),
        password: password.text,
        avatar: event.imagUrl,
        name: name.text.trim(),
      ),
    );

    result.when(
      success: (signupData) {
        add(const AuthEvent.loginEvent());
      },
      failure: (error) {
        emit(AuthState.error(error: error));
      },
    );
  }
}
