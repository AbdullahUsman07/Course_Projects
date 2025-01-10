

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/timeEntry.dart';
import 'package:time_tracker/provider/project_task_provider.dart';

class AddtimeEntryScreen extends StatefulWidget {
  const AddtimeEntryScreen({super.key});

  @override
  State<AddtimeEntryScreen> createState() => _AddtimeEntryScreenState();
}

class _AddtimeEntryScreenState extends State<AddtimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? projectID;
  String? taskID;
  double time = 0.0;
  String notes = '';
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Time Entry',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[800],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Use Consumer to access the provider data
            Consumer<TimeEntryProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  value: projectID,
                  onChanged: (String? newValue) {
                    setState(() {
                      projectID = newValue;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Project'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a project';
                    }
                    return null;
                  },
                  items:
                      provider.projects // Using the projects from the provider
                          .map<DropdownMenuItem<String>>((project) {
                    return DropdownMenuItem<String>(
                      value: project.id,
                      child: Text(project.name), // Display project name
                    );
                  }).toList(),
                );
              },
            ),
            Consumer<TimeEntryProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  value: taskID,
                  onChanged: (String? newValue) {
                    setState(() {
                      taskID = newValue;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Task'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a Task';
                    }
                    return null;
                  },
                  items:
                      provider.tasks // Using the projects from the provider
                          .map<DropdownMenuItem<String>>((task) {
                    return DropdownMenuItem<String>(
                      value: task.id,
                      child: Text(task.name), // Display project name
                    );
                  }).toList(),
                );
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Total Time (Hours)'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                if (double.tryParse(value) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
              onSaved: (value) => time = double.parse(value!),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Notes'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some notes';
                }
                return null;
              },
              onSaved: (value) => notes = value!,
            ),
           ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!
                      .save(); // Added parentheses here to call the save method.
                  final duration = Duration(
                      hours: time.floor(), minutes: ((time % 1) * 60).round());
                  final updatedDateTime = date.add(duration);

                  Provider.of<TimeEntryProvider>(context, listen: false)
                      .addTimeEntry(
                    TimeEntry(
                      id: DateTime.now().toString(),
                      projectID: projectID!,
                      taskID: taskID!,
                      time: time,
                      date: updatedDateTime,
                      notes: notes,
                    ),
                  );
                  Navigator.pop(context); // Closes the screen after saving
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}


