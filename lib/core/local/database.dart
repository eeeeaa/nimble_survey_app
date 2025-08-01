import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:nimble_survey_app/core/local/table/survey_list_table.dart';
import 'package:nimble_survey_app/core/local/table/user_profile_table.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [SurveyListTable, UserProfileTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'app_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
