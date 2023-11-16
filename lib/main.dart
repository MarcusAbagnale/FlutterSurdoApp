import 'package:flutter/material.dart';
import 'voice_recognition_screen.dart';
import 'text_to_speech_screen.dart';
import 'freehand_draw_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch:
            Colors.green, // Esta é a cor principal do seu aplicativo.
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      // Lógica para impedir a troca de tela por gestos
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.mic)),
            Tab(icon: Icon(Icons.volume_down_alt)),
            Tab(icon: Icon(Icons.draw)),
          ],
        ),
        title: const Text('Surdo App - Comunicação'),
      ),
      body: TabBarView(
        controller: _tabController,
        physics:
            const NeverScrollableScrollPhysics(), // Impede a troca de tela por gestos
        children: [
          VoiceRecognitionScreen(),
          TextToSpeechScreen(),
          FreehandDrawScreen(),
        ],
      ),
    );
  }
}
