import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/models/tag_category.dart';
import 'package:time_tracker/models/project.dart';
import 'package:time_tracker/models/task.dart';
import 'package:time_tracker/models/timeEntry.dart';
import 'dart:convert';


class TimeEntryProvider with ChangeNotifier{
  final LocalStorage storage;

  List<TimeEntry> _entries=[];
  List<Task> _tasks=[];
  List<Project> _projects=[];
  

  List<TimeEntry> get entries => _entries;
  List<Task> get tasks => _tasks;
  List<Project> get projects => _projects;

  TimeEntryProvider(this.storage){
    loadProjectsFromStorage();
    loadTaskFromStorage();
    loadTimeEntryFromStorage();
  }


  void loadTaskFromStorage()async{
    var storedTasks= storage.getItem('task');
    if(storedTasks!=null){
      _tasks=List<Task>.from((storedTasks as List).map((item) =>Task.fromJson(item)));
      notifyListeners();
    }
  }


  void loadProjectsFromStorage()async{
    var storedProjects=storage.getItem('projects');
    if(storedProjects!=null){
      _projects=List<Project>.from(
        (storedProjects as List).map((item)=>Project.fromJson(item))
      );
      notifyListeners();
    }
  }


  void loadTimeEntryFromStorage()async{
    var storedTime=storage.getItem('entries');
    if(storedTime!=null){
      _entries=List<TimeEntry>.from(
        (storedTime as List).map((item)=>TimeEntry.fromJson(item))
      );
      notifyListeners();
    }
  }

  void saveTimeEntryToStorage(){
    String jsonString=jsonEncode(_entries.map((e)=>e.toJson()).toList());
    storage.setItem('entries', jsonString);
  }

  void saveTasksToStorage(){
    String jsonString=jsonEncode(_tasks.map((e)=>e.toJson()).toList());
    storage.setItem('tasks',jsonString);
  }

  void saveProjectToStorage(){
    String jsonString =jsonEncode(_projects.map((e)=>e.toJson()).toList());
    storage.setItem('projectss',jsonString);
  }


  void addTimeEntry(TimeEntry entry){
    _entries.add(entry);
    saveTimeEntryToStorage();
    notifyListeners();
  }

  void removeTimeEntry(String id){
     _entries.removeWhere((entry) => entry.id ==id);
     saveTimeEntryToStorage();
    notifyListeners();
  }

  void addTask(Task task){
    _tasks.add(task);
    saveTasksToStorage();
    notifyListeners();
  }

  void removeTask(String id){
    _tasks.removeWhere((task)=>task.id ==id);
    saveTasksToStorage();
    notifyListeners();
  }

  void removeProject(String id){
    _projects.removeWhere((project)=>project.id ==id);
    saveProjectToStorage();
    notifyListeners();
  }

  void addProject(Project project){
    _projects.add(project);
    saveProjectToStorage();
    notifyListeners();
  }


}