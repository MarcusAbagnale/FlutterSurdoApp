import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const FreehandDrawScreen());
}

class FreehandDrawScreen extends StatefulWidget {
  const FreehandDrawScreen({Key? key}) : super(key: key);

  @override
  State<FreehandDrawScreen> createState() => _FreehandDrawScreenState();
}

class _FreehandDrawScreenState extends State<FreehandDrawScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Desenho Livre')),
        body: const WebViewExample(),
      ),
    );
  }
}

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key}) : super(key: key);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
          url: Uri.parse('https://inova-edu.com/palavravisual/paint.php')),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          transparentBackground: true,
        ),
      ),
    );
  }
}
