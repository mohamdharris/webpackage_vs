import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewView extends StatelessWidget {
   WebViewView({Key? key}) : super(key: key);
late  WebViewPlusController controller;

///provide the Controller pLease
  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
           
                Container(
                height: MediaQuery.of(context).size.height*0.90,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: WebViewPlus(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: 'assets/index.html',
                      onWebViewCreated: (controller) {
                      this.controller = controller;
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
                                      style:const TextStyle(fontSize: 14)),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("OKAY"))
                                  ]));
                      controller.webViewController.evaluateJavascript('ok()');
                    })
          }),
    ),
              ],
            );
  }
}

// library webpackage_vs;
// export 'package:webview_flutter_plus/webview_flutter_plus.dart';
// export 'package:webpackage_vs/src/webview_view.dart';

