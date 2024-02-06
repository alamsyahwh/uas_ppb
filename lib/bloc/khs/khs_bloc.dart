// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:project_uas_ppb/data/datasources/khs_remote_datasource.dart';
import 'package:project_uas_ppb/data/models/response/khs_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'khs_event.dart';
part 'khs_state.dart';
part 'khs_bloc.freezed.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  KhsBloc() : super(const _Initial()) {
    on<KhsEvent>((event, emit) async {
      final response = await KhsRemoteDatasource().getKhs();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
