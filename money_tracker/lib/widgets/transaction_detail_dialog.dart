import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionDetailDialog extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailDialog({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type == 'expense';
    final amountColor = isExpense ? const Color(0xFFE74C3C) : const Color(0xFF2ECC71);
    
    final formattedAmount = transaction.amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    final displayAmount = '${isExpense ? '- ' : '+ '}Rp $formattedAmount';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    transaction.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2332)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            
            _buildDetailRow('Tanggal', transaction.date),
            _buildDetailRow('Kategori / Tag', transaction.tag),
            _buildDetailRow(
              'Nominal', 
              displayAmount, 
              isAmount: true, 
              amountColor: amountColor,
            ),
            
            if (transaction.description != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Deskripsi', 
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1A2332)),
              ),
              const SizedBox(height: 6),
              Text(
                transaction.description!, 
                style: const TextStyle(color: Color(0xFF8892A4), height: 1.4),
              ),
            ],
            
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Tutup', 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isAmount = false, Color? amountColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF8892A4), fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 15, 
              fontWeight: FontWeight.w600, 
              color: isAmount ? amountColor : const Color(0xFF1A2332),
            ),
          ),
        ],
      ),
    );
  }
}