import 'package:drift/drift.dart';

class SurveyListTable extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  TextColumn get coverImageUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}
