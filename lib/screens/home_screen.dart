import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/item_model.dart';
import '../widgets/list_item.dart';
import '../widgets/add_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _items = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() async {
    setState(() => _isLoading = true);

    final jsonData = '''
    [
      { "id": 1, "name": "Apple", "category": "Fruit" },
      { "id": 2, "name": "Carrot", "category": "Vegetable" },
      { "id": 3, "name": "Chicken", "category": "Meat" },
      { "id": 4, "name": "Milk", "category": "Dairy" },
      { "id": 5, "name": "Bread", "category": "Bakery" }
    ]''';

    final List<dynamic> decodedData = json.decode(jsonData);

    await Future.delayed(const Duration(seconds: 2)); // Simulate loading delay

    for (int i = 0; i < decodedData.length; i++) {
      final item = Item.fromJson(decodedData[i]);
      _items.add(item);
      _listKey.currentState?.insertItem(i);
    }

    setState(() => _isLoading = false);
  }

  void _addItem() async {
    final newItem = await showDialog<Item>(
      context: context,
      builder: (context) {
        return const AddItemDialog();
      },
    );

    if (newItem != null) {
      _items.add(newItem);
      _listKey.currentState?.insertItem(_items.length - 1);
    }
  }

  void _deleteItem(int index) {
    final removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => ListItemWidget(
        item: removedItem,
        animation: animation,
        onDelete: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Animated List'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return ListItemWidget(
            item: _items[index],
            animation: animation,
            onDelete: () => _deleteItem(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
