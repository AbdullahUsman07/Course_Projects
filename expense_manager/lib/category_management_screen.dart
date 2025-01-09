import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes.dart';
import 'expense_provider.dart';
import 'category_tag_class.dart';

class CategoryManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Categories'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: Consumer<ExpenseProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
                itemCount: provider.category.length,
                itemBuilder: (context, index) {
                  final category = provider.category[index];
                  return ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      onPressed: () {
                        provider.removeCategory(category.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                });
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          showAddCategoryDialog(context);
        },
        child:const Icon(Icons.add)),);
  }

  void showAddCategoryDialog(BuildContext context) {
    final TextEditingController _categoryNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: TextField(
            controller: _categoryNameController,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final category = Category(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _categoryNameController.text,
                );
                Provider.of<ExpenseProvider>(context, listen: false).addCategory(category);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
    }
   }

