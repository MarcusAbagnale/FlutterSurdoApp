import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceRecognitionScreen extends StatefulWidget {
  const VoiceRecognitionScreen({Key? key}) : super(key: key);

  @override
  _VoiceRecognitionScreenState createState() => _VoiceRecognitionScreenState();
}

class _VoiceRecognitionScreenState extends State<VoiceRecognitionScreen> {
  TextEditingController urlController = TextEditingController();
  late WebViewController webViewController;
  String initialUrl = 'https://inova-edu.com/palavravisual/imagem.php?ean=';
  stt.SpeechToText speech = stt.SpeechToText();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voz para Texto e Imagem'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: urlController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Digite ou grave sua voz',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: _loadWebView,
                    child: const Text('Ver'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: _startListening,
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildWebView(),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return WebView(
      initialUrl: initialUrl,
      onWebViewCreated: (WebViewController controller) {
        webViewController = controller;
      },
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  void _loadWebView() {
    setState(() {
      initialUrl =
          'https://inova-edu.com/palavravisual/imagem.php?ean=${Uri.encodeQueryComponent(urlController.text)}';
    });
    webViewController.loadUrl(initialUrl);
  }

  void _startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize(
        onStatus: (status) {
          if (status == stt.SpeechToText.listeningStatus) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.mic),
                    SizedBox(width: 8),
                    Text('Gravando...'),
                  ],
                ),
                duration: Duration(seconds: 30),
              ),
            );
          } else if (status == stt.SpeechToText.notListeningStatus) {
            setState(() {
              urlController.text = speech.lastRecognizedWords ?? '';
              _loadWebView();
            });

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
      );

      if (available) {
        speech.listen(
          onResult: (result) {
            setState(() {
              urlController.text = result.recognizedWords;
              _loadWebView();
            });
          },
        );
      } else {
        print('Reconhecimento de fala não disponível');
      }
    } else {
      speech.stop();
    }
  }
}
