class TimeEntry {
  final String id;
  final String projectID;
  final String taskID;
  final double time;
  final DateTime date;
  final String notes;

  TimeEntry({
    required this.id,
    required this.projectID,
    required this.taskID,
    required this.time,
    required this.date,
    required this.notes,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectID: json['projectID'],
      taskID: json['taskID'],
      time: json['time'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'projectID':projectID,
      'taskID':taskID,
      'time':time,
      'date':date.toIso8601String(),
      'notes':notes,
    };
  }
}
