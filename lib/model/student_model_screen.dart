class StudentModel {
  int id;
  String name;
  int age;
  String course;

  StudentModel({
    required this.id,
    required this.name,
    required this.age,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'course': course,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      course: json['course'],
    );
  }
}