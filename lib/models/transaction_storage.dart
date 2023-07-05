import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';
import 'package:your_app/models/transaction.dart';

class TransactionStorage {
  static const String _key = 'transactions';

  Future<List<Transaction>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson = prefs.getString(_key) ?? '[]';
    final transactions = (json.decode(transactionsJson) as List)
        .map((data) => Transaction.fromJson(data))
        .toList();
    return transactions;
  }

  Future<void> addTransaction(Transaction transaction) async {
    final prefs = await SharedPreferences.getInstance();
    final transactions = await getTransactions();
    transactions.add(transaction);
    final transactionsJson =
        json.encode(transactions.map((t) => t.toJson()).toList());
    await prefs.setString(_key, transactionsJson);
  }

  Future<void> deleteTransaction(Transaction transaction) async {
    final prefs = await SharedPreferences.getInstance();
    final transactions = await getTransactions();
    transactions.remove(transaction);
    final transactionsJson =
        json.encode(transactions.map((t) => t.toJson()).toList());
    await prefs.setString(_key, transactionsJson);
  }
}
