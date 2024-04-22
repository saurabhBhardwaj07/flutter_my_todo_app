// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_todo_app/components/custom_button.dart';
import 'package:my_todo_app/components/custom_form_field.dart';
import 'package:my_todo_app/components/top_app_bar.dart';
import 'package:my_todo_app/core/app_exports.dart';
import 'package:my_todo_app/core/extension/empty_box_extension.dart';
import 'package:my_todo_app/core/mixins/date_time_picker.dart';
import 'package:my_todo_app/di_injector.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/presentation/todo_task/bloc/todo_bloc.dart';

class AddEditTaskScreen extends StatefulWidget {
  final TodoTaskModel? model;
  const AddEditTaskScreen({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen>
    with TimeDatePickerMixin {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TodoBloc todoBloc = getIt.get<TodoBloc>();
  String? selectedStatus = "Pending";

  @override
  void initState() {
    if (widget.model != null) {
      title.text = widget.model?.title ?? "";
      desc.text = widget.model?.description ?? "";
      selectedStatus = widget.model?.status ?? "Pending";
      unformate.text = widget.model?.dueDate ?? "";
      dueDate.text = widget.model?.dueDate ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F7F2),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const TopAppBar(
                  title: "Add todo task",
                ),
                20.sbH,
                CustomFormField(
                  inputController: title,
                  hintText: 'Have a coffee',
                  labelText: 'Todo Title',
                ),
                20.sbH,
                TextFormField(
                  minLines: 6,
                  controller: desc,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  validator: (v) {
                    if (v == null) {
                      return "field can't be null";
                    } else if (v.isEmpty) {
                      return "field can't be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Todo Description"),
                    labelStyle: TextStyle(color: Color(0xff5448C8)),
                    filled: true,
                    fillColor: Color(0xffffffff),
                    hintText: 'Coffee makes a person focus',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff5448C8), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffEF4444), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff5448C8), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                20.sbH,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xff5448C8), width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedStatus,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    hint: const Text("Select the status",
                        style: TextStyle(
                            color: Color(0xff5448C8),
                            fontWeight: FontWeight.w500)),
                    items: todoStatus.map((e) {
                      return DropdownMenuItem<String>(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                  )),
                ),
                20.sbH,
                CustomFormField(
                  inputController: dueDate,
                  hintText: 'XX-XX-XXXX | 00:00',
                  labelText: 'Due Date',
                  onTap: () => _launchDateTime(context),
                  readOnly: true,
                ),
                40.sbH,
                BlocListener<TodoBloc, TodoState>(
                    bloc: todoBloc,
                    listenWhen: (previous, current) =>
                        current is TodoActionState,
                    listener: (context, state) {
                      if (state is TodoSuccessActionState) {
                        Navigator.pop(context);
                      }
                      if (state is TodoErrorActionState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Went wrong")));
                      }
                    },
                    child: CustomButton(
                        onPressedCallback: () {
                          if (!_formKey.currentState!.validate()) return;
                          if (widget.model == null) {
                            todoBloc.add(AddTodoEvent(
                                dec: desc.text,
                                title: title.text,
                                status: selectedStatus!,
                                duwDate: unformate.text));
                          } else {
                            todoBloc.add(UpdateTodoEvent(
                                dec: desc.text,
                                title: title.text,
                                status: selectedStatus!,
                                duwDate: unformate.text,
                                taskId: widget.model?.id ?? 0));
                          }
                        },
                        centerText: "Add a Todo Task")),
                20.sbH
              ],
            ),
          ),
        )));
  }

  TextEditingController unformate = TextEditingController();
  void _launchDateTime(BuildContext context) async {
    pickDateFirst(context, dueDate, unformate,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year, DateTime.now().month - 1),
        lastDate: DateTime(DateTime.now().year + 1));
  }
}

List<String> todoStatus = ["Completed", "Pending", "Overdue"];
