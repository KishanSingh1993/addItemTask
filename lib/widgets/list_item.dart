


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/item_model.dart';

class ListItemWidget extends StatelessWidget{

  final Item item;
  final Animation<double> animation;
  final VoidCallback onDelete;

  const ListItemWidget({Key? key, required this.item, required this.animation, required this.onDelete}): super(key: key);



  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: animation,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            title: Text(item.name),
            subtitle: Text(item.category),
            trailing: IconButton(
              icon: const Icon(Icons.delete,color: Colors.red),
              onPressed: onDelete,
            ),
          ),
        ),
    );
  }
}