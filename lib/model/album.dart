// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_types_as_parameter_names

class Album {
  final userId;
  final id;
  final title;

  Album({
    required this.id,
    required this.title,
    required this.userId,
  });
  factory Album.fromjson(Map<String, dynamic> Parsedjson) {
    return Album(
        id: Parsedjson["id"],
        title: Parsedjson["title"],
        userId: Parsedjson["userId"]);
  }
}
