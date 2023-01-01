import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:task_management_app/model/task_category_model.dart';

class SqfLiteHelper {
  static const dbName = 'tasks.db';
  static const tableNameTaskCategory = 't_tasks';
  static const int version = 1;

  static const String createTableTask = '''
  CREATE TABLE IF NOT EXISTS $tableNameTaskCategory (
  $kTaskId INTEGER PRIMARY KEY AUTOINCREMENT,
  $kCategoryTitle TEXT NOT NULL,
  $kColor INTEGER NOT NULL,
  $kIconCodePoint INTEGER NOT NULL,
  $kIconFontFamily TEXT,
  $kIconFontPackage TEXT,
  $kHasTextDirectionMatched INTEGER)
  ''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = p.join(rootPath, dbName);
    return openDatabase(
      dbPath,
      version: version,
      onCreate: (db, version) async{
        await db.execute(createTableTask);
      },
      onUpgrade: (db, oldVersion, newVersion) {

      },

      onConfigure: (db) {
        //to enable foreign key
        db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  }

  static Future<int> insertTaskCategory(TaskCategoryModel task) async{
    final db = await open();
    return await db.insert(tableNameTaskCategory, task.toMap());
  }

  static Future<List<TaskCategoryModel>> getAllTaskCategoryList() async{
    final db = await open();
    final allData = await db.query(tableNameTaskCategory,);
    final List<TaskCategoryModel> tList = [];
    for (var category in allData) {
      final c = TaskCategoryModel.fromMap(category);
      tList.add(c);
    }
    return tList;
  }
}
