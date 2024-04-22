import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/components/todo_list_item.dart';
import 'package:my_todo_app/core/app_exports.dart';
import 'package:my_todo_app/di_injector.dart';
import 'package:my_todo_app/model/dashboard_category.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/presentation/dashboard/bloc/dasboard_bloc.dart';
import 'package:my_todo_app/presentation/todo_task/bloc/todo_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TodoBloc todoBloc = getIt.get<TodoBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F7F2),
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          backgroundColor: const Color(0xff5448C8),
          onPressed: () async {
            await Navigator.pushNamed(context, "addEditTask")
                .then((value) => dashBloc.add(DashboardInitialEvent()));
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            bloc: dashBloc..add(DashboardInitialEvent()),
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  dashBloc.add(DashboardInitialEvent());
                },
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text.rich(TextSpan(
                          text: "Hello, Good Morning",
                          style: TextStyle(
                            fontFamily: FontFamily.notoSans,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          children: [
                            TextSpan(text: "\n"),
                            TextSpan(
                              text: "You have work today",
                              style: TextStyle(
                                fontFamily: FontFamily.notoSans,
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ])),
                    ),
                    BlocSelector<DashboardBloc, DashboardState,
                        DashboardCategoryCountState>(
                      bloc: dashBloc,
                      selector: (state) {
                        return state.countState ??
                            const DashboardCategoryCountState();
                      },
                      builder: (context, state) {
                        return GridView.builder(
                          itemCount: cagtegoryList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 5.0,
                            childAspectRatio: 1.6,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "todoList",
                                    arguments: cagtegoryList[index].text);
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: cagtegoryList[index].color,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Image.asset(
                                            cagtegoryList[index].iconPath),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            cagtegoryList[index].text.name,
                                            style: const TextStyle(
                                              fontFamily: FontFamily.notoSans,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          TweenAnimationBuilder<double>(
                                            duration:
                                                const Duration(seconds: 2),
                                            tween: Tween<double>(
                                                begin: 0,
                                                end: state
                                                    .getCountONEnum(
                                                        cagtegoryList[index]
                                                            .text)
                                                    .toDouble()),
                                            builder: (context, value, child) {
                                              return Text(
                                                state
                                                    .getCountONEnum(
                                                        cagtegoryList[index]
                                                            .text)
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontFamily:
                                                      FontFamily.notoSans,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    20.sbH,
                    const Text(
                      "Latest Task",
                      style: TextStyle(
                        fontFamily: FontFamily.notoSans,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    20.sbH,
                    BlocSelector<DashboardBloc, DashboardState,
                        List<TodoTaskModel>>(
                      bloc: dashBloc,
                      selector: (state) {
                        return state.latestTask;
                      },
                      builder: (context, state) {
                        return state.isEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffADFCF9),
                                    borderRadius: BorderRadius.circular(36)),
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(12),
                                child: const Text(
                                  "No todo task is added\n click on + right bottom to add one",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ))
                            : ListView.builder(
                                itemCount: state.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TodoListItem(
                                    model: state[index],
                                    bloc: todoBloc,
                                    onEditCall: () async {
                                      await Navigator.pushNamed(
                                              context, "addEditTask",
                                              arguments: state[index])
                                          .then((value) => dashBloc
                                              .add(DashboardInitialEvent()));
                                    },
                                  );
                                });
                      },
                    )
                  ],
                ),
              );
            },
          ),
        )));
  }
}
