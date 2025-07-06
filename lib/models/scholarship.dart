class Scholarship {
  int id;
  String name;
  String companyName;
  String scholarshipType;
  String scholarshipStatus;
  int coordinatorId;
  List<Requirement> requirements;

  Scholarship({
    required this.id,
    required this.name,
    required this.companyName,
    required this.scholarshipType,
    required this.scholarshipStatus,
    required this.coordinatorId,
    required this.requirements,
  });

  static Scholarship objJson(Map<String, dynamic> json){

    List<Requirement> requirementList = [];
    var jsonRequirements = json["requirements"] as List;

    for(int i = 0; i < jsonRequirements.length; i++) {
      requirementList.add(Requirement.objJson(jsonRequirements[i]));
    }

    return Scholarship(
        id: json["id"] as int,
        name: json["name"] as String,
        companyName: json["companyName"] as String,
        scholarshipType: json["scholarshipType"] as String,
        scholarshipStatus: json["scholarshipStatus"] as String,
        coordinatorId: json["coordinatorId"] as int,
        requirements: requirementList
    );
  }
}

class Requirement {
  String name;
  String description;
  bool isMandatory;

  Requirement({
    required this.name,
    required this.description,
    required this.isMandatory
  });

  static Requirement objJson(Map<String, dynamic> json) {
    return Requirement(
        name: json["name"] as String,
        description: json["description"] as String,
        isMandatory: json["isMandatory"] as bool
     );
  }
}