import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'dart:developer' as developer;

//@riverpod
FirebaseRemoteConfigService firebaseRemoteConfigService(_){
  throw UnimplementedError();
}

class FirebaseRemoteConfigService{
  const FirebaseRemoteConfigService({
    required this.firebaseRemoteConfig
  });

  final FirebaseRemoteConfig firebaseRemoteConfig;
  init() async{
    try{
      await firebaseRemoteConfig.ensureInitialized();
      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 10),
            minimumFetchInterval: Duration.zero,
        ),
      );
      await firebaseRemoteConfig.fetchAndActivate();
    } on FirebaseException catch(e, st){
      developer.log('no remote config: ', error: e, stackTrace: st);
    }
  }

  String getUrlInfo() => firebaseRemoteConfig.getString('url_info');

}