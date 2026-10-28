import 'package:flutter/material.dart';

class ExpenseChartCard extends StatelessWidget {
  final double pemasukanPercent;
  final double pengeluaranPercent;

  const ExpenseChartCard({
    super.key,
    required this.pemasukanPercent,
    required this.pengeluaranPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengeluaran Bulan Ini',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A2332)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: CustomPaint(
                  painter: _DonutChartPainter(
                    pemasukanPercent: pemasukanPercent,
                    pengeluaranPercent: pengeluaranPercent,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(color: const Color(0xFF2ECC71), label: 'Pemasukan', value: '${(pemasukanPercent * 100).toInt()}%'),
                    const SizedBox(height: 16),
                    _buildLegendItem(color: const Color(0xFFE74C3C), label: 'Pengeluaran', value: '${(pengeluaranPercent * 100).toInt()}%'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({required Color color, required String label, required String value}) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF1A2332)))),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2332))),
      ],
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final double pemasukanPercent;
  final double pengeluaranPercent;

  _DonutChartPainter({required this.pemasukanPercent, required this.pengeluaranPercent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 20.0;

    final pemasukanPaint = Paint()
      ..color = const Color(0xFF2ECC71)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final pemasukanSweep = 2 * 3.14159 * pemasukanPercent;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - strokeWidth / 2), -3.14159 / 2, pemasukanSweep, false, pemasukanPaint);

    final pengeluaranPaint = Paint()
      ..color = const Color(0xFFE74C3C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final pengeluaranSweep = 2 * 3.14159 * pengeluaranPercent;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - strokeWidth / 2), -3.14159 / 2 + pemasukanSweep, pengeluaranSweep, false, pengeluaranPaint);
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.pemasukanPercent != pemasukanPercent || oldDelegate.pengeluaranPercent != pengeluaranPercent;
  }
}