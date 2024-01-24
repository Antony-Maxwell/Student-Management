import 'package:flutter/material.dart';

import 'package:db2/screens/student_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(StudentRecordApp());
}

class StudentRecordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //  to remove th debug banner on top of the screen
      title: 'Student Record App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentListPage(),
    );
  }
  
}
