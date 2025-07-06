class Scholarship {
  int id;
  String name;
  String companyName;
  String scholarshipType;
  String scholarshipStatus;
  int coordinatorId;

  Scholarship({
    required this.id,
    required this.name,
    required this.companyName,
    required this.scholarshipType,
    required this.scholarshipStatus,
    required this.coordinatorId
  });

  static Scholarship objJson(Map<String, dynamic> json){
    return Scholarship(
        id: json["id"] as int,
        name: json["name"] as String,
        companyName: json["companyName"] as String,
        scholarshipType: json["scholarshipType"] as String,
        scholarshipStatus: json["scholarshipStatus"] as String,
        coordinatorId: json["coordinatorId"] as int
    );
  }
}