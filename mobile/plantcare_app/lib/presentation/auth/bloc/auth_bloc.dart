import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantcare_app/data/services/auth_service.dart';
import 'package:plantcare_app/data/services/token_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final TokenService _tokenService;

  AuthBloc(this._authService, this._tokenService) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authService.login(event.email, event.password);
      await _tokenService.saveToken(response['token']);
      emit(AuthSuccess(
        token: response['token'],
        name: response['name'],
        email: response['email'],
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.register(event.name, event.email, event.password);
      final response = await _authService.login(event.email, event.password);
      await _tokenService.saveToken(response['token']);
      emit(AuthSuccess(
        token: response['token'],
        name: response['name'],
        email: response['email'],
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
