import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportinfo/bloc/pref_bloc.dart';

import '../shared_pref.dart';

class CheckUrlScreen extends StatefulWidget {
  const CheckUrlScreen({Key? key}) : super(key: key);

  @override
  State<CheckUrlScreen> createState() => _CheckUrlScreenState();
}

class _CheckUrlScreenState extends State<CheckUrlScreen> {
  late TextEditingController _textController;
  final _collectionPath = 'urls';
  final _urlKey = 'url';

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // checkIsEmu() async {
  //   final em = await devinfo.androidInfo;
  //   var phoneModel = em.model;
  //   var buildProduct = em.product;
  //   var buildHardware = em.hardware;
  //   var result = (em.fingerprint.startsWith("generic") ||
  //       phoneModel.contains("google_sdk") ||
  //       phoneModel.contains("droid4x") ||
  //       phoneModel.contains("Emulator") ||
  //       phoneModel.contains("Android SDK built for x86") ||
  //       em.manufacturer.contains("Genymotion") ||
  //       buildHardware == "goldfish" ||
  //       buildHardware == "vbox86" ||
  //       buildProduct == "sdk" ||
  //       buildProduct == "google_sdk" ||
  //       buildProduct == "sdk_x86" ||
  //       buildProduct == "vbox86p" ||
  //       em.brand.contains('google')||
  //       em.board.toLowerCase().contains("nox") ||
  //       em.bootloader.toLowerCase().contains("nox") ||
  //       buildHardware.toLowerCase().contains("nox") ||
  //       !em.isPhysicalDevice ||
  //       buildProduct.toLowerCase().contains("nox"));
  //   if (result) return true;
  //   result = result ||
  //       (em.brand.startsWith("generic") && em.device.startsWith("generic"));
  //   if (result) return true;
  //   result = result || ("google_sdk" == buildProduct);
  //   return result;
  // }

  _writeData(String value) async {
    Map<String, dynamic> data = {_urlKey: value};
    await FirebaseFirestore.instance
        .collection(_collectionPath)
        .add(data)
        .then((value) => print('write data - ok :$value'))
        .catchError((error) => print(error));
  }

  _readAllData(BuildContext context) async {
    final db = FirebaseFirestore.instance;
    Map<String, dynamic> data = {};
    var querySnapshot =
        await db.collection(_collectionPath).get().then((value) {
      for (var row in value.docs) {
        print('${row.id}:${row.data()}');
        data.addAll(row.data());
      }
    });
    _showD(context, data.toString());
  }

  Future<bool> _checkData(String value) async {
    final db = FirebaseFirestore.instance;
    bool result = false;
    Map<String, dynamic> data = {_urlKey: value};
    await db.collection(_collectionPath).get().then((value) {
      for (var row in value.docs) {
        if (row.data().toString() == data.toString()) {
          print('Success');
          result = true;
        } else {
          print('No');
        }
      }
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Text(
                  'The application requires network access',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  SharedPref sharedPref = SharedPref();
                  sharedPref.save('');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      // if (states.contains(MaterialState.pressed)) {
                      //   return colGreenButton.withOpacity(0.9);} else
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.blueGrey;
                      }
                      return Colors.green; // Use the component's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34.0),
                    ),
                  ),
                ),
                child: SizedBox(
                  //width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: Center(
                    child: const Text(
                      'clear',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
               const SizedBox(height: 30),
            ],
          ),
          // Column(
          //   children: [
          // const SizedBox(height: 30),
          // const Spacer(),
          // Container(
          //   //margin: const EdgeInsets.symmetric(horizontal: 24.0),
          //   padding: const EdgeInsets.symmetric(horizontal: 31.0,vertical: 20.0),
          //   decoration: BoxDecoration(
          //     color: Colors.white60,
          //     borderRadius: BorderRadius.circular(30.0),
          //   ),
          //   child: TextField(
          //     controller: _textController,
          //     textAlign: TextAlign.center,
          //     style:TextStyle(fontSize: 24, color: Colors.green[800]),
          //     decoration: InputDecoration.collapsed(
          //         hintText: 'Enter url',
          //         hintStyle: TextStyle(
          //           fontSize: 24,
          //           color: Colors.green[800],
          //         ),
          //     ),
          //   ),
          // ),
          // const Spacer(),
          // ElevatedButton(onPressed: ()  async {
          //   if (await _checkData(_textController.text)){
          //     _showD(context, 'Success');
          //   }else{_showD(context, 'Not Found');};
          // },
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //           (Set<MaterialState> states) {
          //         // if (states.contains(MaterialState.pressed)) {
          //         //   return colGreenButton.withOpacity(0.9);} else
          //         if (states.contains(MaterialState.disabled)) {
          //           return Colors.blueGrey;
          //         }
          //         return Colors.green; // Use the component's default.
          //       },
          //     ),
          //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(34.0),
          //       ),
          //     ),
          //   ),
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width,
          //       height: 75,
          //       child: Center(
          //         child: const Text('Check', style: TextStyle(fontSize: 30),
          //         ),
          //       ),
          //     ),
          // ),
          // const SizedBox(height: 30),
          // Row(
          //   children: [
          //     ElevatedButton(onPressed: (){
          //       _writeData(_textController.text);
          //     },
          //       style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //               (Set<MaterialState> states) {
          //             // if (states.contains(MaterialState.pressed)) {
          //             //   return colGreenButton.withOpacity(0.9);} else
          //             if (states.contains(MaterialState.disabled)) {
          //               return Colors.blueGrey;
          //             }
          //             return Colors.green; // Use the component's default.
          //           },
          //         ),
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //           RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(34.0),
          //           ),
          //         ),
          //       ),
          //
          //       child: SizedBox(
          //         //width: MediaQuery.of(context).size.width,
          //         height: 75,
          //         child: Center(
          //           child: const Text('write', style: TextStyle(fontSize: 30),
          //           ),
          //         ),
          //       ),
          //     ),
          //     ElevatedButton(onPressed: () {
          //       _readAllData(context);
          //     },
          //       style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //               (Set<MaterialState> states) {
          //             // if (states.contains(MaterialState.pressed)) {
          //             //   return colGreenButton.withOpacity(0.9);} else
          //             if (states.contains(MaterialState.disabled)) {
          //               return Colors.blueGrey;
          //             }
          //             return Colors.green; // Use the component's default.
          //           },
          //         ),
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //           RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(34.0),
          //           ),
          //         ),
          //       ),
          //
          //       child: SizedBox(
          //         //width: MediaQuery.of(context).size.width,
          //         height: 75,
          //         child: Center(
          //           child: const Text('read', style: TextStyle(fontSize: 30),
          //           ),
          //         ),
          //       ),
          //     ),
          //     ],
          //   ),
          //   const SizedBox(height: 30),
          // ],
          // ),
        ),
      ),
    );
  }

  _showD(BuildContext context, String value) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thanks!'),
          content:
              Text('$value,\nwhich has length ${value.characters.length}.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
