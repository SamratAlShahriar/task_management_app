import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:task_management_app/model/task_category_model.dart';
import 'package:task_management_app/model/task_model.dart';

class SqfLiteHelper {
  static const dbName = 'tasks.db';
  static const tableNameTaskCategory = 't_category';
  static const tableNameTasks = 't_tasks';
  static const int version = 1;

  static const String createTableTaskCategory = '''
  CREATE TABLE IF NOT EXISTS $tableNameTaskCategory (
  $kTaskCatId INTEGER PRIMARY KEY AUTOINCREMENT,
  $kCategoryTitle TEXT NOT NULL,
  $kColor INTEGER NOT NULL,
  $kIconCodePoint INTEGER NOT NULL,
  $kIconFontFamily TEXT,
  $kIconFontPackage TEXT,
  $kHasTextDirectionMatched INTEGER);
  ''';

  static const String createTableTask = '''
  CREATE TABLE IF NOT EXISTS $tableNameTasks (
  $kTaskId INTEGER PRIMARY KEY AUTOINCREMENT,
  $kTaskTitle TEXT NOT NULL,
  $kTaskDate TEXT NOT NULL,
  $kTaskStartTime TEXT NOT NULL,
  $kTaskEndTime TEXT NOT NULL,
  $kTaskDescription TEXT,
  $kIsDone INTEGER NOT NULL,
  $kTaskCatRefId INTEGER,
  FOREIGN KEY ($kTaskCatRefId) REFERENCES $tableNameTaskCategory($kTaskCatId)
  )
  ''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = p.join(rootPath, dbName);
    return openDatabase(
      dbPath,
      version: version,
      onCreate: (db, version) async {
        await db.execute(createTableTaskCategory);
        await db.execute(createTableTask);
      },
      onUpgrade: (db, oldVersion, newVersion) async {},
      onConfigure: (db) {
        //to enable foreign key
        db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  }

  static Future<int> insertTaskCategory(TaskCategoryModel task) async {
    final db = await open();
    return await db.insert(tableNameTaskCategory, task.toMap()).then((value) {
      db.close();
      return value;
    });
  }

  static Future<List<TaskCategoryModel>> getAllTaskCategoryList() async {
    final db = await open();
    final allData = await db
        .query(
      tableNameTaskCategory,
    )
        .then((value) {
      db.close();
      return value;
    });
    final List<TaskCategoryModel> tList = [];
    for (var category in allData) {
      final c = TaskCategoryModel.fromMap(category);
      tList.add(c);
    }
    return tList;
  }

  static Future<TaskCategoryModel?> getTaskCategoryById(int id) async {
    final db = await open();
    final cat = await db.query(
      tableNameTaskCategory,
      where: '$kTaskCatId = ?',
      whereArgs: [id],
    ).then((value) {
      db.close();
      return value;
    });

    if (cat.isNotEmpty) {
      final c = cat.first;
      return TaskCategoryModel.fromMap(c);
    }

    return null;
  }
}
