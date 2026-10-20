import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';

class DatabaseService {
  final String userId;

  DatabaseService({required this.userId});

  CollectionReference get _collection => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('transactions');

  // CREATE
  Future<void> addTransaction(TransactionModel tx) async {
    await _collection.add(tx.toMap());
  }

  // READ (Stream of all transactions)
  Stream<List<TransactionModel>> getTransactions() {
    return _collection
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => TransactionModel.fromFirestore(doc)).toList());
  }

  // UPDATE
  Future<void> updateTransaction(TransactionModel tx) async {
    await _collection.doc(tx.id).update(tx.toMap());
  }

  // DELETE
  Future<void> deleteTransaction(String id) async {
    await _collection.doc(id).delete();
  }
}