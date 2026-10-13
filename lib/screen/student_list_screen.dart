import 'package:flutter/material.dart';
import 'package:student/controllers/Student_controller.dart';
import 'package:student/model/student_model_screen.dart';
import 'package:student/screen/student_details_screen.dart';
import 'package:student/utilities/endpoint.dart';
import 'package:student/utilities/validation.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});
  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}
class _StudentListScreenState extends State<StudentListScreen> {
  final StudentController controller = StudentController();
  List<StudentModel> students = [];
  List<StudentModel> filteredStudents = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadStudents();
  }
    Future<void> loadStudents() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await controller.getApi(
        Endpoints.students,
      );

      final data = (response as List)
          .map((json) => StudentModel.fromJson(
        Map<String, dynamic>.from(json),
      ))
          .toList();
      setState(() {
        students = data;
        filteredStudents = List.from(data);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  void _addStudent() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final courseController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Student"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: StudentValidation.name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: ageController,
                  validator: StudentValidation.age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: courseController,
                  validator: StudentValidation.course,
                  decoration: InputDecoration(
                    hintText: 'Course',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {

                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    try {
                      await controller.postApi(
                        Endpoints.students,
                        {
                          'name': nameController.text,
                          'age': int.parse(ageController.text),
                          'course': courseController.text,
                        },
                      );
                      if (!context.mounted)return;
                      Navigator.pop(context);

                      await loadStudents();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Student added successfully'),
                        ),
                      );
                    } catch (e) {

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Student Not added: $e'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _editStudent(StudentModel student) {
    final formKey = GlobalKey<FormState>();
    final nameController =
    TextEditingController(text: student.name);

    final ageController =
    TextEditingController(text: student.age.toString());

    final courseController =
    TextEditingController(text: student.course);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Student"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: StudentValidation.name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: ageController,
                  validator: StudentValidation.age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: courseController,
                  validator: StudentValidation.course,
                  decoration: InputDecoration(
                    hintText: 'Course',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    try {
                      await controller.putApi(
                        Endpoints.detail(Endpoints.students, student.id),
                        {
                          'name': nameController.text,
                          'age': int.parse(ageController.text),
                          'course': courseController.text,
                        },
                      );
                      if (!context.mounted) return;
                      Navigator.popUntil(
                        context,
                            (route) => route.isFirst,
                      );
                      await loadStudents();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Student updated successfully'),
                        ),
                      );
                    } catch (e) {


                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Student not Updated: $e'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Edit"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteStudent(StudentModel student) async {
    try {
      await controller.deleteApi(
        Endpoints.detail(Endpoints.students, student.id),
      );
      if (!mounted) return;
      setState(() {
        students.removeWhere(
              (item) => item.id == student.id,
        );

        filteredStudents.removeWhere(
              (item) => item.id == student.id,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text('Student deleted successfully'),

        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student not deleted'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),

              onChanged: (value) {
                setState(() {
                  filteredStudents = students.where((student) {
                    return student.name
                        .toLowerCase()
                        .contains(value.toLowerCase());
                  }).toList();
                });
              },
            ),

            const SizedBox(height: 10),

            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : filteredStudents.isEmpty
                  ? const Center(
                child: Text("No students found"),
              )
                  : ListView.builder(
                itemCount: filteredStudents.length,

                itemBuilder: (context, index) {
                  final student =
                  filteredStudents[index];

                  return ListTile(
                    leading: const CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.person),
                    ),

                    title: Text(student.name),

                    subtitle: Text(
                      student.course,
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StudentDetailsScreen(
                                student: student,
                                onDelete: () async {
                                  await _deleteStudent(
                                    student,
                                  );
                                  if (!context.mounted) return;
                                  if (mounted) {
                                    Navigator.popUntil(
                                      context,
                                          (route) => route.isFirst,
                                    );
                                  }
                                },

                                onEdit: ()  {
                                  _editStudent(student);

                                },

                              ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}