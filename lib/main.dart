import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportinfo/bloc/pref_bloc.dart';
import 'package:sportinfo/bloc/pref_event.dart';
import 'package:sportinfo/bloc/pref_state.dart';
import 'package:sportinfo/firebase/firebase_remote_config_service.dart';
import 'package:sportinfo/screen/check_url_screen.dart';
import 'package:sportinfo/screen/placeholder_screen.dart';
import 'package:sportinfo/screen/web_view_screen.dart';
import 'package:sportinfo/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBY-wKbbqtoDhAHy8Mh73WM9Sx6KSV3LHc',
          appId: '1:332082040696:android:632c03a71379ac05ab828d',
          messagingSenderId: '332082040696 ',
          projectId: 'sportinfo-16d96',
          storageBucket: 'sportinfo-16d96.appspot.com'
      ));
  final firebaseRemoteConfigService = FirebaseRemoteConfigService(
      firebaseRemoteConfig: FirebaseRemoteConfig.instance);
  await firebaseRemoteConfigService.init();
  runApp(
      MyApp(firebaseRemoteConfigService: firebaseRemoteConfigService,)
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key, required this.firebaseRemoteConfigService});

  final FirebaseRemoteConfigService firebaseRemoteConfigService;
  late String target;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PrefBloc()..add(PrefEvent()),
      child: BlocBuilder<PrefBloc,PrefState>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: state.url.isNotEmpty
                  ? (state.access ? WebViewScreen(targetUrl: state.url)
                  : const CheckUrlScreen())
                  : ( checkUrl() ? WebViewScreen(targetUrl: target)
                  : const PlaceholderScreen() ),
            );
        }
    ),
    );
  }

  bool checkUrl(){
    var urlInfo = firebaseRemoteConfigService.getUrlInfo();
    if(urlInfo.isNotEmpty){
      print(urlInfo);
      Map value = jsonDecode(urlInfo);
      print(value['url']);
      if(value['url']!.isNotEmpty) {
        target = value['url']!;
        SharedPref sharedPref = SharedPref();
        sharedPref.save(target);
      } else {
        return false;
      }
      return true;
    }else{
      return false;
    }
  }
  // bool checkSharedPref(String load)  {
  //   if(load.isEmpty ){
  //     return false;
  //   }
  //   else{
  //     print(load.toString());
  //     target = load.toString();
  //     return true;
  //   }
  // }
}
