import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({Key? key, required this.targetUrl}) : super(key: key);
  final String targetUrl;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  // final WebViewController _controller = WebViewController()
  //    ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //    ..setBackgroundColor(Colors.green)
  //    ..setNavigationDelegate(
  //      NavigationDelegate(
  //        onProgress: (int progress) {
  //          // Update loading bar.
  //        },
  //        onPageStarted: (String url) {},
  //        onPageFinished: (String url) {},
  //        onWebResourceError: (WebResourceError error) {},
  //        onNavigationRequest: (NavigationRequest request) {
  //          if (request.url.startsWith('https://www.youtube.com/')) {
  //            return NavigationDecision.prevent;
  //          }
  //          return NavigationDecision.navigate;
  //        },
  //      ),
  //    );

  @override
  void initState() {
    super.initState();
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.green)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    _controller.loadRequest(Uri.parse(widget.targetUrl));
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          print('задняя c хрустом');
        } else {
          print('cписок пуст');
        }
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
