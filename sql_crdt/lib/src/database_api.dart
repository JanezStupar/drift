abstract class DatabaseApi {
  /// Executes a SQL query with optional [args].
  /// Use "?" placeholders for parameters to avoid injection vulnerabilities:
  ///
  /// ```
  /// await crdt.execute(
  ///   'INSERT INTO users (id, name) Values (?1, ?2)', [1, 'John Doe']);
  /// ```
  Future<void> execute(String sql, [List<Object?>? args]);

  /// Performs a SQL query with optional [args] and returns the result as a list
  /// of column maps.
  /// Use "?" placeholders for parameters to avoid injection vulnerabilities:
  ///
  /// ```
  /// final result = await crdt.query(
  ///   'SELECT id, name FROM users WHERE id = ?1', [1]);
  /// print(result.isEmpty ? 'User not found' : result.first['name']);
  /// ```
  Future<List<Map<String, Object?>>> query(String sql, [List<Object?>? args]);

  /// Returns all user-created tables in the current database.
  Future<Iterable<String>> getTables();

  /// Returns all the primary key columns in the given table.
  Future<Iterable<String>> getPrimaryKeys(String table);

  /// Initiates a transaction in this database.
  /// Caution: calls to the parent crdt inside a transaction block will result
  /// in a deadlock.
  ///
  /// ```
  /// await database.transaction((txn) async {
  ///   // OK
  ///   await txn.execute('SELECT * FROM users');
  ///
  ///   // NOT OK: calls to the parent crdt in a transaction
  ///   // The following code will deadlock
  ///   await crdt.execute('SELECT * FROM users');
  /// });
  Future<void> transaction(Future<void> Function(DatabaseApi txn) action);

  // TODO: add comments
  Future<List<Map<String, Object?>>> rawQuery(String sql, [List<Object?>? arguments]);

  Future<int> rawInsert(String sql, [List<Object?>? arguments]);

  Future<int> rawUpdate(String sql, [List<Object?>? arguments]);

  Future<int> rawDelete(String sql, [List<Object?>? arguments]);

  //  TODO: Check why the sqlite says that database cannot be closed anymore
  Future<void> close();
}
