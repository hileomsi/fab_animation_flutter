import 'package:fab_animation_flutter/components/task_row.dart';
import 'package:fab_animation_flutter/models/task.dart';
import 'package:flutter/material.dart';

class ListModel {
  final GlobalKey<AnimatedListState> listKey;
  final List<Task> items;

  ListModel(this.listKey, items) : this.items = List.of(items);

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, Task item) {
    items.insert(index, item);
    _animatedList.insertItem(index);
  }

  Task removeAt(int index) {
    final Task removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
          index,
          (context, animation) => TaskRow(
                task: removedItem,
                animation: animation,
              ),
          duration:
              Duration(milliseconds: (150 + 150 * (index / length)).toInt()));
    }
    return removedItem;
  }

  int get length => items.length;

  Task operator [](int index) => items[index];

  int indexOf(Task item) => items.indexOf(item);
}
