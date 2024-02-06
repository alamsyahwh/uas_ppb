import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_uas_ppb/data/models/request/auth_request_model.dart';
import 'package:project_uas_ppb/data/models/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(_Initial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
