import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/data/datatable_assestment.dart';
import 'package:flutter_mobile_csms/app/models/assestment_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/services/Assestment/assestment_service.dart';
import 'package:flutter_mobile_csms/app/services/Users/cleaner_service.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AssestmentPenilaianController extends GetxController {
  final DataTableAssestment source = DataTableAssestment();
  List<UserModel> cleaners = [];
  List<CalculateAssessmentModel> calculateAssessment = [];

  RxInt cleanersSelected = 0.obs;
  RxBool isLoading = false.obs;
  var stateStartDate = false.obs;
  var stateEndDate = false.obs;
  RxString tipeFilter = "".obs;
  RxString formatedStartDate = "".obs;
  RxString formatedEndDate = "".obs;
  DateTime? startDate, endDate;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

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

  Future<void> getFilteredAssignByDate() async {

    if(tipeFilter.value.isEmpty || formatedStartDate.value.isEmpty || formatedEndDate.value.isEmpty){
      snackBar("Warning", "Tipe dan tanggal tidak boleh kosong", SnackPosition.TOP, 10, const Color.fromARGB(255, 201, 181, 0), Colors.white);
      return;
    }

    isLoading.value = true;
    update();
    final response = await AssestmentService().getAssestmentFilterByDate(tipeFilter.value, formatedStartDate.value, formatedEndDate.value);
    List<CalculateAssessmentModel> task = [];
    if (response.data != null) {
      task = (response.data['data'] as List)
          .map((e) => CalculateAssessmentModel.fromJson(e))
          .toList();
    } else {
      task = [];
    }

    source.updateDataFromController(task);
  
    isLoading.value = false;
    update();
  }

  Future<List<UserModel>> getCleaners() async {
    isLoading.value = true;
    update();
    final response = await CleanerService().allCleaner();
    List<UserModel> cleaner = [];
    cleaner = response.data != null
        ? (response.data as List).map((e) => UserModel.fromJson(e)).toList()
        : [];
    cleaners = cleaner;

    isLoading.value = false;
    update();
    return cleaner;
  }

  Future<List<CalculateAssessmentModel>> getCalculateAssessmentPerCleaner(
      int id) async {
    final response = await AssestmentService().getAssestmentPerCleaner(id);
    List<CalculateAssessmentModel> calculate = [];
    calculate = response.data != null
        ? (response.data['data'] as List)
            .map((e) => CalculateAssessmentModel.fromJson(e))
            .toList()
        : [];
    update();

    return calculate;
  }

  Future<List<CalculateAssessmentModel>> getCalculateAssestments() async {
    final response = await AssestmentService().getCalculateAssestments();
    List<CalculateAssessmentModel> calculate = [];
    calculate = response.data != null
        ? (response.data['data'] as List)
            .map((e) => CalculateAssessmentModel.fromJson(e))
            .toList()
        : [];
    update();

    return calculate;
  }

  void fetchCalculateAssessment() async {
    isLoading.value = true;
    update();
    calculateAssessment = await getCalculateAssestments();
    source.updateDataFromController(calculateAssessment);
    isLoading.value = false;
    update();
  }

  void updateDataTable() {
    update();
  }

  void refetch() async {
    getCleaners();
    fetchCalculateAssessment();

    tipeFilter.value = "";
    formatedStartDate.value = "";
    formatedEndDate.value = "";
    startDate = null;
    endDate = null;
  }

  @override
  void onInit() {
    super.onInit();
    getCleaners();
    fetchCalculateAssessment();
  }
}
