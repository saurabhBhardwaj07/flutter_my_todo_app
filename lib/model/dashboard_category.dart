// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_todo_app/core/enum/dashboard_category_enum.dart';

class DashboardCategory {
  final DashboardCategoryEnum text;
  final Color color;
  final String iconPath;
  final VoidCallback onTab;
  DashboardCategory({
    required this.text,
    required this.color,
    required this.iconPath,
    required this.onTab,
  });
}

List<DashboardCategory> cagtegoryList = [
  DashboardCategory(
      text: DashboardCategoryEnum.all,
      color: const Color(0xFFDBFE87),
      iconPath: "assets/images/reboot.png",
      onTab: () {}),
  DashboardCategory(
      text: DashboardCategoryEnum.today,
      color: const Color(0xFF6EFAFB),
      iconPath: "assets/images/time.png",
      onTab: () {}),
  DashboardCategory(
      text: DashboardCategoryEnum.complete,
      color: const Color(0xFfFFD5FF),
      iconPath: "assets/images/checkmark.png",
      onTab: () {}),
  DashboardCategory(
      text: DashboardCategoryEnum.overdue,
      color: const Color(0xffB7B5E4),
      iconPath: "assets/images/pending.png",
      onTab: () {}),
];
