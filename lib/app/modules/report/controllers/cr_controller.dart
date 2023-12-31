import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/assignment_analytics_model.dart';
import 'package:flutter_mobile_csms/app/modules/report/controllers/report_controller.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_assignment_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CleaningReportController extends ReportController {

  var isLocationAll = true.obs;
  var stateStartDate = false.obs;
  var stateEndDate = false.obs;
  var location = 0.obs;
  RxString tipeFilter = "".obs;
  RxString formatedStartDate = "".obs;
  RxString formatedEndDate = "".obs;
  RxString currentAnalyticsStatus = "".obs;
  DateTime? startDate, endDate;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  AssignmentAnalyticsModel assignAnalytics = AssignmentAnalyticsModel(
      total: 0, statusFinish: 0, statusNotFinish: 0, statusOnProgress: 0);

  //PIE
  var touchedIndex = 0.obs;

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex.value;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.orange,
            value: assignAnalytics.statusOnProgress.toDouble(),
            title:
                '${(assignAnalytics.statusOnProgress.toDouble() / assignAnalytics.total.toDouble() * 100).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: assignAnalytics.statusFinish.toDouble(),
            title:
                '${(assignAnalytics.statusFinish.toDouble() / assignAnalytics.total.toDouble() * 100).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: assignAnalytics.statusNotFinish.toDouble(),
            title:
                '${(assignAnalytics.statusNotFinish.toDouble() / assignAnalytics.total.toDouble() * 100).toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != startDate) {
      stateStartDate.value = true;
      startDate = picked;
    }

    if (startDate != null) {
      formatedStartDate.value = dateFormat.format(startDate!);
    }

    update();
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != endDate) {
      stateEndDate.value = true;
      endDate = picked;
    }

    if (endDate != null) {
      formatedEndDate.value = dateFormat.format(endDate!);
    }

    update();
  }

  Future<void> getAssignmentAnalytics() async {
    String dateNow = dateFormat.format(DateTime.now());
    isLoading.value = true;
    update();
    final response = await CleaningAssignmentService()
        .getAssignmentAnalytics("type=Harian&start_date=$dateNow");
    if (response.statusCode == 200) {
      assignAnalytics = response.data != null
          ? AssignmentAnalyticsModel.fromJson(response.data['data'])
          : AssignmentAnalyticsModel(
              total: 0,
              statusFinish: 0,
              statusNotFinish: 0,
              statusOnProgress: 0);
    }
    isLoading.value = false;
    update();
  }

  Future<void> refetchAssignmentAnalytics() async {
    if (startDate == null || endDate == null || tipeFilter.value == "") {
      snackBar("Warning", "Tanggal harus diisi", SnackPosition.TOP, 10,
          Colors.yellow, Colors.white);
      return;
    }
    String query =
        "type=${tipeFilter.value}&start_date=$formatedStartDate&end_date=$formatedEndDate";

    String locationName = location.value == 3
        ? "Wonoboyo"
        : location.value == 4
            ? "Jombor"
            : location.value == 5
                ? "Kemudo"
                : "Semua Lokasi";

    if (!isLocationAll.value) {
      query += "&location=${location.value}";
    }

    if (tipeFilter.value == "Harian") {
      currentAnalyticsStatus.value =
          "Harian : $formatedStartDate ($locationName)";
    } else if (tipeFilter.value == "Bulanan") {
      currentAnalyticsStatus.value =
          "Bulanan : $formatedStartDate - $formatedEndDate ($locationName)";
    } else if (tipeFilter.value == "Tahunan") {
      currentAnalyticsStatus.value =
          "Tahunan : ${formatedStartDate.split("-").first} ($locationName)";
    }

    isLoading.value = true;
    update();
    final response =
        await CleaningAssignmentService().getAssignmentAnalytics(query);
    if (response.statusCode == 200) {
      assignAnalytics = response.data != null
          ? AssignmentAnalyticsModel.fromJson(response.data['data'])
          : AssignmentAnalyticsModel(
              total: 0,
              statusFinish: 0,
              statusNotFinish: 0,
              statusOnProgress: 0);
      Fluttertoast.showToast(msg: "Sukses Ambil Data");
    }
    isLoading.value = false;
    update();
  }

  //FILE DOWNLOADER
  void exportToExcel() {
    String dateNow = dateFormat.format(DateTime.now());
    String basePath = "/assign_export";
    String queryDefault = "?type=Harian&start_date=$dateNow&end_date=$dateNow";
    String query = "";
    String path = "";

    if (startDate == null && endDate == null && tipeFilter.value == "" && location.value == 0 && isLocationAll.value) {
      path = basePath + queryDefault;
    } else if(location.value != 0 && !isLocationAll.value && startDate == null && endDate == null && tipeFilter.value == ""){
      path = "$basePath$queryDefault&location=${location.value}";
    } else if(startDate !=null && endDate != null && tipeFilter.value != "" && location.value == 0 && isLocationAll.value) {
      query = "?type=${tipeFilter.value}&start_date=$formatedStartDate&end_date=$formatedEndDate";
      path = basePath + query;
    } else if(startDate !=null && endDate != null && tipeFilter.value != "" && location.value != 0 && !isLocationAll.value) {
      query = "?type=${tipeFilter.value}&start_date=$formatedStartDate&end_date=$formatedEndDate&location=${location.value}";
      path = basePath + query;
    }
    
    fileController.downloadExcel(path);
  }

  @override
  void onInit() {
    super.onInit();
    currentAnalyticsStatus.value =
        "Hari Ini ${dateFormat.format(DateTime.now())}";
    getAssignmentAnalytics();
  }
}
