import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:sportinfo/bloc/pref_event.dart';
import 'package:sportinfo/bloc/pref_state.dart';
import '../shared_pref.dart';
import 'package:device_info/device_info.dart';
import 'package:check_vpn_connection/check_vpn_connection.dart';

class PrefBloc extends Bloc<PrefEvent, PrefState> {
  PrefBloc() : super(PrefState('', false,false)) {
    on<PrefEvent>(_onLoad);
  }
  _onLoad(PrefEvent event, Emitter emit) async {
    late String value = "";
    late bool isEmu = false;
    late bool isVpn = false;

    isEmu = await _checkIsEmu();
    isVpn = await _vpnActive();

    try {
      SharedPref sharedPref = SharedPref();
      String value = await sharedPref.load();
      print('Shared Preferences load -> $value');
    }catch(e){
      value = "";
    }

    emit(PrefState(value, isEmu, isVpn));
  }
  _checkIsEmu() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final em = await deviceInfo.androidInfo;

    var phoneModel = em.model;
    var buildProduct = em.product;
    var buildHardware = em.hardware;

    var result = (em.fingerprint.startsWith("generic") ||
        phoneModel.contains("google_sdk") ||
        phoneModel.contains("droid4x") ||
        phoneModel.contains("Emulator") ||
        phoneModel.contains("Android SDK built for x86") ||
        em.manufacturer.contains("Genymotion") ||
        buildHardware == "goldfish" ||
        buildHardware == "vbox86" ||
        buildProduct == "sdk" ||
        buildProduct == "google_sdk" ||
        buildProduct == "sdk_x86" ||
        buildProduct == "vbox86p" ||
        em.brand.contains('google')||
        em.board.toLowerCase().contains("nox") ||
        em.bootloader.toLowerCase().contains("nox") ||
        buildHardware.toLowerCase().contains("nox") ||
        !em.isPhysicalDevice ||
        buildProduct.toLowerCase().contains("nox"));

    if (result) return true;
    result = result ||
        (em.brand.startsWith("generic") && em.device.startsWith("generic"));
    if (result) return true;
    result = result || ("google_sdk" == buildProduct);
    return result;
  }

  _vpnActive () async{
    if (await CheckVpnConnection.isVpnActive()) {
      return true;
    }else{
      return false;
    }
  }
}
