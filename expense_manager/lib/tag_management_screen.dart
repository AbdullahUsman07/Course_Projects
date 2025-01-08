import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'expense_provider.dart';
import 'classes.dart';

class TagManagementScreen extends StatelessWidget{

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text('Manage Tags'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body:Consumer<ExpenseProvider>(
        builder: (context,provider,child){
          return ListView.builder(
            itemCount: provider.tags.length,
            itemBuilder: (context,index){
              final tag =provider.tags[index];
              return ListTile(
                title:Text(tag.name),
                trailing: IconButton(onPressed: (){
                  provider.removeTag(tag.id);
                }, icon:const Icon(Icons.delete)),
              );
            }
            );
        },
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          showAddTagDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Tag',),
      );
  }

  void showAddTagDialog(BuildContext context){
    final TextEditingController _nameTagController= TextEditingController();

    showDialog(
    context: context,
     builder: (context){
      return AlertDialog(
        title:const Text('Add Tag'),
        content:TextField(
          controller: _nameTagController,
          decoration: const InputDecoration(label:Text('Tag Name')),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Cancel'),),
          TextButton(onPressed: (){
            final tag =Tag(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name:_nameTagController.text,
            );
            Provider.of<ExpenseProvider>(context,listen:false).addTag(tag);
          }, child: const Text('Add')),
        ],
      );
     });
  }
}