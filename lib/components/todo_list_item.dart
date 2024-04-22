// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_todo_app/core/app_exports.dart';
import 'package:my_todo_app/di_injector.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/presentation/dashboard/bloc/dasboard_bloc.dart';
import 'package:my_todo_app/presentation/todo_task/bloc/todo_bloc.dart';

class TodoListItem extends StatelessWidget {
  final TodoTaskModel model;
  final TodoBloc bloc;
  final void Function()? onEditCall;
  const TodoListItem({
    Key? key,
    required this.model,
    required this.bloc,
    this.onEditCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(model.dueDate.toString());
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xffADFCF9),
            borderRadius: BorderRadius.circular(36)),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset("assets/images/reboot.png"),
            ),
            15.sbW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                          size: 18, color: Colors.grey),
                      4.sbW,
                      Text(
                        DateFormat.yMMMMd()
                            .format(DateTime.parse(model.dueDate.toString())),
                        style: TextStyle(color: Colors.grey),
                      ),
                      10.sbW,
                      const Icon(Icons.timer_sharp,
                          size: 18, color: Colors.grey),
                      4.sbW,
                      Text(
                        DateFormat.Hm()
                            .format(DateTime.parse(model.dueDate.toString())),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  10.sbH,
                  Text(
                    model.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: FontFamily.notoSans,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    model.description ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: FontFamily.notoSans,
                      fontSize: 12,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            15.sbW,
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: Theme(
                data: Theme.of(context).copyWith(
                    cardColor: const Color(0xffF2F7F2),
                    popupMenuTheme: const PopupMenuThemeData(
                      color: Color(0xffF2F7F2),
                      surfaceTintColor: Color(0xffF2F7F2),
                    )),
                child: BlocListener<TodoBloc, TodoState>(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is TodoSuccessActionState) {
                      dashBloc.add(DashboardInitialEvent());
                    }
                    if (state is TodoErrorActionState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Went wrong")));
                    }
                  },
                  child: PopupMenuButton(
                      iconSize: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      itemBuilder: ((context) {
                        return [
                          PopupMenuItem(
                              onTap: onEditCall,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  10.sbW,
                                  const Text("Edit"),
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () =>
                                  bloc.add(DeleteTodoEvent(id: model.id ?? 0)),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  10.sbW,
                                  const Text("Delete"),
                                ],
                              ))
                        ];
                      }),
                      child: const Icon(
                        Icons.more_horiz,
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
