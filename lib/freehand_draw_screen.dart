import 'package:flutter/material.dart';

class FreehandDrawScreen extends StatefulWidget {
  const FreehandDrawScreen({Key? key}) : super(key: key);

  @override
  _FreehandDrawScreenState createState() => _FreehandDrawScreenState();
}

class _FreehandDrawScreenState extends State<FreehandDrawScreen> {
  List<Offset> points = <Offset>[];
  Color lineColor = Colors.blue[900]!; // Azul marinho
  Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desenho Livre'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                points.clear();
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            points.add(renderBox.globalToLocal(details.globalPosition));
          });
        },
        onPanEnd: (details) {
          points.add(Offset.infinite);
        },
        child: CustomPaint(
          painter: FreehandPainter(
            points: points,
            lineColor: lineColor,
            backgroundColor: backgroundColor,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class FreehandPainter extends CustomPainter {
  final List<Offset> points;
  final Color lineColor;
  final Color backgroundColor;

  FreehandPainter({
    required this.points,
    required this.lineColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = lineColor // Utiliza a cor definida para a linha
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.infinite && points[i + 1] != Offset.infinite) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(FreehandPainter oldDelegate) => true;
}
