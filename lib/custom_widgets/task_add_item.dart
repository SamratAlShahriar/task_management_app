import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/pages/add_new_task_page.dart';

class TaskAddItem extends StatelessWidget {
  const TaskAddItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AddTaskPage.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          dashPattern: const [10, 10],
          child: const Center(child: Text('+ ADD')),
        ),
      ),
    );
  }
}
