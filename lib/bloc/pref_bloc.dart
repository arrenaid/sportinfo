import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:sportinfo/bloc/pref_event.dart';
import 'package:sportinfo/bloc/pref_state.dart';
import '../shared_pref.dart';

class PrefBloc extends Bloc<PrefEvent, PrefState> {
  PrefBloc() : super(PrefState('', true)) {
    on<PrefEvent>(_onLoad);
  }
  _onLoad(PrefEvent event, Emitter emit) async {
    late bool isConnection ;
    try {
      final result = await InternetAddress.lookup('dart.dev');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnection = true;
      }
    } on SocketException catch (_) {
      isConnection = false;
    }

    SharedPref sharedPref = SharedPref();
    String value = await sharedPref.load();

    emit(PrefState(value, isConnection));
  }
}
