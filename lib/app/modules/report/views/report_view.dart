import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/report/widgets/assestment_report.dart';
import 'package:flutter_mobile_csms/app/modules/report/widgets/cleaning_report.dart';
import 'package:flutter_mobile_csms/app/modules/report/widgets/training_report.dart';

import 'package:get/get.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({Key? key}) : super(key: key);

  static const List<Tab> myTab = [
    Tab(
      text: "Cleaning",
      icon: Icon(Icons.cleaning_services),
    ),
    Tab(
      text: "Training",
      icon: Icon(Icons.task),
    ),
    Tab(
      text: "Assessment",
      icon: Icon(Icons.assessment),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTab.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Report'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: myTab,
            indicatorColor: Colors.deepOrange,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.grey,
            indicatorPadding: EdgeInsets.all(5),
          ),
        ),
        body: TabBarView(
          children: [
            CleaningReport(),
            TrainingReport(),
            AssestmentReport()
          ]
        )
      ),
    );
  }
}
