import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/task.dart';
import 'package:time_tracker/provider/project_task_provider.dart';

class TagManagementScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Tasks'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body:Consumer<TimeEntryProvider>(builder: (context,provider,child){
        return ListView.builder(
          itemCount: provider.entries.length,
          itemBuilder: (context,index){
            final task=provider.tasks[index];
            return ListTile(
              title: Text(task.name),
              trailing: IconButton(onPressed: (){
                provider.removeTask(task.id);
              }, icon: const Icon(Icons.delete)),

            );
          });
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showAddTag(context);
      },
      child:const Icon(Icons.add),
    ),
    );
  }

  showAddTag(BuildContext context){
    TextEditingController _namTag= TextEditingController();

    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Add Tag'),
        content: TextField(
          controller: _namTag,
          decoration:const InputDecoration(labelText: 'Tag Name'),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Cancel')),
          TextButton(onPressed: (){
            final task=Task(id: DateTime.now().toString(),name: _namTag.text);
            Provider.of<TimeEntryProvider>(context,listen: false).addTask(task);
          }, child: const Text('Add')),
        ],
      );
    });
  }
}