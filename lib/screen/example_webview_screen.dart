//import 'package:aviator_game/services/save_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image_picker/image_picker.dart';

class AviatScreen extends StatefulWidget {
  String save;
  AviatScreen({Key? key, required this.save}) : super(key: key);

  @override
  State<AviatScreen> createState() => _AviatScreenState();
}

class _AviatScreenState extends State<AviatScreen> {
  late InAppWebViewController _webViewController;
  double progress = 0;



  Future<bool> onBackPressed() async {
    _webViewController.goBack();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: onBackPressed,
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.save)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    androidOnPermissionRequest:
                        (InAppWebViewController controller, String origin,
                        List<String> resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    onLoadStart:(controller, url) async{
                      //final ImagePicker picker = ImagePicker();
                      // Pick an image.
                      //final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
                      //final XFile? photo = await picker.pickImage(source: ImageSource.camera);


                      // String local = await SaveServices.saveSet('load');
                      // if(local.isEmpty){
                      //   SaveServices.saveGet('load', url.toString());
                      // }
                    },
                    onProgressChanged: (controller, progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                  progress < 1.0
                      ? Center(
                      child: CircularProgressIndicator(color: Color.fromARGB(255, 64, 16, 71),)
                  )
                      : Container(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}