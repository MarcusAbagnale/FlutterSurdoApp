import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechScreen extends StatefulWidget {
  const TextToSpeechScreen({Key? key}) : super(key: key);

  @override
  _TextToSpeechScreenState createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  final FlutterTts flutterTts = FlutterTts();
  TextEditingController textController = TextEditingController();
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _getAvailableVoices(); // Obtém e lista as vozes disponíveis ao iniciar
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _getAvailableVoices() async {
    final List<dynamic>? voices = await flutterTts.getVoices;
    if (voices != null && voices.isNotEmpty) {
      // Aqui, você pode ver as vozes disponíveis no dispositivo
      print('Vozes disponíveis:');
      for (var voice in voices) {
        print('Name: ${voice['name']}, Language: ${voice['language']}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Texto para Voz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Digite o texto a ser falado',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSpeaking ? null : _speak,
              child: Text(isSpeaking ? 'Falando...' : 'Falar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _speak() async {
    setState(() {
      isSpeaking = true;
    });

    await flutterTts.setLanguage('pt-BR');
    await flutterTts.setVoice({"name": "Neural2", "locale": "pt-BR"});

    await flutterTts.setPitch(0.8);
    await flutterTts.setSpeechRate(0.5);

    await flutterTts.speak(textController.text);

    setState(() {
      isSpeaking = false;
    });
  }
}
