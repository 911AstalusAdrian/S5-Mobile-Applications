import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/transfer.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _name = "Transfers.db";
  static const String _createQuery = ""
      "CREATE TABLE Transfers("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "title TEXT NOT NULL,"
      "desc TEXT NOT NULL,"
      "type TEXT NOT NULL,"
      "category TEXT NOT NULL,"
      "sum INTEGER,"
      "date TEXT NOT NULL)";

  static Future<Database> getDb() async {
    return openDatabase(join(await getDatabasesPath(), _name),
        onCreate: (db, version) async => await db.execute(_createQuery),
        version: _version);
  }

  static Future<int> addTransfer(Transfer tran) async {
    final database = await getDb();
    return await database.insert("Transfers", tran.toJson());
  }

  static Future<int> updateTransfer(Transfer tran) async {
    final database = await getDb();
    return await database.update("Transfers", tran.toJson(),
        where: 'id = ?',
        whereArgs: [tran.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTransfer(int id) async {
    final database = await getDb();
    return await database
        .delete("Transfers", where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Transfer>?> getAllTransfers() async {
    final database = await getDb();

    final List<Map<String, dynamic>> maps = await database.query("Transfers");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => Transfer.fromJson(maps[index]));
  }
}
