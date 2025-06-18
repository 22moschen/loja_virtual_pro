import 'package:flutter/material.dart';

class WaveBackground extends StatelessWidget {
  final Widget child;

  const WaveBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fundo com efeito de onda e gradiente elegante
        Positioned.fill(
          child: CustomPaint(
            painter: _WavePainter(),
          ),
        ),
        // Conteúdo da tela
        child,
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Gradiente linear elegante
    final Gradient gradient = LinearGradient(
      colors: [
        
        Color.fromARGB(255, 248, 250, 247), // Azul médio
        Color.fromARGB(255, 121, 210, 233), // Azul quase preto
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final Paint paint = Paint()..shader = gradient.createShader(rect);

    final Path path = Path();

    // Desenha uma forma de onda suave na parte inferior
    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.85,
      size.width * 0.5,
      size.height * 0.75,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.65,
      size.width,
      size.height * 0.75,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
