// A full cross-platform example is available here: https://github.com/simolus3/drift/tree/develop/examples/app

import 'package:drift/drift.dart';
import 'package:drift_crdt/drift_crdt.dart';

QueryExecutor executorWithCrdt() {
  return CrdtQueryExecutor.inDatabaseFolder(path: 'app.db');
}
