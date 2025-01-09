class Tag {
  final String name;
  final String id;

  Tag({required this.name, required this.id});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'name':name,
    };
  }
}

class Category {
  final String name;
  final String id;

  Category({required this.name, required this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'], 
      id:json['id'],
      );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':name,
    };
  }
}
