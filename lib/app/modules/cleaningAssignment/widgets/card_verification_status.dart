import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/cleaning_assignment_detail_controller.dart';
import 'package:flutter_mobile_csms/app/utils/format_date.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

Widget cardVerificationStatus(CleaningAssignmentDetailController controller) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 5,
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("Status Verifikasi", 16, Colors.black87, FontWeight.bold,
            TextAlign.start),
        const Divider(),
        RichText(
            text: TextSpan(children: <TextSpan>[
          const TextSpan(
              text: "Supervisor : ",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          if (controller.task.value.checkedSupervisorAt != null)
            TextSpan(
                text: formatDate(controller.task.value.checkedSupervisorAt),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.green.withOpacity(0.8),
                    fontWeight: FontWeight.bold)),
          if (controller.task.value.checkedSupervisorAt == null)
            TextSpan(
                text: "Belum verifikasi",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.8),
                    fontWeight: FontWeight.bold)),
        ])),
        const Gap(8),
        RichText(
            text: TextSpan(children: <TextSpan>[
          const TextSpan(
              text: "Danone : ",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)),
          if (controller.task.value.verifiedDanoneAt != null)
            TextSpan(
                text: formatDate(controller.task.value.verifiedDanoneAt),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.green.withOpacity(0.8),
                    fontWeight: FontWeight.bold)),
          if (controller.task.value.verifiedDanoneAt == null)
            TextSpan(
                text: "Belum verifikasi",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.8),
                    fontWeight: FontWeight.bold)),
        ])),
        const Gap(8),
      ],
    ),
  );
}
