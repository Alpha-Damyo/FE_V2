import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class SmokeDatabase {
  static final SmokeDatabase _instance = SmokeDatabase._internal();
  factory SmokeDatabase() => _instance;
  SmokeDatabase._internal();

  static Database? _database;

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH').format(dateTime);
  }

  static String formatWeekday(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'smokeInfo_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE smokeInfo ('
        'autoId INTEGER PRIMARY KEY AUTOINCREMENT, '
        'id TEXT, '
        'name TEXT, '
        'date TEXT, '
        'weekday TEXT, '
        'time INTEGER)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS smokeInfo');
      await _onCreate(db, newVersion);
    }
  }

  Future<void> insertSmokeInfo(
      String id, String name, DateTime dateInfo) async {
    String date = formatDate(dateInfo);
    int time = int.parse(formatTime(dateInfo));
    String weekday = formatWeekday(dateInfo);

    final db = await database;

    await db.insert(
      'smokeInfo',
      {'id': id, 'name': name, 'date': date, 'weekday': weekday, 'time': time},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getSmokeInfo() async {
    final db = await database;
    return await db.query('smokeInfo');
  }

  Future<List<Map<String, dynamic>>> getSmokeInfoGroupedByColumn(
      String column) async {
    final db = await database;
    return await db.rawQuery(
      'SELECT $column, name, COUNT($column) as count FROM smokeInfo GROUP BY $column HAVING COUNT($column) > 0 ORDER BY COUNT($column) DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getSmokeInfoGroupedByColumnNOName(
      String column) async {
    final db = await database;
    return await db.rawQuery(
      'SELECT $column, COUNT($column) as count FROM smokeInfo GROUP BY $column HAVING COUNT($column) > 1',
    );
  }

  Future<List<Map<String, dynamic>>> getSmokeInfoInWeekDayRange(
      DateTime startDate, DateTime endDate) async {
    final db = await database;
    final startDateString = formatDate(startDate);
    final endDateString = formatDate(endDate);

    return await db.rawQuery(
      'SELECT weekday, COUNT(weekday) as count FROM smokeInfo WHERE date BETWEEN ? AND ? GROUP BY weekday',
      [startDateString, endDateString],
    );
  }

  Future<List<Map<String, dynamic>>> getSmokeInfoInWeeksRange(
      DateTime startDate, DateTime endDate) async {
    final db = await database;
    final startDateString = formatDate(startDate);
    final endDateString = formatDate(endDate);

    return await db.rawQuery(
      'SELECT COUNT(*) as count FROM smokeInfo WHERE date BETWEEN ? AND ? ',
      [startDateString, endDateString],
    );
  }

  Future<Map<String, double>> getThreeHourlyAverages() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
      SELECT 
        CASE 
          WHEN time >= 0 AND time < 3 THEN '3'
          WHEN time >= 3 AND time < 6 THEN '6'
          WHEN time >= 6 AND time < 9 THEN '9'
          WHEN time >= 9 AND time < 12 THEN '12'
          WHEN time >= 12 AND time < 15 THEN '15'
          WHEN time >= 15 AND time < 18 THEN '18'
          WHEN time >= 18 AND time < 21 THEN '21'
          WHEN time >= 21 AND time < 24 THEN '24'
        END as time_range,
        AVG(count) as avg_count
      FROM (
        SELECT date, time, COUNT(*) as count 
        FROM smokeInfo 
        GROUP BY date, time
      ) 
      GROUP BY time_range
      ORDER BY time
      '''
    );

    Map<String, double> threeHourlyAverages = {};
    for (var row in result) {
      threeHourlyAverages[row['time_range']] = row['avg_count'];
    }
    return threeHourlyAverages;
  }

}
