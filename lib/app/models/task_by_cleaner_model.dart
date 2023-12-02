class allTasksByCleanerModel{
  final String status;
  final int count;
  final List<TasksByCleanerModel> tasks;

  allTasksByCleanerModel({
    required this.status,
    required this.count,
    required this.tasks,
  });

  factory allTasksByCleanerModel.fromJson(Map<String, dynamic> json) => allTasksByCleanerModel(
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
    final String createdAt;
    final String updatedAt;
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        assign: Assign.fromJson(json["assign"]),
        cleaner: Cleaner.fromJson(json["cleaner"]),
    );

}

class Assign {
    final int id;
    final Cleaner assignBy;
    final Area area;
    final Location location;

    Assign({
        required this.id,
        required this.assignBy,
        required this.area,
        required this.location,
    });

    factory Assign.fromJson(Map<String, dynamic> json) => Assign(
        id: json["id"],
        assignBy: Cleaner.fromJson(json["assign_by"]),
        area: Area.fromJson(json["area"]),
        location: Location.fromJson(json["location"]),
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