// Step 1: Define abstract base class for remote client
abstract class BaseRemoteClient {
  Future<void> initializeDatabase();
  Future<int> add(String table, Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> getAll(String table);
  Future<int> update(String table, Map<String, dynamic> data,
      {String? where, List<Object>? whereArgs});
  Future<int> delete(String table, {String? where, List<Object>? whereArgs});
}
