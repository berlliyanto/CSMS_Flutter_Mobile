import 'package:flutter_mobile_csms/app/data/datatable_assestment.dart';
import 'package:flutter_mobile_csms/app/models/assestment_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/services/Assestment/assestment_service.dart';
import 'package:flutter_mobile_csms/app/services/Users/cleaner_service.dart';
import 'package:get/get.dart';

class AssestmentPenilaianController extends GetxController {
  final DataTableAssestment source = DataTableAssestment();
  List<CleanerModel> cleaners = [];
  List<CalculateAssessmentModel> calculateAssessment = [];
  RxInt cleanersSelected = 0.obs;
  RxBool isLoading = false.obs;

  Future<List<CleanerModel>> getCleaners() async {
    isLoading.value = true;
    update();
    final response = await CleanerService().allCleaner();
    List<CleanerModel> cleaner = [];
    cleaner = response.body != null
        ? (response.body as List).map((e) => CleanerModel.fromJson(e)).toList()
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
    calculate = response.body != null
        ? (response.body['data'] as List)
            .map((e) => CalculateAssessmentModel.fromJson(e))
            .toList()
        : [];
    update();

    return calculate;
  }

  void fetchCalculateAssessment(int id) async {
    isLoading.value = true;
    update();
    calculateAssessment = await getCalculateAssessmentPerCleaner(id);
    source.updateDataFromController(calculateAssessment);
    isLoading.value = false;
    update();
  }

  void updateDataTable() {
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getCleaners();
  }

}
