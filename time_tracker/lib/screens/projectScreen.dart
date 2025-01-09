import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/project.dart';
import 'package:time_tracker/provider/project_task_provider.dart';

class ProjectManageScreen extends StatelessWidget{

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Projects'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body:Consumer<TimeEntryProvider>(
        builder: (context,provider,child){
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context,index){
              final project=provider.projects[index];
              return ListTile(
                title:Text(project.name),
                trailing: IconButton(onPressed: (){
                  provider.removeProject(project.id);
                }, icon:const Icon(Icons.delete)),
              );
            });
        }),
        floatingActionButton: FloatingActionButton(onPressed: (){
          showAddProject(context);
        },
        child:const Icon(Icons.add),
        ),
        
    );
  }

  void showAddProject(BuildContext context){

    final TextEditingController _projectName=TextEditingController();

    showDialog(context: context, builder: (context){
      return AlertDialog(
        title:const Text('Add Project'),
        content:TextField(
          controller: _projectName,
          decoration: const InputDecoration(labelText: 'Project Name'),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Cancel')),
          TextButton(onPressed: (){
            final project =Project(name: _projectName.text, id: DateTime.now().toString());
            Provider.of<TimeEntryProvider>(context,listen:false).addProject(project);
            Navigator.pop(context);
          }, child: const Text('Add')),
        ],
      );
    },);
  }
}