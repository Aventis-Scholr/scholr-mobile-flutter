class Apoderado {
  int id;
  String name;

  Apoderado({
    required this.id,
    required this.name
  });

  static Apoderado objJson(Map<String, dynamic> json) {
    return Apoderado(
    id: json["id"] as int,
    name: json["username"] as String
    );
  }
}