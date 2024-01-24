import 'dart:io';

import 'package:db2/screens/student_list_page.dart';
import 'package:flutter/material.dart';

import 'package:db2/model/student_model.dart';
import 'package:db2/db/database_helper.dart';

class EditStudentPage extends StatefulWidget {
  final Student student;

  EditStudentPage({required this.student});

  @override
  _EditStudentPageState createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _rollnumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student.name;
    _ageController.text = widget.student.age.toString();
    _genderController.text = widget.student.gender;
    _rollnumberController.text = widget.student.rollnumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper datahelp = DatabaseHelper();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage:
                    FileImage(File(widget.student.profilePicturePath)),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _rollnumberController,
                decoration: const InputDecoration(labelText: 'Rollnumber'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rollnumber';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final age = int.parse(_ageController.text);
                    final rollnumber = int.parse(_rollnumberController.text);

                    final updatedStudent = Student(
                      id: widget.student.id,
                      name: name,
                      age: age,
                      gender: _genderController.text,
                      rollnumber: rollnumber,
                      profilePicturePath: widget.student.profilePicturePath,
                    );

                    datahelp.updateStudent(updatedStudent).then((id) {
                      if (id > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Student updated successfully')),
                        );
                       // getStudents();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StudentListPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to update student')),
                        );
                      }
                    });
                  }
                },
                child: const Text('Save Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
