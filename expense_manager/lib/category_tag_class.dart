import 'package:flutter/material.dart';


class AddCategoryDiaglog extends StatefulWidget {
  const AddCategoryDiaglog({super.key});

  @override
  State<AddCategoryDiaglog> createState() => _AddCategoryDiaglogState();
}

class _AddCategoryDiaglogState extends State<AddCategoryDiaglog> {

  final TextEditingController _nameController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Category'),
      content:TextField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: 'CategoryName'),
      ),
      actions: [
        TextButton(
          onPressed:(){
            Navigator.of(context).pop();
          } ,
         child: const Text('Cancel')),
         ElevatedButton(onPressed: (){
          final CategoryName=_nameController.text;
          if(CategoryName.isNotEmpty){
          Navigator.of(context).pop(CategoryName);
          }
         }, 
         child: const Text('Add')),
      ],
    );
  }

  @override 
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }
}


class AddTagDialog extends StatefulWidget {
  const AddTagDialog({super.key});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final TextEditingController _nameController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text('Add Tag'),
      content:TextField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: 'Tag Name'),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text('Cancel'),),
        ElevatedButton(onPressed: (){
          String TagName=_nameController.text;
          if(TagName.isNotEmpty){
            Navigator.of(context).pop(TagName);
          }
        }, child: const Text('Add')),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}