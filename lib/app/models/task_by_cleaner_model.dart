class AllTasksByCleanerModel{
  final String status;
  final int count;
  final List<TasksByCleanerModel> tasks;

  AllTasksByCleanerModel({
    required this.status,
    required this.count,
    required this.tasks,
  });

  factory AllTasksByCleanerModel.fromJson(Map<String, dynamic> json) => AllTasksByCleanerModel(
    status: json["status"],
    count: json["count"],
    tasks: List<TasksByCleanerModel>.from(json["tasks"].map((x) => TasksByCleanerModel.fromJson(x))),
  );
}


class TasksByCleanerModel {
    final int id;
    final int cleanerId;
    final int assignId;
    final List<String> tasks;
    final dynamic imageBefore;
    final dynamic imageProgress;
    final dynamic imageFinish;
    final dynamic status;
    final dynamic alasan;
    final dynamic catatan;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Assign assign;
    final Cleaner cleaner;

    TasksByCleanerModel({
        required this.id,
        required this.cleanerId,
        required this.assignId,
        required this.tasks,
        required this.imageBefore,
        required this.imageProgress,
        required this.imageFinish,
        required this.status,
        required this.alasan,
        required this.catatan,
        required this.createdAt,
        required this.updatedAt,
        required this.assign,
        required this.cleaner,
    });

    factory TasksByCleanerModel.fromJson(Map<String, dynamic> json) => TasksByCleanerModel(
        id: json["id"],
        cleanerId: json["cleaner_id"],
        assignId: json["assign_id"],
        tasks: List<String>.from(json["tasks"].map((x) => x)),
        imageBefore: json["image_before"],
        imageProgress: json["image_progress"],
        imageFinish: json["image_finish"],
        status: json["status"],
        alasan: json["alasan"],
        catatan: json["catatan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        assign: Assign.fromJson(json["assign"]),
        cleaner: Cleaner.fromJson(json["cleaner"]),
    );

}

class Assign {
    final int id;
    final String codeCS;
    final Cleaner assignBy;
    final Area area;
    final Location location;
    final dynamic checkedSupervisorAt;
    final dynamic verifiedDanoneAt;

    Assign({
        required this.id,
        required this.codeCS,
        required this.assignBy,
        required this.area,
        required this.location,
        required this.checkedSupervisorAt,
        required this.verifiedDanoneAt,
    });

    factory Assign.fromJson(Map<String, dynamic> json) => Assign(
        id: json["id"],
        codeCS: json["code_cs"] ?? "",
        assignBy: Cleaner.fromJson(json["assign_by"]),
        area: Area.fromJson(json["area"]),
        location: Location.fromJson(json["location"]),
        checkedSupervisorAt: json["checked_supervisor_at"],
        verifiedDanoneAt: json["verified_danone_at"],
    );

}

class Area {
    final int id;
    final String areaName;

    Area({
        required this.id,
        required this.areaName,
    });

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        areaName: json["area_name"],
    );

}

class Cleaner {
    final int id;
    final String name;

    Cleaner({
        required this.id,
        required this.name,
    });

    factory Cleaner.fromJson(Map<String, dynamic> json) => Cleaner(
        id: json["id"],
        name: json["name"],
    );

}

class Location {
    final int id;
    final String locationName;

    Location({
        required this.id,
        required this.locationName,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        locationName: json["location_name"],
    );

}
