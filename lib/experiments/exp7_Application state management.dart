import 'dart:convert';
import 'package:flutter/material.dart';

class Student {
  final int id;
  final String name;
  final String course;

  Student({
    required this.id,
    required this.name,
    required this.course,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'course': course,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      course: json['course'],
    );
  }
}

class Exp7StateManagementPage extends StatefulWidget {
  const Exp7StateManagementPage({super.key});

  @override
  State<Exp7StateManagementPage> createState() => _Exp7StateManagementPageState();
}

class _Exp7StateManagementPageState extends State<Exp7StateManagementPage> {
  List<String> students = [];
  String logOutput = "Logs will appear here when you add a student...";
  int currentId = 1;

  void handleSerialization() {
    Student student = Student(
      id: currentId,
      name: 'Raj',
      course: 'CSE',
    );

    Map<String, dynamic> data = student.toJson();
    Student newStudent = Student.fromJson(data);

    setState(() {
      students.add(newStudent.name);
      logOutput = "Serialized Map: $data\nDeserialized Name: ${newStudent.name} (ID: $currentId)";
      currentId++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State & Serialization'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: handleSerialization,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Run Serialization & Add to List'),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                logOutput,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Student List View State:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('${students[index]} #${index + 1}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
