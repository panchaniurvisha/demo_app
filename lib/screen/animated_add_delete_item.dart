import 'package:flutter/material.dart';

class AnimatedAddDeleteItemScreen extends StatefulWidget {
  const AnimatedAddDeleteItemScreen({super.key});

  @override
  State<AnimatedAddDeleteItemScreen> createState() =>
      _AnimatedAddDeleteItemScreenState();
}

class _AnimatedAddDeleteItemScreenState
    extends State<AnimatedAddDeleteItemScreen> {
  final _item = [];
  GlobalKey<AnimatedListState> _key = GlobalKey();

  void addItem() {
    _item.insert(0, "Item${_item.length + 1}");
    _key.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

  void removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          color: Colors.red,
          child: ListTile(
            title: Text("Deleted"),
          ),
        ),
      );
    }, duration: const Duration(milliseconds: 300));
    _item.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Add delete"),
      ),
      body: Column(
        children: [
          InkWell(
            child: const Icon(Icons.add),
            onTap: () => addItem(),
          ),
          Expanded(
            child: AnimatedList(
              key: _key,
              initialItemCount: 0,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  key: UniqueKey(),
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    color: Colors.orangeAccent,
                    child: ListTile(
                      title: Text(
                        _item[index],
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          removeItem(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
