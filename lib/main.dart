import 'package:db2/db/database_helper.dart';
import 'package:db2/provider/student_provider.dart';
import 'package:flutter/material.dart';

import 'package:db2/screens/student_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  StudentProvider().fetchAllStudents();
  runApp(StudentRecordApp());
}

class StudentRecordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> StudentProvider(),
        ),
        FutureProvider(
          create: (_)=> context.read<StudentProvider>().fetchAllStudents(), 
          initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //  to remove th debug banner on top of the screen
        title: 'Student Record App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StudentList(),
      ),
    );
  }
  
}
