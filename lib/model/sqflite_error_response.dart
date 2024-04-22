class SqfliteError {
  final String? object;
  SqfliteError({this.object});

  String get message => object.toString();
}
