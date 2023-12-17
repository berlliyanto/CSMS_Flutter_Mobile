
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningAssignment/controllers/cleaning_assignment_detail_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:flutter_mobile_csms/app/widgets/textfield.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

formDialog( CleaningAssignmentDetailController controller, String title, String message, String messageOk, String messageClose, VoidCallback add,
    VoidCallback submit, VoidCallback cancel, Function onClose) {
  return Get.dialog(
    AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: Get.width * 0.8,
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldNormal("Beri Tugas", controller.tasksController),
            const Gap(10),
            customButton("Tambah", Colors.green, 5, 10, add),
            const Divider(),
            text("List Tugas", 16, Colors.black87, FontWeight.bold, TextAlign.start),
            GetBuilder<CleaningAssignmentDetailController>(
            builder: (builder) {
              return Column(
                children: builder.tasks.asMap().entries.map((entry) {
                  final index = entry.key;
                  final element = entry.value;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(5),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text(element, 14, Colors.black87, FontWeight.normal,
                            TextAlign.start),
                        GestureDetector(
                          onTap: () => controller.deleteTask(index),
                          child: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          ],
        )
      ),
      actions: [
        TextButton(
          onPressed: cancel,
          child: Text(messageClose),
        ),
        TextButton(
          onPressed: submit,
          child: Text(messageOk),
        ),
      ],
    ),
  ).then((value) => onClose());
}