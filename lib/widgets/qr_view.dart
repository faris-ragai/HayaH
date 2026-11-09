import 'dart:math';
import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Placeholder QR picture drawn from the data string.
/// It looks like a QR code but is NOT scannable. Replace it with a real
/// QR package (for example qr_flutter) when you build the full version.
class QrView extends StatelessWidget {
  const QrView({super.key, required this.data, this.size = 190});

  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _QrPainter(data));
  }
}

class _QrPainter extends CustomPainter {
  _QrPainter(this.data);

  final String data;
  static const int n = 25;

  @override
  void paint(Canvas canvas, Size size) {
    final seed = data.codeUnits.fold<int>(7, (a, b) => (a * 31 + b) & 0x7fffffff);
    final rnd = Random(seed);
    final grid = List.generate(n, (_) => List.generate(n, (_) => rnd.nextBool()));

    void finder(int ox, int oy) {
      for (var y = -1; y <= 7; y++) {
        for (var x = -1; x <= 7; x++) {
          final gx = ox + x, gy = oy + y;
          if (gx < 0 || gy < 0 || gx >= n || gy >= n) continue;
          if (x == -1 || x == 7 || y == -1 || y == 7) {
            grid[gy][gx] = false;
          } else if (x == 0 || x == 6 || y == 0 || y == 6 ||
              (x >= 2 && x <= 4 && y >= 2 && y <= 4)) {
            grid[gy][gx] = true;
          } else {
            grid[gy][gx] = false;
          }
        }
      }
    }

    finder(0, 0);
    finder(n - 7, 0);
    finder(0, n - 7);

    final cell = size.width / n;
    final paint = Paint()..color = AppColors.ink;
    for (var y = 0; y < n; y++) {
      for (var x = 0; x < n; x++) {
        if (grid[y][x]) {
          canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell + 0.5, cell + 0.5), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _QrPainter old) => old.data != data;
}
