import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../components/summary_card.dart';
import '../components/transaction_item.dart';
import '../components/expense_chart.dart';
import '../widgets/transaction_detail_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Transaction> _dummyTransactions = [
    Transaction(
      id: '1', 
      title: 'Bank BNI', 
      date: '18 Juli · 13.15', 
      tag: 'Sekut Bank', 
      amount: 25000, 
      type: 'expense',
      description: 'Transfer ke teman untuk makan siang', 
    ),
    Transaction(
      id: '2', 
      title: 'Makan Malam', 
      date: '18 Juli · 23.00', 
      tag: 'Manual', 
      amount: 15000, 
      type: 'expense',
      description: 'Beli seblak di depan kos', 
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Money Tracker', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1A2332))),
              const SizedBox(height: 4),
              const Text('Semua keuangan tercatat dengan jelas!', style: TextStyle(fontSize: 14, color: Color(0xFF8892A4))),
              const SizedBox(height: 24),

              const ExpenseChartCard(pemasukanPercent: 0.6, pengeluaranPercent: 0.4),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.arrow_downward,
                      iconColor: const Color(0xFF2ECC71),
                      label: 'Pemasukan',
                      amount: 'Rp 20.000.000',
                      amountColor: const Color(0xFF2ECC71),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.arrow_upward,
                      iconColor: const Color(0xFFE74C3C),
                      label: 'Pengeluaran',
                      amount: 'Rp 2.918.055',
                      amountColor: const Color(0xFFE74C3C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transaksi terbaru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A2332))),
                  Text('Lihat Semua', style: TextStyle(color: Color(0xFF8892A4), fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),

              ..._dummyTransactions.map((trx) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TransactionItem(
                    transaction: trx,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => TransactionDetailDialog(transaction: trx),
                      );
                    },
                  ),
                );
              }).toList(),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}