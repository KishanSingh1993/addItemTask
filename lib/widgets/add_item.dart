

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../model/item_model.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();

    return AlertDialog(
      title: const Text("Add New Item"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: "Category"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text.trim();
            final category = categoryController.text.trim();

            if (name.isNotEmpty && category.isNotEmpty) {
              final newItem = Item(
                id: DateTime.now().millisecondsSinceEpoch, // Unique ID
                name: name,
                category: category,
              );
              Navigator.pop(context, newItem);
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
