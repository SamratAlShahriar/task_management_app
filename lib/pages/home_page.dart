import 'package:flutter/cupertino.dart' as cicon;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/custom_widgets/go_premium.dart';
import 'package:task_management_app/custom_widgets/task_add_item.dart';
import 'package:task_management_app/custom_widgets/task_item.dart';
import 'package:task_management_app/pages/add_new_task_page.dart';
import 'package:task_management_app/provider/task_provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<TaskProvider>(
      context,
    );
    tp.getAllTaskByCategory();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GoPremium(),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Tasks',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 32),
              itemCount: tp.taskList.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                if (index == (tp.taskList.length)) {
                  return const TaskAddItem();
                }
                final ti = tp.taskList[index];
                return TaskItem(
                    iconData: IconData(ti.iconCodePoint),
                    taskType: ti.categoryTitle,
                    taskItemColor: Color(ti.color));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTaskPage.routeName);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Container buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(cicon.CupertinoIcons.house), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(cicon.CupertinoIcons.profile_circled),
                label: 'More'),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'assets/images/profile_placeholder.png',
                width: 36,
                height: 36,
              )),
          const SizedBox(
            width: 8,
          ),
          RichText(
              text: const TextSpan(
                  text: 'Hi,',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  children: [
                TextSpan(text: ' '),
                TextSpan(
                    text: 'Samrat!',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ]))
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 28,
          ),
        ),
      ],
    );
  }
}
