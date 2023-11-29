// import 'dart:developer';

import 'package:checkmate/constants/colors.dart';
import 'package:checkmate/constants/fonts.dart';
import 'package:checkmate/model/todo.dart';
import 'package:checkmate/widgets/text_widget.dart';
import 'package:checkmate/widgets/todo_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Homepage(),
      );
    });
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final todoList = ToDo.todoList();
  List<ToDo> searchedItemList = [];
  late TextEditingController todoController;

  @override
  void initState() {
    todoController = TextEditingController();
    searchedItemList = todoList;
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  _handleTodoTap(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });

    setState(() {
      searchedItemList = todoList;
    });
  }

  _handleDeleteButtonTapped(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
    setState(() {
      searchedItemList = todoList;
    });
  }

  void _addNewTodoItem({required String todo}) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo,
          isDone: false));
    });
    todoController.clear();
    setState(() {
      searchedItemList = todoList;
    });
  }

  void onFilterTodo({required String input}) {
    List<ToDo> result;
    if (input.isEmpty) {
      result = todoList;
    }
    result = todoList
        .where(
            (todo) => todo.todoText.toLowerCase().contains(input.toLowerCase()))
        .toList();

    setState(() {
      searchedItemList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu),
              CircleAvatar(
                  // backgroundImage: AssetImage(
                  //     'assets/images/the_last_air-bender_passport.webp'),
                  ),
            ]),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 4.w,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                searchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5.5.h, bottom: 1.h),
                      child: TextWidget(
                        text: 'All Todos',
                        style: TextStyle(fontSize: 25.sp, fontFamily: fExo),
                      ),
                    ),
                    for (ToDo todoo in searchedItemList.reversed)
                      TodoItem(
                        onTodoTapped: _handleTodoTap,
                        onDeleteButtonTapped: _handleDeleteButtonTapped,
                        todo: todoo,
                      ),
                    Container(
                      color: Colors.transparent,
                      height: 80,
                      width: 29,
                    )
                  ],
                ))
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      margin: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10,
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                            hintText: 'Add a new Todo..',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.sp)),
                            backgroundColor: tblue,
                            elevation: 10,
                            minimumSize: const Size(60, 60)),
                        onPressed: () {
                          _addNewTodoItem(todo: todoController.text);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.w),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: (value) => onFilterTodo(input: value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            hintText: 'Search',
            hintStyle: TextStyle(color: tgrey),
            prefixIcon: Icon(Icons.search),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
