
import 'package:student/model/student_model_screen.dart';

class StudentValidation{
  // static  String? duplicate(String? value , List<StudentModel>students){
  //   if (value == null || value.trim().isEmpty){
  //     return "Enter ID Number";
  //   }
  //   final id = int.tryParse(value.trim());
  //
  // if (id == null) {
  //   return "Enter Valid ID Number";
  // }
  //
  // if (id <= 0){
  //   return "Enter Valid ID Number";
  //
  // }
  // if (students.any((student)=>student.id==id)){
  //   return "ID Already Exists In List";
  // }
  // return null ;
  // }

  static String? name(String? value){
    if (value == null || value.trim().isEmpty){
      return "Enter Your Name";
    }
    if (value.trim().length==2){
      return "Enter Valid Name";
    }
    if (!RegExp(r'^[a-z A-z]+$').hasMatch(value.trim())){
      return "Enter  Valid Name";
    }
    return null ;
  }

  static String? course(String? value){
    if (value == null || value.trim().isEmpty){
      return "Enter Your Course";
    }
    if (value.trim().length==2){
      return "Enter Valid Course";
    }
    if (!RegExp(r'^[a-z A-z]+$').hasMatch(value.trim())){
      return "Enter  Valid Course";
    }
    return null ;
  }
  static  String? age(String? value){
    if (value == null || value.trim().isEmpty){
      return "Enter Age ";
    }
    final age = int.tryParse(value.trim());

    if (age == null) {
      return "Enter Valid Age";
    }
    if (age <= 0){
      return "Enter Age (1 to 110)";

    }
    if (age >=110){
      return "Enter Age (1 to 110)";

    }
    return null ;
  }
}