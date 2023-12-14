
import 'package:flutter_mobile_csms/app/models/area_model.dart';
import 'package:flutter_mobile_csms/app/models/location_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';

class TaskByLeaderModel {
    final int? id;
    final String? codeCS;
    final UserModel? assignBy;
    final AreaModel? area;
    final LocationModel? location;
    final List<String>? tasks;
    final List<TasksDetail>? tasksDetail;
    final dynamic supervisorId;
    final dynamic checkedSupervisorAt;
    final dynamic checkedDanoneAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    TaskByLeaderModel({
        this.id,
        this.codeCS,
        this.assignBy,
        this.area,
        this.location,
        this.tasks,
        this.tasksDetail,
        this.supervisorId,
        this.checkedSupervisorAt,
        this.checkedDanoneAt,
        this.createdAt,
        this.updatedAt,
    });

    factory TaskByLeaderModel.fromJson(Map<String, dynamic> json) => TaskByLeaderModel(
        id: json["id"],
        codeCS: json["code_cs"],
        assignBy: json["assign_by"] == null ? null : UserModel.fromJson(json["assign_by"]),
        area: json["area"] == null ? null : AreaModel.fromJson(json["area"]),
        location: json["location"] == null ? null : LocationModel.fromJson(json["location"]),
        tasks: json["tasks"] == null ? [] : List<String>.from(json["tasks"]!.map((x) => x)),
        tasksDetail: json["tasks_detail"] == null ? [] : List<TasksDetail>.from(json["tasks_detail"]!.map((x) => TasksDetail.fromJson(x))),
        supervisorId: json["supervisor_id"] == null ? null : UserModel.fromJson(json['supervisor_id']),
        checkedSupervisorAt: json["checked_supervisor_at"],
        checkedDanoneAt: json["checked_danone_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

}

class TasksDetail {
    final int? id;
    final int? cleanerId;
    final int? assignId;
    final dynamic imageBefore;
    final dynamic imageProgress;
    final dynamic imageFinish;
    final String? status;
    final dynamic alasan;
    final dynamic catatan;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic deletedAt;
    final UserModel? cleaner;

    TasksDetail({
        this.id,
        this.cleanerId,
        this.assignId,
        this.imageBefore,
        this.imageProgress,
        this.imageFinish,
        this.status,
        this.alasan,
        this.catatan,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.cleaner,
    });

    factory TasksDetail.fromJson(Map<String, dynamic> json) => TasksDetail(
        id: json["id"],
        cleanerId: json['cleaner_id'].runtimeType == int ? json['cleaner_id'] : int.parse(json['cleaner_id']),
        assignId: json["assign_id"].runtimeType == int ? json["assign_id"] : int.parse(json["assign_id"]),
        imageBefore: json["image_before"],
        imageProgress: json["image_progress"],
        imageFinish: json["image_finish"],
        status: json["status"],
        alasan: json["alasan"],
        catatan: json["catatan"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        cleaner: json["cleaner"] == null ? null : UserModel.fromJson(json["cleaner"]),
    );

}
