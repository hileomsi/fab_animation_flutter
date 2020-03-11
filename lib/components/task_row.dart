import 'package:fab_animation_flutter/models/task.dart';
import 'package:flutter/material.dart';

class TaskRow extends StatefulWidget {
  final Task task;
  final double dotSize = 12.0;
  final Animation<double> animation;

  const TaskRow({Key key, this.task, this.animation}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaskRowState();
  }
}

class TaskRowState extends State<TaskRow> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: SizeTransition(
        sizeFactor: widget.animation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
                child: Container(
                  height: widget.dotSize,
                  width: widget.dotSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: widget.task.color),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.task.name,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      widget.task.category,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  widget.task.time,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
