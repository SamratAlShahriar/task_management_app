import 'package:flutter/material.dart';
import 'package:task_management_app/pages/task_details_page.dart';

class TaskItem extends StatelessWidget {
  final IconData iconData;
  final String taskType;
  final Color taskItemColor;

  const TaskItem({Key? key,
    required this.iconData,
    required this.taskType,
    required this.taskItemColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TaskDetailPage.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: taskItemColor.withOpacity(0.1),
        ),
        height: 64,
        width: 64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: taskItemColor,
              size: 32,
            ),
            const SizedBox(height: 16,),
            Text(
              taskType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(32.0)),
                      color: taskItemColor.withOpacity(0.1),
                    ),
                    height: 32,
                    alignment: Alignment.center,
                    child: Text(
                      '0 LEFT',
                      style: TextStyle(color: taskItemColor),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      color: Colors.white,
                    ),
                    height: 32,
                    alignment: Alignment.center,
                    child: Text(
                      '0 DONE',
                      style: TextStyle(color: taskItemColor.withOpacity(0.6)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
