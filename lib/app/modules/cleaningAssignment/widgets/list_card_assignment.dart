import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/cleaning_assignment_controller.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/widgets/card_assignment.dart';

Column listCardAssignment(CleaningAssignmentController controller) {
  return Column(
    children: controller.listTask.map((e) {
      return cardAssignment(
        e.location!.name!,
        e.area!.name!,
        e.assignBy!.name!,
        e.id!,
        e.supervisorId
      );
    }).toList(),
  );
}

