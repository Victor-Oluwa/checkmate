// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:checkmate/constants/colors.dart';
import 'package:checkmate/constants/fonts.dart';
import 'package:checkmate/model/todo.dart';
import 'package:checkmate/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.todo,
    required this.onTodoTapped,
    required this.onDeleteButtonTapped,
  }) : super(key: key);
  final ToDo todo;
  final onTodoTapped;
  final onDeleteButtonTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: ListTile(
        onTap: () {
          onTodoTapped(todo);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 19.sp, vertical: 4.sp),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
        tileColor: Colors.white,
        leading: todo.isDone == true
            ? const Icon(Icons.check_box)
            : const Icon(Icons.check_box_outline_blank),
        title: TextWidget(
          text: todo.todoText,
          style: TextStyle(
              fontFamily: fExo,
              decoration: todo.isDone == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: 13.sp),
          height: 4.5.h,
          width: 10.w,
          decoration: BoxDecoration(
              color: tRed, borderRadius: BorderRadius.circular(12.sp)),
          child: IconButton(
            iconSize: 17.sp,
            onPressed: () {
              onDeleteButtonTapped(todo.id);
            },
            icon: const Icon(Icons.delete),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
