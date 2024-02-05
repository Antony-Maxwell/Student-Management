import 'dart:io';

import 'package:db2/provider/student_provider.dart';
import 'package:db2/screens/add_student_page.dart';
import 'package:db2/screens/search_field.dart';
import 'package:db2/screens/student_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StudentProvider>().fetchAllStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40), child: SearchField()),
        toolbarHeight: 70,
        title: const Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Text(
            'Student Management',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AddStudentPage();
            }));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Column(
        children: [
          Expanded(
            child: Consumer<StudentProvider>(
            builder: (context, studentData, child){
              return studentData.allStudent.isNotEmpty
              ? GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: studentData.allStudent.length,
              itemBuilder: (context, index) {
                final student = studentData.allStudent[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentDetailPage(student: student),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 213, 213, 213),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: FileImage(File(
                            studentData.allStudent[index].profilePicturePath,
                          )),
                        ),
                        SizedBox(height: 8.0),
                        Text(student.name),
                      ],
                    ),
                  ),
                );
              },
            )
                : Center(
                  child: Text(
                    'No Students Data Available'
                  ),
                );
            }
            )),
        ],
      ),
    );
  }
}