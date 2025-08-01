import 'package:drift/drift.dart';

class UserProfileTable extends Table {
  TextColumn get id => text()();

  TextColumn get email => text()();

  TextColumn get name => text()();

  TextColumn get avatar => text()();

  @override
  Set<Column> get primaryKey => {id};
}
