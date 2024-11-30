

class Item{

  final int id;
  final String name;
  final String category;

  Item({required this.id, required this.name, required this.category});


  factory Item.fromJson(Map<String, dynamic> json){

    return Item(id: json['id'], name: json['name'], category: json['category']);
  }

}