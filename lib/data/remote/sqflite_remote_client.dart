import 'package:my_todo_app/data/remote/base_remote_client.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteRemoteClient extends BaseRemoteClient {
  late Database? db;

  @override
  Future<void> initializeDatabase() async {
    db = await openDatabase('saurabh.pepperCloud.db', version: 1,
        onCreate: (Database db, int version) async {
      await createTables(db);
    });

    print("Remote initialized");
  }

  @override
  Future<int> add(String table, Map<String, dynamic> data) async {
    return db!
        .insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return db!.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
    );
  }

  @override
  Future<int> update(String table, Map<String, dynamic> data,
      {String? where, List<Object>? whereArgs}) async {
    return db!.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> rawQuery(String rawQuery,
      [List<Object?>? arguments]) async {
    return db!.rawQuery(rawQuery, arguments);
  }

  @override
  Future<int> delete(String table,
      {String? where, List<Object>? whereArgs}) async {
    return db!.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<void> createTables(Database database) async {
    await database.execute("DROP TABLE IF EXISTS todo_list");
    await database.execute("""CREATE TABLE todo_list(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        desc TEXT, 
        status TEXT,
        dueDate TIMESTAMP NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
}
