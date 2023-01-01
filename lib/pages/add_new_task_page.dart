import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/custom_widgets/add_category_form.dart';
import 'package:task_management_app/provider/task_provider.dart';
import 'package:task_management_app/utils/helper_functions.dart';

class AddTaskPage extends StatefulWidget {
  static const String routeName = '/add_task_page';

  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TextEditingController txtTitleCtrl;
  late TextEditingController txtDateCtrl;
  late TextEditingController txtStartTimeCtrl;
  late TextEditingController txtEndTimeCtrl;
  late TextEditingController txtDesCtrl;
  int _selectedIndex = 0;
  bool _selected = false;
  late TaskProvider taskProvider;

  @override
  void initState() {
    txtTitleCtrl = TextEditingController();
    txtDateCtrl = TextEditingController();
    txtStartTimeCtrl = TextEditingController();
    txtEndTimeCtrl = TextEditingController();
    txtDesCtrl = TextEditingController();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    taskProvider = Provider.of<TaskProvider>(context);
  }

  @override
  void dispose() {
    txtTitleCtrl.dispose();
    txtDateCtrl.dispose();
    txtStartTimeCtrl.dispose();
    txtEndTimeCtrl.dispose();
    txtDesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 140,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'New Task',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0.2,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.task_alt,
                      color: Colors.black,
                      size: 28,
                    )),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          SliverToBoxAdapter(
            child: _buildTaskInputFields(),
          ),
        ],
      ),
    );
  }

  Container _buildTaskInputFields() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: txtTitleCtrl,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              label: Text(
                'Title',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              border: UnderlineInputBorder(),
            ),
          ),
          TextField(
            controller: txtDateCtrl,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            onTap: () {},
            readOnly: true,
            decoration: const InputDecoration(
              label: Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              border: UnderlineInputBorder(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: txtStartTimeCtrl,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {},
                  readOnly: true,
                  decoration: const InputDecoration(
                    label: Text(
                      'Start Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextField(
                  controller: txtEndTimeCtrl,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {},
                  readOnly: true,
                  decoration: const InputDecoration(
                    label: Text(
                      'End Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          TextField(
            controller: txtDesCtrl,
            maxLines: 3,
            minLines: 1,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              label: Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              border: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Category',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 2,
            children: List.generate(taskProvider.taskList.length + 1, (index) {
              if (index == taskProvider.taskList.length) {
                return TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30))),
                  label: const Text(
                    'Add New Category',
                    style: TextStyle(fontSize: 12),
                  ),
                  icon: const Icon(
                    (Icons.add),
                    size: 12,
                  ),
                  onPressed: () {
                    showPopupDialog(
                        context: context, cWidget: const AddCategoryForm());
                  },
                );
              }
              final cat = taskProvider.taskList[index];
              return ChoiceChip(
                label: Text(
                  cat.categoryTitle,
                ),
                backgroundColor: Colors.black.withOpacity(0.15),
                selectedColor: Colors.black87,
                labelStyle: TextStyle(
                  color: index == _selectedIndex ? Colors.white : null,
                  fontSize: 12,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                selected: index == _selectedIndex ? true : false,
                onSelected: (value) {
                  setState(() {
                    _selectedIndex = index;
                    _selected = value;
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
