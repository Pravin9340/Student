import 'package:flutter/material.dart';
import 'package:student/model/student_model_screen.dart';
class StudentDetailsScreen extends StatelessWidget {
  final StudentModel student ;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const StudentDetailsScreen({super.key ,required this.student, required this.onDelete , required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,

      ),
      body: Center(
        child: Padding(padding: EdgeInsetsGeometry.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
         CircleAvatar(
           radius: 40,
          child: Icon(Icons.person, size: 35,),


      ),
              SizedBox(height: 15,),
              Text('ID: ${student.id}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text('Name: ${student.name}', style: TextStyle(fontSize: 17, ),),
              SizedBox(height: 8,),
              Text('Course: ${student.course}', style: TextStyle(fontSize: 17, ),),
              SizedBox(height: 8,),
              Text('Age: ${student.age}', style: TextStyle(fontSize: 17, ),),
           SizedBox(height: 15,),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(onPressed: (){
                 showDialog(context: context, builder: (context){
                 return AlertDialog(
                   title: Text("Are you Sure Delete A Student"),
                   content: Row(children: [
                     ElevatedButton(onPressed: () {onDelete();}, child: Icon(Icons.delete , color: Colors.red,)),
                     SizedBox(width: 180,),
                     ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Icon(Icons.cancel,color: Colors.green,)),
                   ],
                   ),
                 );},);
               }, child:
               Icon(Icons.delete ,size: 16,color: Colors.red,)),
               SizedBox(width: 30,),
               ElevatedButton(onPressed: (){onEdit();}, child:
               Icon(Icons.edit ,size: 16,color: Colors.green,))
             ],
           )

            ],
        ),
        ),
      ),
    );
  }
}
