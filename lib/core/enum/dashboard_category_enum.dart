enum DashboardCategoryEnum {
  all("All"),
  today("Today's"),
  complete("Completed"),
  overdue("Overdue");

  const DashboardCategoryEnum(this.name);
  final String name;
}
