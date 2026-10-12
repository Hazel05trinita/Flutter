import 'package:flutter/material.dart';

// Import all experiment files
import 'experiments/exp1_widgets.dart';
import 'experiments/exp2_responsive.dart';
import 'experiments/exp3_forms.dart';
import 'experiments/exp4_media.dart';
import 'experiments/exp5_navigation.dart';
import 'experiments/exp6_Integrate animation and transition.dart'; 
import 'exp7_Application state management.dart'; 
import 'experiments/exp8_Data persistence.dart'; 
import 'experiments/exp9_API connectivity.dart'; // Added Experiment 9 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Lab Experiments',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExperimentMenu(),
    );
  }
}

class ExperimentMenu extends StatelessWidget {
  const ExperimentMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Experiments Hub'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuItem(
            context,
            number: '1',
            title: 'Working with Widgets and Layouts',
            subtitle: 'Cards, Columns, Rows, and Avatars',
            icon: Icons.widgets,
            color: Colors.indigo,
            page: const Exp1WidgetsPage(),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            context,
            number: '2',
            title: 'Adaptive and Responsive UI Design',
            subtitle: 'Dynamic ListView and Asset Images',
            icon: Icons.aspect_ratio,
            color: Colors.teal,
            page: const Exp2ResponsivePage(),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            context,
            number: '3',
            title: 'Add Interactivity – Input and Forms',
            subtitle: 'Textfields, Validation, and State',
            icon: Icons.edit_note,
            color: Colors.orange,
            page: const Exp3FormsPage(),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            context,
            number: '4',
            title: 'Utilize Assets and Media',
            subtitle: 'Network Images, Icons, and Asset Config',
            icon: Icons.perm_media,
            color: Colors.purple,
            page: const Exp4FuelCalculatorPage(),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            context,
            number: '5',
            title: 'Implementation of Navigation & Routing',
            subtitle: 'Routes and Screen Transitions',
            icon: Icons.alt_route,
            color: Colors.blueGrey,
            page: const Exp5NavigationPage(),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            context,
            number: '6',
            title: 'Integrate Animations and Transition',
            subtitle: 'AnimatedContainer and Custom Transitions',
            icon: Icons.animation,
            color: Colors.pink,
            page: Exp6AnimationPage(), 
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            context,
            number: '7',
            title: 'Application State & Serialization',
            subtitle: 'JSON Parsing, Mapping, and State Lists',
            icon: Icons.data_object,
            color: Colors.deepOrange,
            page: Exp7StateManagementPage(),
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            context,
            number: '8',
            title: 'Data Persistence (SQLite & Firebase)',
            subtitle: 'Local Storage vs. Cloud Synchronisation State',
            icon: Icons.storage,
            color: Colors.teal,
            page: Exp8DataPersistencePage(),
          ),
          const SizedBox(height: 12),
          // Added Experiment 9 menu item
          _buildMenuItem(
            context,
            number: '9',
            title: 'Accessing REST APIs via HTTP',
            subtitle: 'Asynchronous HTTP Requests & Data Parsing',
            icon: Icons.cloud_sync,
            color: Colors.cyan.shade700,
            page: const Exp9ApiConnectivityPage(), // Const enabled safely due to clean initState
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String number,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color,
          foregroundColor: Colors.white,
          child: Text(number, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
