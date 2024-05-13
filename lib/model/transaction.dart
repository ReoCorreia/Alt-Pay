    // {
    //   "id": 2,
    //   "user_id": 43,
    //   "user_bank_id": 11,
    //   "transaction_id": "aee6b369-fda5-4d0c-a83d-5ea91006770a",
    //   "origination_country_id": 1,
    //   "recipient_country_id": 7,
    //   "transaction_type": "DEBIT",
    //   "amount_origination_country": 0.9278,
    //   "amount_recipient_country": 300,
    //   "conversion_rate_applied": 323.35,
    //   "transaction_date": "2024-05-13T11:56:41",
    //   "transaction_status": "INITIATED",
    //   "settlement_date": null,
    //   "settlement_status": null,
    //   "settlement_id": null,
    //   "settlement_partner_id": null,
    //   "created_by": "admin",
    //   "created_date": "2024-05-13T11:56:41",
    //   "modified_by": null,
    //   "modified_date": null
    // }
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
