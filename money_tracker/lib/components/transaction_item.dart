import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionItem({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type == 'expense';
    final amountColor = isExpense ? const Color(0xFFE74C3C) : const Color(0xFF2ECC71);
    final iconBgColor = isExpense ? const Color(0xFFFDE8E8) : const Color(0xFFE8F8F0);
    final iconData = isExpense ? Icons.arrow_upward : Icons.arrow_downward;

    final formattedAmount = transaction.amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    final displayAmount = '${isExpense ? '- ' : '+ '}Rp $formattedAmount';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(12)),
              child: Icon(iconData, color: amountColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1A2332))),
                  const SizedBox(height: 2),
                  Text(transaction.date, style: const TextStyle(fontSize: 12, color: Color(0xFF8892A4))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFE8EDF5), borderRadius: BorderRadius.circular(8)),
                  child: Text(transaction.tag, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1A2332))),
                ),
                const SizedBox(height: 6),
                Text(displayAmount, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: amountColor)),
                const SizedBox(height: 4),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Lihat detail', style: TextStyle(fontSize: 11, color: Color(0xFF8892A4))),
                    Icon(Icons.chevron_right, size: 16, color: Color(0xFF8892A4)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}