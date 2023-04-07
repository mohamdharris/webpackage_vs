import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:flutter/services.dart';

class WebViewView extends StatefulWidget {
  WebViewView({Key? key}) : super(key: key);

  @override
  State<WebViewView> createState() => _WebViewViewState();
}

class _WebViewViewState extends State<WebViewView> {
  late WebViewPlusController controller;

  @override
  void initState() {
    print("init called");
    // TODO: implement initState
    super.initState();
    loadAsset();
  }

  Future<void> loadAsset() async {
    final assetData = await rootBundle.load('assets/index.html');
    final assetData1 = await rootBundle.load('assets/bg.jpg');
    final assetData2 = await rootBundle.load('assets/catalog.json');
    final assetData3 = await rootBundle.load('assets/scripts.js');
    final assetData4 = await rootBundle.load('assets/style.css');
    // Do something with the asset data
    print("asserts loading from load Asset");
  }

  ///provide the Controller pLease
  @override
  Widget build(BuildContext context) {
    return WebViewPlus(
        onProgress: (progress) {
          print("package Called ");
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'http://ec2-34-217-173-110.us-west-2.compute.amazonaws.com/flutter/webview',
        onWebViewCreated: (controller) {
          this.controller = controller;
          // loadAsset();
        },
        javascriptChannels: {
          JavascriptChannel(
              name: 'JavascriptChannel',
              onMessageReceived: (message) async {
                Map<String, dynamic> data = jsonDecode(message.message);
                var obj = json.encode(message.message);
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            content: Text(data['request'],
                                style: const TextStyle(fontSize: 14)),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OKAY"))
                            ]));
                controller.webViewController.evaluateJavascript('ok()');
              })
        });
  }
}

// library webpackage_vs;
// export 'package:webview_flutter_plus/webview_flutter_plus.dart';
// export 'package:webpackage_vs/src/webview_view.dart';

