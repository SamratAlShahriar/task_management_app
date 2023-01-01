import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/db/local/sqfl_helper.dart';
import 'package:task_management_app/model/task_category_model.dart';

class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const i = Icons.heart_broken;
    return Card(
      child: Container(
        height: 300,
        child: Column(
          children: [
            Text('Add New Category'),
            TextField(),
          ],
        ),
      ),
    );
  }
}
