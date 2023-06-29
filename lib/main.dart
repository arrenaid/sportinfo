import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportinfo/bloc/pref_bloc.dart';
import 'package:sportinfo/bloc/pref_event.dart';
import 'package:sportinfo/bloc/pref_state.dart';
import 'package:sportinfo/firebase/firebase_remote_config_service.dart';
import 'package:sportinfo/screens/example_webview_screen.dart';
import 'package:sportinfo/screens/network_access_error_screen.dart';
import 'package:sportinfo/screens/placeholder_screen.dart';
import 'package:sportinfo/screens/sport_list_screen.dart';
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
  ));
}
_getAccessNetwork() async{
  late bool isConnection;
  try {
    final result = await InternetAddress.lookup('ya.ru');//google.com
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnection = true;
    }
  } on SocketException catch (_) {
    isConnection = false;
  }
  return isConnection;
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.firebaseRemoteConfigService, required this.isAccess});

  final FirebaseRemoteConfigService firebaseRemoteConfigService;
  late String target;
  final bool isAccess;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PrefBloc()..add(PrefEvent()),
      child: BlocBuilder<PrefBloc, PrefState>(builder: (context, state) {
        return MaterialApp(
          title: 'Pag',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: _getScreen(state),
          routes: {
            'PlaceholderScreen': (context) => const PlaceholderScreen(),
            'error': (context) => const NetworkAccessErrorScreen(),
          },
        );
      }),
    );
  }

  Widget _getScreen(PrefState state) {
    try {
      return checkUrlSharedPref()
          ? (isAccess
              ? AviatScreen(save: target)
              : const NetworkAccessErrorScreen())
          : (isAccess
              ? (state.url.isNotEmpty
                  ? _checkIsCheckVpn()
                      ? state.isVpn
                          ? const SportListScreen()
                          : AviatScreen(save: state.url)
                      : state.isEmu
                          ? const SportListScreen()
                          : AviatScreen(save: state.url)
                  : const SportListScreen())
              : const NetworkAccessErrorScreen());
    } catch (e) {
      return const NetworkAccessErrorScreen();
    }
  }

  bool _checkIsCheckVpn() {
    bool isCheckVpn = firebaseRemoteConfigService.getIsCheckVpn();
    return isCheckVpn;
  }

  bool checkUrlSharedPref() {
    var urlInfo = firebaseRemoteConfigService.getUrlInfo();
    if (urlInfo.isNotEmpty && urlInfo != "") {
      target = urlInfo;
      SharedPref().save(target);
      return true;
    } else {
      return false;
    }
  }
}
