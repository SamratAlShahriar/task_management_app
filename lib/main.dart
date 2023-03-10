import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/pages/add_new_task_page.dart';
import 'package:task_management_app/pages/home_page.dart';
import 'package:task_management_app/pages/task_details_page.dart';
import 'package:task_management_app/provider/task_provider.dart';
import 'package:task_management_app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Today',
        theme: appTheme,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          AddTaskPage.routeName: (context) => const AddTaskPage(),
          TaskDetailPage.routeName: (context) => const TaskDetailPage(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
