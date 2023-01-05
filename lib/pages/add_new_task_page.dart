import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  late TaskProvider taskProvider;
  bool firstTime = true;

  DateTime? _selectedDate;
  DateTime? _selectedStartTime;
  DateTime? _selectedEndTime;

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
    if (firstTime) {
      taskProvider = Provider.of<TaskProvider>(context, listen: true);
      taskProvider.getAllTaskCategoryList();
      firstTime = false;
    }
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              label: Text(
                'Title',
                style: TextStyle(
                  fontSize: 14,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            onTap: () async {
              final dt = await DatePicker.showDatePicker(
                context,
                minTime: DateTime.now(),
              );
              if (dt == null) {
                return;
              }
              if (dt.year == _selectedDate?.year &&
                  dt.month == _selectedDate?.month &&
                  dt.day == _selectedDate?.day) {
                //same date selected
              } else {
                _selectedStartTime = null;
                _selectedEndTime = null;
                txtStartTimeCtrl.text = '';
                txtEndTimeCtrl.text = '';
              }
              _selectedDate = dt;
              txtDateCtrl.text =
                  formatDateTime(dt: _selectedDate ?? DateTime.now());
            },
            readOnly: true,
            decoration: const InputDecoration(
              label: Text(
                'Date',
                style: TextStyle(
                  fontSize: 14,
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () async {
                    if (_selectedDate == null) {
                      showSnackBar(context: context, msg: 'Please select a date first');
                      return;
                    }

                    final dt = await DatePicker.showTime12hPicker(
                      context,
                      currentTime: DateTime.now(),
                    );
                    if (dt == null) {
                      return;
                    }

                    _selectedStartTime = dt;
                    txtStartTimeCtrl.text = formatDateTime(
                        dt: _selectedStartTime!, pattern: 'HH:mm a');
                  },
                  readOnly: true,
                  decoration: const InputDecoration(
                    label: Text(
                      'Start Time',
                      style: TextStyle(
                        fontSize: 14,
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () async {
                    if (_selectedDate == null) {
                      showSnackBar(context: context, msg: 'Please select a date first');
                      return;
                    }

                    final dt = await DatePicker.showTime12hPicker(
                      context,
                      currentTime: _selectedDate,
                    );
                    if (dt == null) {
                      return;
                    }
                    _selectedEndTime = dt;
                    txtEndTimeCtrl.text = formatDateTime(
                        dt: _selectedEndTime!, pattern: 'hh:mm a');
                  },
                  readOnly: true,
                  decoration: const InputDecoration(
                    label: Text(
                      'End Time',
                      style: TextStyle(
                        fontSize: 14,
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
                  fontSize: 14,
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
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 2,
            children: List.generate(taskProvider.taskCategoryList.length + 1,
                (index) {
              if (index == taskProvider.taskCategoryList.length) {
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
                    // showPopupDialog(
                    //   context: context,
                    //   cWidget: const AddCategoryForm(),
                    // );
                    showBottomSheetDialog(
                        context: context, cWidget: const AddCategoryForm());
                  },
                );
              }
              final cat = taskProvider.taskCategoryList[index];
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
                  });
                },
              );
            }),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
