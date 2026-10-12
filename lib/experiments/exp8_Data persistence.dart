import 'package:flutter/material.dart';

// --- Student Model ---
class Student {
  final int? id;
  final String name;
  final String course;

  Student({this.id, required this.name, required this.course});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'course': course,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      course: map['course'],
    );
  }
}

// --- PART A: In-Memory SQL Simulation Platform-agnostic for Lab Demos ---
class SQLiteDatabaseHelper {
  static final SQLiteDatabaseHelper _instance = SQLiteDatabaseHelper._internal();
  factory SQLiteDatabaseHelper() => _instance;
  SQLiteDatabaseHelper._internal();

  final List<Map<String, dynamic>> _mockDb = [
    {'id': 1, 'name': 'Amit Kumar', 'course': 'CSE'},
    {'id': 2, 'name': 'Sita Sharma', 'course': 'ECE'}
  ];
  int _idCounter = 3;

  Future<List<Student>> getStudents() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDb.map((e) => Student.fromMap(e)).toList();
  }

  Future<int> insertStudent(Student student) async {
    final newStudent = {'id': _idCounter++, 'name': student.name, 'course': student.course};
    _mockDb.add(newStudent);
    return newStudent['id'] as int;
  }

  Future<int> updateStudent(Student student) async {
    int index = _mockDb.indexWhere((element) => element['id'] == student.id);
    if (index != -1) {
      _mockDb[index] = student.toMap();
      return 1;
    }
    return 0;
  }

  Future<int> deleteStudent(int id) async {
    _mockDb.removeWhere((element) => element['id'] == id);
    return 1;
  }
}

// --- PART B: Firebase Cloud Synchronization Simulator ---
class FirebaseCloudHelper {
  static final FirebaseCloudHelper _instance = FirebaseCloudHelper._internal();
  factory FirebaseCloudHelper() => _instance;
  FirebaseCloudHelper._internal();

  final List<Map<String, dynamic>> _cloudDb = [
    {'id': 101, 'name': 'Rajesh Cloud', 'course': 'AI-ML'}
  ];
  int _cloudCounter = 102;

  Future<List<Student>> getCloudStudents() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulates cloud latency
    return _cloudDb.map((e) => Student.fromMap(e)).toList();
  }

  Future<void> addCloudStudent(String name, String course) async {
    _cloudDb.add({'id': _cloudCounter++, 'name': name, 'course': course});
  }

  Future<void> removeCloudStudent(int id) async {
    _cloudDb.removeWhere((element) => element['id'] == id);
  }
}

// --- Main UI Page for Experiment 8 ---
class Exp8DataPersistencePage extends StatefulWidget {
  const Exp8DataPersistencePage({super.key});

  @override
  State<Exp8DataPersistencePage> createState() => _Exp8DataPersistencePageState();
}

class _Exp8DataPersistencePageState extends State<Exp8DataPersistencePage> {
  final SQLiteDatabaseHelper _sqliteHelper = SQLiteDatabaseHelper();
  final FirebaseCloudHelper _firebaseHelper = FirebaseCloudHelper();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  List<Student> _localStudents = [];
  List<Student> _cloudStudents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    final local = await _sqliteHelper.getStudents();
    final cloud = await _firebaseHelper.getCloudStudents();
    setState(() {
      _localStudents = local;
      _cloudStudents = cloud;
      _isLoading = false;
    });
  }

  void _addStudentData() async {
    if (_nameController.text.isEmpty || _courseController.text.isEmpty) return;

    // Insert locally to Part A SQLite Mock
    await _sqliteHelper.insertStudent(
      Student(name: _nameController.text, course: _courseController.text),
    );

    // Insert to Part B Cloud Architecture Mock
    await _firebaseHelper.addCloudStudent(_nameController.text, _courseController.text);

    _nameController.clear();
    _courseController.clear();
    _refreshData();
  }

  void _deleteLocal(int id) async {
    await _sqliteHelper.deleteStudent(id);
    _refreshData();
  }

  void _deleteCloud(int id) async {
    await _firebaseHelper.removeCloudStudent(id);
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite & Firebase Persistence'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Form UI - FIXED: Direct padding parameter removed from Card and wrapped in a Padding widget
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(labelText: 'Student Name'),
                          ),
                          TextField(
                            controller: _courseController,
                            decoration: const InputDecoration(labelText: 'Course Name'),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: _addStudentData,
                            icon: const Icon(Icons.save),
                            label: const Text('Save to Dual Storage Platforms'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Dual Columns displaying storage states
                  Expanded(
                    child: Row(
                      children: [
                        // Local SQLite Column
                        Expanded(
                          child: Column(
                            children: [
                              const Chip(
                                label: Text('Part A: Local SQLite'),
                                backgroundColor: Colors.tealAccent,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _localStudents.length,
                                  itemBuilder: (context, i) => ListTile(
                                    title: Text(_localStudents[i].name),
                                    subtitle: Text(_localStudents[i].course),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _deleteLocal(_localStudents[i].id!),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const VerticalDivider(),
                        // Cloud Firebase Column
                        Expanded(
                          child: Column(
                            children: [
                              const Chip(
                                label: Text('Part B: Firebase Cloud'),
                                backgroundColor: Colors.orangeAccent,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _cloudStudents.length,
                                  itemBuilder: (context, i) => ListTile(
                                    title: Text(_cloudStudents[i].name),
                                    subtitle: Text(_cloudStudents[i].course),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.cloud_off, color: Colors.brown),
                                      onPressed: () => _deleteCloud(_cloudStudents[i].id!),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
