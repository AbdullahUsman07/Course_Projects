class Expense{
  final String id;
  final double amount;
  final String categoryID;
  final String payee;
  final String note;
  final DateTime date;
  final String tag;

  Expense({
    required this.id,
    required this.amount,
    required this.categoryID,
    required this.payee,
    required this.note,
    required this.date,
    required this.tag,
  });

  factory Expense.fromJson(Map<String, dynamic> json){
    return Expense(
      id:json['id'],
      amount:json['amount'],
      categoryID: json['categoryID'],
      payee:json['payee'],
      note:json['note'],
      date:json['date'],
      tag:json['tag'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'amount':amount,
      'categoryID':categoryID,
      'payee':payee,
      'note':note,
      'date':date,
      'tag':tag,
    };
  }
}

class Category{

  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String,dynamic> json){
    return Category(
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

class Tag{
  final String id;
  final String name;

  Tag({
    required this.id,
    required this.name,
  });

  factory Tag.fromJson(Map<String,dynamic> json){
    return Tag(
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

