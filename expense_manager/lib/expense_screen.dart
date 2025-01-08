import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes.dart';
import 'expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final TextEditingController _amountController=TextEditingController();
  final TextEditingController _categoryIDController=TextEditingController();
  final TextEditingController _payeController=TextEditingController();
  final TextEditingController _noteController=TextEditingController();
  final TextEditingController _dateController=TextEditingController();
  final TextEditingController _tagCoroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add Expense'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body:Column(
        children: [
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(label:Text('Amount')),
            keyboardType: TextInputType.numberWithOptions(),
          ),
          TextField(
            controller: _categoryIDController,
            decoration: const InputDecoration(label:Text('Category Id')),
          ),
          TextField(
            controller: _payeController,
            decoration: const InputDecoration(label: Text('Payee')),
          ),
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(label:Text('Note')),
          ),
          TextField(
            controller:_dateController,
            decoration: const InputDecoration(label:Text('Date')),
            keyboardType: TextInputType.datetime,
          ),
          TextField(
            controller:_tagCoroller,
            decoration:const InputDecoration(label:Text('Tag')),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            _saveExpense(context);
          }, child: const Text('Save')),
        ],
      )
    );
  }

  void _saveExpense(BuildContext context){
    final expense=Expense(
      id:DateTime.now().microsecondsSinceEpoch.toString(),
      amount: double.parse(_amountController.text),
      categoryID: _categoryIDController.text,
      payee: _payeController.text,
      tag:_tagCoroller.text,
      date: DateTime.parse(_dateController.text),
      note: _noteController.text,
    );
    
    Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryIDController.dispose();
    _payeController.dispose();
    _dateController.dispose();
    _tagCoroller.dispose();
    _noteController.dispose();

    super.dispose();
  }
}

