class Transaction {
  final String id;
  final String type;
  final String senderName;
  final String senderAccount;
  final String receiverName;
  final String receiverAccount;
  final double amount;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.type,
    required this.senderName,
    required this.senderAccount,
    required this.receiverName,
    required this.receiverAccount,
    required this.amount,
    required this.timestamp,
  });
}
