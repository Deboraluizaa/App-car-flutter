import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/mileage_record.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mileage_records.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE mileage_records('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'mileage TEXT, '
          'driver TEXT, '
          'destination TEXT, '
          'photoPath TEXT)',
        );
      },
    );
  }

  Future<int> insertRecord(MileageRecord record) async {
    final db = await database;
    return await db.insert('mileage_records', record.toMap());
  }

  Future<List<MileageRecord>> getRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('mileage_records');
    return List.generate(maps.length, (i) {
      return MileageRecord.fromMap(maps[i]);
    });
  }

  Future<void> deleteRecord(int id) async {
    final db = await database;
    await db.delete(
      'mileage_records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

