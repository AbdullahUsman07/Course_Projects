import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/provider/project_task_provider.dart';
import 'package:time_tracker/models/timeEntry.dart';


class AddtimeEntryScreen extends StatefulWidget {
  const AddtimeEntryScreen({super.key});

  @override
  State<AddtimeEntryScreen> createState() => _AddtimeEntryScreenState();
}

class _AddtimeEntryScreenState extends State<AddtimeEntryScreen> {

  final _formKey=GlobalKey<FormState>();
  String projectID='';
  String taskID='';
  double time=0.0;
  String notes='';
  DateTime date=DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Time Entry'),
        centerTitle: true,
        backgroundColor:Colors.blue,
      ),
      body:Form(
        key:_formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value:projectID,
               onChanged: (String? newvalue){
                setState(() {
                  projectID=newvalue!;
                });
               },
               decoration:const InputDecoration(labelText: 'Project'),
              items: <String>['Project 1', 'Project 2', 'Project 3']
                    .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                );
                }).toList(),
            ),
              DropdownButtonFormField(
                value:taskID,
                onChanged: (String? newvalue){
                  setState(() {
                    taskID=newvalue!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Task'),
                items: <String>['Task 1', 'Task 2', 'Task 3'] // Dummy task names
                    .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                );
                }).toList(), ),
                TextFormField(
                  decoration:const InputDecoration(labelText: 'Total Time (Hours)'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value){
                    if(value ==null || value.isEmpty){
                      return 'Please Enter the Value';
                    }
                    if(double.tryParse(value) ==null){
                      return 'Enter Valid value';
                    }
                    return null;
                  },
                  onSaved: (value)=> time=double.parse(value!),
                ),
                TextFormField(
                  decoration:const InputDecoration(labelText: 'Notes'),
                  validator: (value){
                    if(value== null || value.isEmpty){
                      return 'Kindly input the Value';
                    }
                    return null;
                  },
                  onSaved:(value)=>notes=value!,
                ),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save;
                    Provider.of<TimeEntryProvider>(context,listen:false)
                    .addTimeEntry(TimeEntry(id: DateTime.now().toString(), 
                    projectID: projectID,
                     taskID: taskID, 
                     time: time,
                      date: date,
                       notes: notes));
                       Navigator.pop(context);
                  }
                }, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}