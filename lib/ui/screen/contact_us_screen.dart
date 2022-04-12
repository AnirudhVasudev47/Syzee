import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    print('${AssetConstants.mockWebLink}/twak.php');
    return const Scaffold(
      body: WebView(
        initialUrl: '${AssetConstants.mockWebLink}/twak.php',
      )
    );
  }
}
