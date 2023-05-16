class AppError {
  final String title;
  final String description;
  AppError({this.title = "", this.description = ""});
  @override
  int get hashCode => title.hashCode ^ description.hashCode;

  factory AppError.copy({String title = "", String description = ""}) {
    return AppError(title: title, description: description);
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppError &&
          other.title == title &&
          other.description == description);
}

class AppSuccess {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AppSuccess;

  @override
  int get hashCode => super.hashCode;
}
