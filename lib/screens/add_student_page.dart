import 'dart:io';

import 'package:db2/provider/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:db2/model/student_model.dart';
import 'package:db2/db/database_helper.dart';
import 'package:provider/provider.dart';

class AddStudentPage extends StatelessWidget {

  AddStudentPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _parentnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _rollnumberController = TextEditingController();
  String? _profilePicturePath;
  XFile? image;
  @override
  Widget build(BuildContext context) {
      final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  XFile? img = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                      Provider.of<StudentProvider>(context,listen: false).updateProfilePicture(img?.path);
                      _profilePicturePath = img!.path;
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: Provider.of<StudentProvider>(context).profilePicture != null
                      ? FileImage(File(Provider.of<StudentProvider>(context).profilePicture!))
                      : null,
                  child: Provider.of<StudentProvider>(context).profilePicture == null
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                controller: _parentnameController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Address',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _ageController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'RollNumber',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your rollnumber';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final gender = _genderController.text;
                    final age = int.parse(_ageController.text);
                    final rollnumber = int.parse(_rollnumberController.text);
                    final student = Student(
                      id: 0,
                      name: name,
                      age: age,
                      gender: gender,
                      rollnumber: rollnumber,
                      profilePicturePath: _profilePicturePath ?? '',
                    );
                    studentProvider.addStudent(student);
                    Navigator.pop(context);
                    studentProvider.clearProfilePicture();
                    _profilePicturePath = null;
                    _nameController.clear();
                    _ageController.clear();
                    _genderController.clear();
                    _rollnumberController.clear();
                    _parentnameController.clear();
                  }
                },
                child: const Text('Save Student',
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
