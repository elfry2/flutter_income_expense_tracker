import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../services/database_service.dart';
import 'edit_transaction_screen.dart';

class DetailScreen extends StatelessWidget {
  final TransactionModel transaction;
  final String userId;

  const DetailScreen({
    super.key,
    required this.transaction,
    required this.userId,
  });

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text('Are you sure you want to delete this record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx); // Close dialog
              await DatabaseService(userId: userId).deleteTransaction(transaction.id);
              if (context.mounted) {
                Navigator.pop(context); // Go back to List screen
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(transaction.date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTransactionScreen(
                    transaction: transaction,
                    userId: userId,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Amount: \$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22,
                color: transaction.type == 'income' ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 32),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Category'),
              subtitle: Text(transaction.category),
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: const Text('Type'),
              subtitle: Text(transaction.type.toUpperCase()),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Date & Time'),
              subtitle: Text(formattedDate),
            ),
          ],
        ),
      ),
    );
  }
}