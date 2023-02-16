import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../model/health.dart';

class DbHelper {
  static const int _version = 1;
  static const String _dbName = 'noets.db';
  static Logger logger = Logger();

  static Future<Database> _getDb() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, _dbName);
    return await openDatabase(path, version: _version,
        onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE notes('
            'id INTEGER PRIMARY KEY,'
            'date TEXT,'
            'symptom TEXT,'
            'medication TEXT,'
            'dosage TEXT,'
            'doctor TEXT,'
            'notes TEXT)'
      );
      await db.execute(
        'CREATE TABLE days('
            'id INTEGER PRIMARY KEY,'
            'name TEXT)'
      );
        });
  }

  static Future<List<String>> getDates() async {
    final db = await _getDb();
    final res = await db.query('days');
    logger.log(Level.info, "getDays - DB Call: $res");
    return res.map((e) => e['name'].toString()).toList();
  }

  static Future<List<HealthNote>> getNotes() async {
    final db = await _getDb();
    final res = await db.query('notes');
    logger.log(Level.info, "getNotes - DB Call: $res");
    return res.map((e) => HealthNote.fromJson(e)).toList();
  }

  static Future<List<HealthNote>> getNotesByDate(String date) async {
    final db = await _getDb();
    final res = await db.query('notes', where: 'date = ?', whereArgs: [date]);
    logger.log(Level.info, "getNotesByDate - DB Call: $res");
    return res.map((e) => HealthNote.fromJson(e)).toList();
  }

  static Future<int> deleteNote(int id) async {
    final db = await _getDb();
    final res = await db.delete('notes', where: 'id=?', whereArgs: [id]);
    logger.log(Level.info, "deleteNote - DB Call: $res");
    return res;
  }

  static Future<HealthNote> addHealthNote(HealthNote hn) async {
    final db = await _getDb();
    final id = await db.insert('notes', hn.toJsonNoId(), conflictAlgorithm: ConflictAlgorithm.replace);
    logger.log(Level.info, "addTip: $id");
    return hn.copy(id: id);
  }

  static Future<int> updateTipDifficulty(int id, String difficulty) async {
    final db = await _getDb();
    final res = await db.update('notes', {'difficulty': difficulty}, where: 'id=?', whereArgs: [id]);
    logger.log(Level.info, "updateTipDifficulty: $res");
    return res;
  }

  static Future<void> updateDates(List<String> dates) async {
    final db = await _getDb();
    await db.delete('days');
    for (var i = 0; i <dates.length; i++){
      await db.insert('days', {'name':dates[i]});
    }
    logger.log(Level.info, "updateDates - DB Call: $dates");
  }

  static Future<void> updateDateNotes(String date, List<HealthNote> hns) async {
    final db = await _getDb();
    await db.delete('notes', where: 'date=?', whereArgs: [date]);
    for (var i = 0; i < hns.length; i++){
      await db.insert('notes', hns[i].toJsonNoId());
    }
    logger.log(Level.info, "updateDateNotes - DB Call: $date, $hns");
  }

  static Future<void> close() async {
    final db = await _getDb();
    await db.close();
  }
}