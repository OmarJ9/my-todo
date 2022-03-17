import 'package:flutter/cupertino.dart';

class MycustomPainter extends CustomPainter {
  final Color color;

  const MycustomPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 5
      ..color = color;

    final path = Path();

    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width * 0.1, size.height - 50, size.width * .5, size.height - 90);

    path.quadraticBezierTo(size.width - (size.width * 0.1), size.height - 35,
        size.width, size.height - 100);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);

    const circleRadius = 55.0;
    var circleCenter = Offset(size.width * .5, size.height - 80);

    canvas.drawCircle(circleCenter, circleRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
