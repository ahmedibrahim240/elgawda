import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentMethod extends StatefulWidget {
  final String url;

  const PaymentMethod({Key key, this.url}) : super(key: key);
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      withJavascript: true,
      supportMultipleWindows: true,
      withLocalStorage: true,
      allowFileURLs: true,
      enableAppScheme: true,
      appCacheEnabled: true,
      hidden: false,
      scrollBar: true,
      geolocationEnabled: false,
      clearCookies: true,
    );
  }
}
