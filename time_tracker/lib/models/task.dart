class Task{
  final String name;
  final String id;

  Task({required this.id,required this.name});

  factory Task.fromJson(Map<String,dynamic> json){
    return Task(
      id:json['id'],
      name:json['name'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':name,
    };
  }
}