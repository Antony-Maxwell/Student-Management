import 'package:db2/db/database_helper.dart';
import 'package:db2/model/student_model.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier{
  List<Student> _allStudents = [];

  DatabaseHelper studentData = DatabaseHelper();
  String? _profilePicture;

  List<Student> get allStudent => _allStudents;
  String? get profilePicture => _profilePicture;

  fetchAllStudents({String? query}) async {
    var students = await studentData.getStudents();
    
    if (query != null && query.isNotEmpty) {
      _allStudents = students.where((student) {
        return student.name.toLowerCase().contains(query.toLowerCase()) ||
            student.gender.toLowerCase().contains(query.toLowerCase()) ||
            student.rollnumber.toString().contains(query);
        // Add more fields if needed
      }).toList();
    } else {
      _allStudents = students;
    }

    notifyListeners();
  }

  addStudent(Student studentModel){
    studentData.insertStudent(studentModel);
    print('succesfully added ${studentModel.name}');
    fetchAllStudents();
  }

    updateStudent(Student studentModel) {
    studentData.updateStudent(studentModel);
    fetchAllStudents();
  }

  deleteStudent(int id) {
    studentData.deleteStudent(id);
    fetchAllStudents();
  }

  updateProfilePicture(String? path){
    _profilePicture = path;
    notifyListeners();
  }

    void clearProfilePicture() {
    _profilePicture = null;
    notifyListeners();
  }
}