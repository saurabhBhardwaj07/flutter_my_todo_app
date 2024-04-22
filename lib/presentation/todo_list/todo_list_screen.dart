import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/components/todo_filter_bottom_sheet.dart';
import 'package:my_todo_app/components/todo_list_item.dart';
import 'package:my_todo_app/components/top_app_bar.dart';
import 'package:my_todo_app/core/app_exports.dart';
import 'package:my_todo_app/core/enum/dashboard_category_enum.dart';
import 'package:my_todo_app/di_injector.dart';
import 'package:my_todo_app/model/dashboard_category.dart';
import 'package:my_todo_app/presentation/todo_list/bloc/todo_list_bloc.dart';
import 'package:my_todo_app/presentation/todo_task/bloc/todo_bloc.dart';

class TodoListScreen extends StatefulWidget {
  final DashboardCategoryEnum category;
  const TodoListScreen({super.key, required this.category});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoListBloc todoListBloc = getIt.get<TodoListBloc>();
  TodoBloc todoBloc = getIt.get<TodoBloc>();
  bool _isAscending = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F7F2),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const TopAppBar(
                title: "",
              ),
              20.sbH,
              Row(
                children: [
                  Text(
                    "${widget.category.name} Today's List",
                    style: const TextStyle(
                      fontFamily: FontFamily.notoSans,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<TodoListBloc, TodoListState>(
                    bloc: todoListBloc,
                    builder: (context, state) {
                      return IconButton(
                        icon: RotationTransition(
                          turns: todoListBloc.isDesc
                              ? const AlwaysStoppedAnimation(0)
                              : const AlwaysStoppedAnimation(0.5),
                          child: const Icon(
                              Icons.arrow_upward), // Upward arrow icon
                        ),
                        onPressed: () {
                          setState(() {
                            todoListBloc.isDesc = !todoListBloc.isDesc;
                          }); // Toggle sorting order
                        },
                      );
                    },
                  ),
                  if (widget.category == DashboardCategoryEnum.all)
                    IconButton(
                        onPressed: () async {
                          await showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white70,
                              isScrollControlled: false,
                              builder: (context) => TodoFilterBottomSheet(
                                    removeCallback: () {
                                      Navigator.pop(context);
                                      todoListBloc.add(TodoInitialEvent(
                                          categoryEnum: widget.category));
                                    },
                                    applyCallback: (v) {
                                      todoListBloc.add(TodoInitialEvent(
                                          categoryEnum: widget.category,
                                          status: v));
                                      Navigator.pop(context);
                                    },
                                  ));
                        },
                        icon: Icon(Icons.filter_list))
                ],
              ),
              20.sbH,
              BlocConsumer<TodoListBloc, TodoListState>(
                bloc: todoListBloc
                  ..add(TodoInitialEvent(categoryEnum: widget.category)),
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case TodoResponseState:
                      final sucessState = state as TodoResponseState;

                      return sucessState.taskList.isEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffADFCF9),
                                  borderRadius: BorderRadius.circular(36)),
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 50),
                              padding: const EdgeInsets.all(15),
                              child: const Text(
                                "No todo task is Founded",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ))
                          : ListView.builder(
                              itemCount: state.taskList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Material(
                                  color: const Color(0xffF2F7F2),
                                  child: TodoListItem(
                                    model: state.taskList[index],
                                    bloc: todoBloc,
                                    onEditCall: () async {
                                      await Navigator.pushNamed(
                                              context, "addEditTask",
                                              arguments: state.taskList[index])
                                          .then(
                                        (value) => todoListBloc
                                          ..add(TodoInitialEvent(
                                              categoryEnum: widget.category)),
                                      );
                                    },
                                  ),
                                );
                              });
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        )));
  }
}
