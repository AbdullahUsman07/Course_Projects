import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';

import 'package:time_tracker/screens/HomeScreen.dart';
import 'package:time_tracker/screens/taskScreen.dart';
import 'package:time_tracker/screens/projectScreen.dart';
import 'package:time_tracker/provider/project_task_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget{
  final LocalStorage localStorage;
  const MyApp({Key? key, required this.localStorage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimeEntryProvider(localStorage)),
    ],
    child: MaterialApp(
      title:'Time Tracker',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>HomeScreen(),
        '/manage_projects':(context)=>ProjectManageScreen(),
        '/manage_tasks':(context)=>TagManagementScreen(),
      },
    ),
    );
  }
}