import 'package:flutter/material.dart';
import 'package:task_management_app/db/local/sqfl_helper.dart';
import 'package:task_management_app/model/task_category_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskCategoryModel> taskCategoryList = [];

  Future<void> insertTaskCategory(TaskCategoryModel taskCategoryModel) async {
    await SqfLiteHelper.insertTaskCategory(taskCategoryModel);
  }

  Future<void> getAllTaskCategoryList() async {
    taskCategoryList = await SqfLiteHelper.getAllTaskCategoryList();
    notifyListeners();
  }
}
