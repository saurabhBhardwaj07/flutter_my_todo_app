import 'package:flutter/material.dart';
import 'package:my_todo_app/core/app_exports.dart';

class TopAppBar extends StatelessWidget {
  final String title;
  const TopAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          20.sbW,
          Text(
            title,
            style: const TextStyle(
              fontFamily: FontFamily.notoSans,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
