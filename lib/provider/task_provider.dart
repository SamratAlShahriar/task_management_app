import 'package:flutter/material.dart';
import 'package:task_management_app/db/local/sqfl_helper.dart';
import 'package:task_management_app/model/task_category_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskCategoryModel> taskList = [];

  Future<void> insert(TaskCategoryModel task) async {
    await SqfLiteHelper.insertTaskCategory(task);
  }

  Future<void> getAllTaskByCategory() async {
    taskList = await SqfLiteHelper.getAllTaskCategoryList();
    notifyListeners();
  }
}
