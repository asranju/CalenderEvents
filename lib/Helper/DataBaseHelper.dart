import 'package:calenderevents/TableModel/Events.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Events(id INTEGER PRIMARY KEY AUTOINCREMENT,eventName  TEXT NOT NULL,eventDate TEXT NOT NULL,eventTime TEXT NOT NULL,eventType TEXT NOT NULL,eventRepeat TEXT NOT NULL,eventDescription TEXT NOT NULL,eventEndDate TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertEvents(List<Events> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('Events', user.toMap());
    }
    return result;
  }

  Future<List<Events>> retrieveEvents(String date) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from Events where eventDate=?', [date]);
    return queryResult.map((e) => Events.fromMap(e)).toList();
  }

  Future<List<Events>> retrieveAllData() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Events');
    return queryResult.map((e) => Events.fromMap(e)).toList();
  }
}
