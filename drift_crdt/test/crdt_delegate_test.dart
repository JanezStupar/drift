import 'dart:io';

import 'package:drift_crdt/drift_crdt.dart';
import 'package:drift_testcases/tests.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' show getDatabasesPath;

class CrdtExecutor extends TestExecutor {
  @override
  bool get supportsNestedTransactions => true;

  @override
  DatabaseConnection createConnection() {
    return DatabaseConnection(
      CrdtQueryExecutor.inDatabaseFolder(
        path: 'app.db',
        singleInstance: false,
      ),
    );
  }

  @override
  Future deleteData() async {
    final folder = await getDatabasesPath();
    final file = File(join(folder, 'app.db'));

    if (await file.exists()) {
      await file.delete();
    }
  }
}

Future<void> main() async {
  runAllTests(CrdtExecutor());
}

class EmptyDb extends GeneratedDatabase {
  EmptyDb(QueryExecutor q) : super(q);
  @override
  final List<TableInfo> allTables = const [];
  @override
  final schemaVersion = 1;
}
