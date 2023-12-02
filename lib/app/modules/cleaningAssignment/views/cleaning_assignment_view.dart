import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cleaning_assignment_controller.dart';

class CleaningAssignmentView extends GetView<CleaningAssignmentController> {
  const CleaningAssignmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Saya'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CleaningAssignmentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
