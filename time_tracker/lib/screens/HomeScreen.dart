import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:time_tracker/provider/project_task_provider.dart';
import 'package:time_tracker/screens/AddTimeEntryScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        backgroundColor: Colors.deepPurple[800],
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: "By Date"),
            Tab(text: "By Project"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.work, color: Colors.deepPurple),
              title: Text('Manage Projects'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/manage_projects');
              },
            ),
            ListTile(
              leading: Icon(Icons.task, color: Colors.deepPurple),
              title: Text('Manage Tasks'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/manage_tasks');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildEntriesByDate(context),
          buildEntriesByProject(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddtimeEntryScreen())),
        tooltip: 'Add Entry',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildEntriesByDate(BuildContext context) {
    return Consumer<TimeEntryProvider>(
      builder: (context, provider, child) {
        if (provider.entries.isEmpty) {
          return Center(
            child: Text("Click the + button to record time entries.",
                style: TextStyle(color: Colors.grey[600], fontSize: 18)),
          );
        }
        return ListView.builder(
          itemCount: provider.entries.length,
          itemBuilder: (context, index) {
            final entry = provider.entries[index];
            String formattedDate =
                DateFormat('MMM dd, yyyy').format(entry.date);
            return Dismissible(
              key: Key(entry.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                provider.removeTimeEntry(entry.id);
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                color: Colors.purple[50],
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: ListTile(
                  title: Text(
                      "${entry.taskID} - ${entry.time.toStringAsFixed(2)} hours"),
                  subtitle: Text(
                      "$formattedDate - Project: ${getProjectNameById(context, entry.projectID)}"),
                  isThreeLine: true,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildEntriesByProject(BuildContext context) {
    return Consumer<TimeEntryProvider>(
      builder: (context, provider, child) {
        if (provider.entries.isEmpty) {
          return Center(
            child: Text("Click the + button to record time entries.",
                style: TextStyle(color: Colors.grey[600], fontSize: 18)),
          );
        }
        // Grouping entries by project
        var grouped = groupBy(provider.entries, (entry) => entry.projectID);
        return ListView(
          children: grouped.entries.map((entry) {
            String projectName = getProjectNameById(context, entry.key);
            double total = entry.value.fold(
                0.0, (double prev, element) => prev + element.time);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "$projectName - Total: ${total.toStringAsFixed(2)} hours",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: entry.value.length,
                  itemBuilder: (context, index) {
                    var timeEntry = entry.value[index];
                    return ListTile(
                      leading:
                          Icon(Icons.access_time, color: Colors.deepPurple),
                      title: Text(
                          "${timeEntry.projectID} - ${timeEntry.time.toStringAsFixed(2)} hours"),
                      subtitle: Text(DateFormat('MMM dd, yyyy')
                          .format(timeEntry.date)),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  String getProjectNameById(BuildContext context, String projectId) {
    var project = Provider.of<TimeEntryProvider>(context, listen: false)
        .projects
        .firstWhere((proj) => proj.id == projectId);
    return project.name;
  }
}
