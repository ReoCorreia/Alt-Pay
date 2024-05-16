class TransactionFilter {

  static void filterTransactionsByAmount(Map<String, dynamic> transactions, double minAmount, double maxAmount) {
    transactions['data'] = transactions['data'].where((transaction) {
      double amount = transaction['amount_recipient_country'];
      return amount >= minAmount && amount <= maxAmount;
    }).toList();
  }

}
