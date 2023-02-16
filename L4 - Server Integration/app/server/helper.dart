import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/transfer.dart';

const String _url = "http://10.0.2.2:8090/transactions";

class ServerHelper {

  static Future<List<Transaction>> getAllTransactions() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      List<Transaction> transactions = [];
      List<dynamic> tags = jsonDecode(response.body);
      for (int i = 0; i < tags.length; i++) {
        transactions.add(Transaction.fromJson(tags[i]));
      }
      return transactions;
    } else {
      throw Exception("Failed to load Transactions");
    }
  }

  static Future<Transaction> addTransaction(Transaction t) async {
    final response = await http.post(Uri.parse(_url),
        headers: {"content-type": "application/json"},
        body: jsonEncode(t.toJson()));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add Transaction");
    }
  }

  static Future<Transaction> deleteTransaction(int id) async {
    final response = await http.delete(Uri.parse("$_url/$id"));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to delete Transaction");
    }
  }

  static Future<int> updateTransaction(Transaction t) async {
    final response = await http.put(Uri.parse("$_url/${t.id}"),
        headers: {"content-type": "application/json"},
        body: jsonEncode(t.toJson()));

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to update Transaction");
    }
  }
}