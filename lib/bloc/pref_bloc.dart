import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:sportinfo/bloc/pref_event.dart';
import 'package:sportinfo/bloc/pref_state.dart';
import '../shared_pref.dart';

class PrefBloc extends Bloc<PrefEvent, PrefState> {
  PrefBloc() : super(PrefState('', false)) {
    on<PrefEvent>(_onLoad);
  }
  _onLoad(PrefEvent event, Emitter emit) async {
    late bool isConnection;
    try {
      final result = await InternetAddress.lookup('ya.ru');//google.com
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnection = true;
      }
    } on SocketException catch (_) {
      isConnection = false;
    }
    late String value = "";
    try {
      SharedPref sharedPref = SharedPref();
      String value = await sharedPref.load();
    }catch(_){
      value = "";
    }
    emit(PrefState(value, isConnection));
  }
}
