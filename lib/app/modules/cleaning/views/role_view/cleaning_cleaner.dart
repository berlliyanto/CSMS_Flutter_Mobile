import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/controllers/cleaning_controller.dart';
import 'package:flutter_mobile_csms/app/modules/cleaning/widgets/card_task_cleaner.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

Widget cleaningCleaner(CleaningController controller) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text("Tugas Anda", 20, Colors.black87, FontWeight.w800,
              TextAlign.start),
          const Gap(15),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              List<TasksByCleanerModel> tasksByStatus = controller
                  .tasksByCleaner
                  .expand((element) => element.tasks)
                  .where((task) {
                switch (index) {
                  case 0:
                    return task.status == "Pending";
                  case 1:
                    return task.status == "On Progress";
                  case 2:
                    return task.status == "Finish";
                  case 3:
                    return task.status == "Not Finish";
                  default:
                    return false;
                }
              }).toList();

              if (tasksByStatus.isEmpty) {
                return const SizedBox();
              }

              if (index == 2 || index == 3) {
                return accordion(
                    tasksByStatus, getStatusText(index), getStatusColor(index));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      getStatusText(index),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(index),
                      ),
                    ),
                  ),
                  Column(
                    children: tasksByStatus.map((e) {
                      return cardTaskCleaner(
                        e.assign.codeCS,
                        e.assign.location.locationName,
                        e.assign.area.areaName,
                        e.assign.assignBy.name,
                        e.id,
                        e.assignId,
                        e.status,
                      );
                    }).toList(),
                  ),
                  
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}

String getStatusText(int index) {
  switch (index) {
    case 0:
      return "Pending";
    case 1:
      return "On Progress";
    case 2:
      return "Finish";
    case 3:
      return "Not Finish";
    default:
      return "";
  }
}

Color getStatusColor(int index) {
  switch (index) {
    case 0:
      return Colors.grey;
    case 1:
      return Colors.orange;
    case 2:
      return Colors.green;
    case 3:
      return Colors.red;
    default:
      return Colors.black;
  }
}

Widget accordion(
    List<TasksByCleanerModel> tasks, String title, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 1),
    ),
    child: ExpansionTile(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      collapsedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      collapsedBackgroundColor: Colors.white,
      iconColor: color,
      backgroundColor: Colors.white,
      childrenPadding: const EdgeInsets.all(8),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      children: [
        Column(
          children: tasks.map((task) {
            return cardTaskCleaner(
              task.assign.codeCS,
              task.assign.location.locationName,
              task.assign.area.areaName,
              task.assign.assignBy.name,
              task.id,
              task.assignId,
              task.status,
            );
          }).toList(),
        ),
      ],
    ),
  );
}