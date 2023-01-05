const String kTaskId = 'id';
const String kTaskTitle = 'title';
const String kTaskDescription = 'description';
const String kTaskDate = 'date';
const String kTaskStartTime = 's_time';
const String kTaskEndTime = 'e_time';
const String kIsDone = 'is_done';
const String kTaskCatRefId = 'c_id';

class TaskModel {
  int? id;
  String title;
  String? description;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  bool isDone;
  int categoryId;

  TaskModel(
      {this.id,
      required this.title,
      this.description,
      required this.date,
      required this.startTime,
      required this.endTime,
      this.isDone = false,
      required this.categoryId});

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map[kTaskId],
      title: map[kTaskTitle],
      description: map[kTaskDescription],
      date: map[kTaskDate],
      startTime: map[kTaskStartTime],
      endTime: map[kTaskEndTime],
      isDone: map[kIsDone] == 0 ? false : true,
      categoryId: map[kTaskCatRefId],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      kTaskId: id,
      kTaskTitle: title,
      kTaskDescription: description,
      kTaskDate: date,
      kTaskStartTime: startTime,
      kTaskEndTime: endTime,
      kIsDone: isDone ? 1 : 0,
      kTaskCatRefId: categoryId,
    };
  }
}
