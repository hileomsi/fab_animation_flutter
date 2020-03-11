import 'package:fab_animation_flutter/components/animated_fab.dart';
import 'package:fab_animation_flutter/components/dialogonal_clipper.dart';
import 'package:fab_animation_flutter/components/task_row.dart';
import 'package:fab_animation_flutter/models/task.dart';
import 'package:fab_animation_flutter/repository/list_model.dart';
import 'package:flutter/material.dart';

final double IMAGE_HEIGTH = 300;

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  ListModel listModel;
  bool showOnlyCompleted = false;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<Task> tasks = [
    Task(
      name: "Catch up with Brian",
      category: "Mobile Project",
      time: "5pm",
      color: Colors.orange,
      completed: false,
    ),
    Task(
      name: "Make icons",
      category: "Web App",
      time: "3pm",
      color: Colors.cyan,
      completed: true,
    ),
    Task(
      name: "Design explorations",
      category: "Company Website",
      time: "2pm",
      color: Colors.pink,
      completed: false,
    ),
    Task(
      name: "Lunch with Mary",
      category: "Grill House",
      time: "12pm",
      color: Colors.cyan,
      completed: true,
    ),
    Task(
      name: "Teem Meeting",
      category: "Hangouts",
      time: "10am",
      color: Colors.cyan,
      completed: true,
    ),
  ];

  @override
  void initState() {
    listModel = ListModel(listKey, tasks);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildTimeline(),
          buildImage(),
          buildHeader(),
          buildBody(),
          buildFab(),
        ],
      ),
    );
  }

  ClipPath buildImage() {
    return ClipPath(
      clipper: DialogonalClipper(),
      child: Image.asset(
        'images/background.jpeg',
        fit: BoxFit.fitHeight,
        height: IMAGE_HEIGTH,
        colorBlendMode: BlendMode.srcOver,
        color: Color.fromARGB(80, 20, 10, 40),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          buildNavbar(),
          Row(
            children: <Widget>[
              CircleAvatar(
                minRadius: 30,
                maxRadius: 30,
                backgroundImage: AssetImage('images/profile.jpeg'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hiléo Andersson',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'Software Engineer',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Padding buildNavbar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Row(
        children: <Widget>[
          Icon(Icons.menu, size: 28, color: Colors.white),
          Expanded(child: Container()),
          Icon(Icons.linear_scale, color: Colors.white),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.only(top: 280),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTitle(),
          buildTasks(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: EdgeInsets.only(left: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "My Tasks",
            style: TextStyle(fontSize: 28),
          ),
          Text(
            "FEBRUARY 8, 2020",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildTimeline() {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 31.0,
      child: Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Widget buildFab() {
    return Positioned(
      top: IMAGE_HEIGTH - 100.0,
      right: -40,
      child: AnimatedFab(
        onPressed: changeFilterState,
      ),
    );
  }

  Widget buildTasks() {
    return Expanded(
      child: AnimatedList(
        initialItemCount: tasks.length,
        key: listKey,
        itemBuilder: (context, index, animation) {
          return TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
    );
  }

  void changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }
}
