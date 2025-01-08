import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'classes.dart';


class ExpenseProvider with ChangeNotifier {
  final LocalStorage storage;
  List<Expense> _expenses = [];
  List<Category> _category=[];

  List<Expense> get expenses => _expenses;
  List<Category> get category => _category;

  ExpenseProvider(this.storage) {
    _loadExpensesFromStorage();
    _loadCategoriesFromStorage();
  }

  void _loadExpensesFromStorage() async {
    var storedExpenses = storage.getItem('expenses');
    if (storedExpenses != null) {
      _expenses = List<Expense>.from(
        (storedExpenses as List).map((item) => Expense.fromJson(item)),
      );
      notifyListeners();
    }
  }

  void _saveExpensesToStorage() {
    String jsonString = jsonEncode(_expenses.map((e) => e.toJson()).toList());
    storage.setItem('expenses', jsonString);
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    _saveExpensesToStorage();
    notifyListeners();
  }

  void addOrUpdateExpense(Expense expense) {
    int index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
    } else {
      _expenses.add(expense);
    }
    _saveExpensesToStorage();
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    _saveExpensesToStorage();
    notifyListeners();
  }

  // category
  void _loadCategoriesFromStorage()async{
    var storedCategories= storage.getItem('categories');
    if(storedCategories!=null){
      _category = List<Category>.from((storedCategories as List).map((item)=>Category.fromJson(item)));
      notifyListeners();
    }
  }

  

  void _saveCategorytoStorage(){
    String jsonString = jsonEncode(_category.map((e) => e.toJson()).toList());
    storage.setItem('categories', jsonString);
    
  }
  void addCategory(Category category){
    _category.add(category);
    _saveCategorytoStorage();
    notifyListeners();
  }

  void removeCategory(String id){
    _category.removeWhere((category)=>category.id ==id);
    _saveCategorytoStorage();
    notifyListeners();
  }
}