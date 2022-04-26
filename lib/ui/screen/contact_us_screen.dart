import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var html = '<!DOCTYPE html>   </html>';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(vertical: 55),
      child: WebView(
        initialUrl: Uri.dataFromString(html, mimeType: 'text/html').toString(),
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains('udemy')) {
            var para1 = Uri.parse(request.url);

            print('qdata: ' + para1.queryParameters.toString());

            //You can do anything

            //Prevent that url works
            return NavigationDecision.navigate;
          }
          //Any other url works
          return NavigationDecision.navigate;
        },
      ),
    ));
  }
}
