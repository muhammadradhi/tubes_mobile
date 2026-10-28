class Transaction {
  final String id;
  final String title;
  final String date;
  final String tag;
  final double amount;
  final String type; // 'income' atau 'expense'
  final String? description;

  // PENTING: Ada kata 'const' di sini biar bisa dipake di list const
  const Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.tag,
    required this.amount,
    required this.type,
    this.description,
  });
}