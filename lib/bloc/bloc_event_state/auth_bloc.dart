import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repo/auth_repo.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthInitialize()) {
    on<AuthStarted>(_mapAuthStartedToState);
    on<AuthLoggedIn>(_mapAuthLoggedInToState);
    on<AuthLoggedOut>(_mapAuthLoggedOutToState);
  }

  void _mapAuthStartedToState(AuthStarted event, Emitter<AuthState> emit) async {
    final isSignedIn = await _authRepo.isSignedIn();
    if (isSignedIn) {
      final firebaseUser = await _authRepo.getUser();
      emit(AuthSuccess(firebaseUser!));
    } else {
      emit(AuthFailure());
    }
  }

  void _mapAuthLoggedInToState(AuthLoggedIn event, Emitter<AuthState> emit) async {
    User? user = await _authRepo.getUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthFailure());
    }
  }

  void _mapAuthLoggedOutToState(AuthLoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthFailure());
    _authRepo.signOut();
  }
}
