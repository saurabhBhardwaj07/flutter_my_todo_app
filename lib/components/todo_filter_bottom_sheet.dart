// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_todo_app/components/custom_button.dart';
import 'package:my_todo_app/core/app_exports.dart';
import 'package:my_todo_app/presentation/todo_task/add_edit_task_Screen.dart';

class TodoFilterBottomSheet extends StatefulWidget {
  final void Function()? removeCallback;
  final void Function(String)? applyCallback;

  const TodoFilterBottomSheet({
    Key? key,
    this.removeCallback,
    this.applyCallback,
  }) : super(key: key);

  @override
  State<TodoFilterBottomSheet> createState() => _TodoFilterBottomSheetState();
}

class _TodoFilterBottomSheetState extends State<TodoFilterBottomSheet> {
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          30.sbH,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Filters",
              style: TextStyle(
                fontFamily: FontFamily.notoSans,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          20.sbH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Wrap(
              children: todoStatus
                  .map((e) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.amber,
                            ),
                            child: Checkbox(
                                activeColor: Color(0xff5448C8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                value: selectedCategories.contains(e),
                                onChanged: (checked) {
                                  if (selectedCategories.contains(e)) {
                                    selectedCategories.remove(e);
                                  } else {
                                    selectedCategories.clear();
                                    selectedCategories.add(e);
                                  }
                                  setState(() {});
                                }),
                          ),
                          Text(e,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500))
                        ],
                      ))
                  .toList(),
            ),
          ),
          20.sbH,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                      onPressedCallback: widget.removeCallback,
                      centerText: "Remove filter"),
                ),
                40.sbW,
                Expanded(
                  child: CustomButton(
                      onPressedCallback: () {
                        if (selectedCategories.isNotEmpty) {
                          widget.applyCallback?.call(selectedCategories.first);
                        
                        }
                      },
                      centerText: "Apply Filter"),
                ),
              ],
            ),
          ),
          40.sbH
        ],
      ),
    );
  }
}
