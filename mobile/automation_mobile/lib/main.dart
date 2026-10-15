import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const AutomationHub());
}

class AutomationHub extends StatelessWidget {
  const AutomationHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automation Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AutomationHomePage(),
    );
  }
}

class AutomationHomePage extends StatefulWidget {
  const AutomationHomePage({Key? key}) : super(key: key);

  @override
  _AutomationHomePageState createState() => _AutomationHomePageState();
}

class _AutomationHomePageState extends State<AutomationHomePage> {
  List<Map<String, dynamic>> tasks = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/tasks'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          tasks = data.map((item) => Map<String, dynamic>.from(item)).toList();
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load tasks: \${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading tasks: \${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _createTask(String taskType) async {
    setState(() {
      isLoading = true;
    });

    try {
      final taskData = {
        'name': 'New \${taskType} Task',
        'type': taskType,
        'schedule': 'immediate',
        'parameters': {},
      };
      
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(taskData),
      );
      
      if (response.statusCode == 200) {
        _loadTasks();
      } else {
        setState(() {
          errorMessage = 'Failed to create task';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error creating task: \${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Automation Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTasks,
          ),
        ],
      ),
      body: Column(
        children: [
          // Error message
          if (errorMessage != null)
            Container(
              color: Colors.red[100],
              padding: const EdgeInsets.all(8),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          
          // Loading indicator
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          
          // Tasks list
          if (!isLoading)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Icon(
                        _getTaskIcon(task['type']),
                        color: _getTaskColor(task['type']),
                      ),
                      title: Text(task['name']),
                      subtitle: Text('ID: \${task['id']}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(task['status']),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          task['status'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          
          // Action buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      context,
                      'Backup',
                      Icons.backup,
                      Colors.blue,
                      'backup',
                    ),
                    _buildActionButton(
                      context,
                      'Email',
                      Icons.email,
                      Colors.green,
                      'email',
                    ),
                    _buildActionButton(
                      context,
                      'Deploy',
                      Icons.cloud_upload,
                      Colors.orange,
                      'deploy',
                    ),
                    _buildActionButton(
                      context,
                      'Process',
                      Icons.data_object,
                      Colors.purple,
                      'data_processing',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTaskIcon(String type) {
    switch (type) {
      case 'backup':
        return Icons.backup;
      case 'email':
        return Icons.email;
      case 'deploy':
        return Icons.cloud_upload;
      case 'data_processing':
        return Icons.data_object;
      default:
        return Icons.task_alt;
    }
  }

  Color _getTaskColor(String type) {
    switch (type) {
      case 'backup':
        return Colors.blue;
      case 'email':
        return Colors.green;
      case 'deploy':
        return Colors.orange;
      case 'data_processing':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    if (status.contains('completed')) return Colors.green;
    if (status.contains('error')) return Colors.red;
    if (status.contains('running')) return Colors.blue;
    return Colors.grey;
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    String taskType,
  ) {
    return ElevatedButton(
      onPressed: isLoading ? null : () => _createTask(taskType),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
