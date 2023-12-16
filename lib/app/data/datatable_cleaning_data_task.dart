import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_supervisor_service.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:flutter_mobile_csms/app/widgets/task_image.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum SortOrder { ascending, descending, none }

class DataTableTask extends DataTableSource {
  final List<TasksByCleanerModel> data = [];

  List<TasksByCleanerModel> get filteredData {
    if (searchText.isEmpty && status.isEmpty) {
      return data;
    } else {
      List<TasksByCleanerModel> tempData = List.from(data);
      if (searchText.isNotEmpty) {
        tempData = tempData
            .where((row) =>
                row.cleaner.name.toLowerCase().contains(searchText) ||
                row.assign.assignBy.name.toLowerCase().contains(searchText) ||
                row.assign.location.locationName
                    .toLowerCase()
                    .contains(searchText) ||
                row.assign.area.areaName.toLowerCase().contains(searchText) || 
                row.assign.codeCS.toLowerCase().contains(searchText)) 
            .toList();
      }
      if (status.isNotEmpty) {
        if(status == "supervisor"){
          tempData = tempData.where((row) => row.assign.checkedSupervisorAt == null).toList();
        }else if(status == "danone") {
          tempData = tempData.where((row) => row.assign.verifiedDanoneAt == null).toList();
        }else{
        tempData = tempData
            .where((row) => row.status.toLowerCase().contains(status))
            .toList();
        }
      }
      return tempData;
    }
  }

  String status = '';
  String searchText = '';
  String role = '';
  int total = 0;
  int perPage = 0;
  int currentPage = 1;

  Map<String, SortOrder> sortColumn = {
    'no': SortOrder.none,
    'code_cs': SortOrder.none,
    'leader': SortOrder.none,
    'cleaner': SortOrder.none,
    'location': SortOrder.none,
  };

  Future getRole() async {
    final box = GetStorage();
    String token = box.read('token');
    var value = await AuthService().profile(token);
    role = value.body != null ? value.body['data']['role']['role_name'] : '';
    notifyListeners();
  }

  void updatePaginate(int total, int perPage, int currentPage) {
    this.total = total;
    this.perPage = perPage;
    this.currentPage = currentPage;
    notifyListeners();
  }

  void updateData(List<TasksByCleanerModel> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  void updateDataFromController(List<TasksByCleanerModel> tasks) {
    final newData = tasks.map((item) {
      return TasksByCleanerModel(
        id: item.id,
        cleanerId: item.cleanerId,
        assign: item.assign,
        tasks: item.tasks,
        cleaner: item.cleaner,
        assignId: item.assignId,
        imageBefore: item.imageBefore,
        imageProgress: item.imageProgress,
        imageFinish: item.imageFinish,
        status: item.status,
        alasan: item.alasan,
        catatan: item.catatan,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt,
      );
    }).toList();

    updateData(newData);
  }

  void updateBySupervisor(int id) async {
    final response = await CleaningSupervisorService().updateBySupervisor(id);

    if(response.statusCode == 200){
      Get.back();
      snackBar("Success", response.body['message'], SnackPosition.TOP, 10, Colors.green, Colors.white);
    }else {
      Get.back();
      snackBar("Error", response.body['message'], SnackPosition.TOP, 10, Colors.red, Colors.white);
    }

    notifyListeners();
  }

  void sort<T>(
    Comparable<T> Function(TasksByCleanerModel) getField,
    String columnName,
    int columnIndex,
    bool sortAscending,
  ) {
    //sortColumn.updateAll((key, value) => SortOrder.none);

    if (sortColumn[columnName] == SortOrder.ascending) {
      sortColumn[columnName] = SortOrder.descending;
    } else {
      sortColumn[columnName] = SortOrder.ascending;
    }

    data.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return sortColumn[columnName] == SortOrder.ascending
          ? aValue.compareTo(bValue as T)
          : bValue.compareTo(aValue as T);
    });

    notifyListeners();
  }

  void sortById(bool sortAscending) {
    if (sortColumn['no'] == SortOrder.ascending) {
      sortColumn['no'] = SortOrder.descending;
    } else {
      sortColumn['no'] = SortOrder.ascending;
    }

    data.sort((a, b) {
      final int aValue = filteredData.indexOf(a);
      final int bValue = filteredData.indexOf(b);
      return sortColumn['no'] == SortOrder.ascending
          ? aValue.compareTo(bValue)
          : bValue.compareTo(aValue);
    });

    notifyListeners();
  }

  void setFilter(String text) {
    searchText = text.toLowerCase();
    notifyListeners();
  }

  void setStatus(String text) {
    status = text.toLowerCase();
    notifyListeners();
  }

  void openImage(String image, String type) {
    Get.defaultDialog(
      title: type,
      content: cardImageAPI(image),
    );
  }

  Widget imageRow(dynamic image, String type) {
    if (image == null || image == "") {
      return const Text("-");
    } else {
      return TextButton(
          onPressed: () => openImage(image, type),
          child: const Text("Lihat Gambar"));
    }
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = filteredData[index];

    return DataRow(
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Theme.of(Get.context!).colorScheme.primary.withOpacity(0.08);
        }
        return filteredData.indexOf(currentRow) % 2 == 0
            ? Colors.deepOrange.shade50
            : Colors.white;
      }),
      cells: [
        DataCell(
          Text(
            (filteredData.indexOf(currentRow) + 1).toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.assign.codeCS.toString()
          ),
        ),
        DataCell(
          Text(
            currentRow.cleaner.name.toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.assign.assignBy.name.toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.assign.location.locationName.toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.assign.area.areaName.toString(),
          ),
        ),
        DataCell(SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: currentRow.tasks
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text("- $e"),
                  ),
                )
                .toList(),
          ),
        )),
        DataCell(
          Text(
            currentRow.status.toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.alasan == null ? "-" : currentRow.alasan.toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.catatan == null ? "-" : currentRow.catatan.toString(),
          ),
        ),
        DataCell(
          imageRow(currentRow.imageBefore, "Sebelum"),
        ),
        DataCell(
          imageRow(currentRow.imageProgress, "Proses"),
        ),
        DataCell(
          imageRow(currentRow.imageFinish, "Sesudah"),
        ),
        DataCell(
          Text(
            currentRow.createdAt.toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.assign.checkedSupervisorAt == null
                ? "Belum Verifikasi"
                : currentRow.assign.checkedSupervisorAt.toString(),
            style: TextStyle(
              color: currentRow.assign.checkedSupervisorAt == null
                  ? Colors.red
                  : Colors.black,
            ),
          ),
        ),
        DataCell(
          Text(
            currentRow.assign.verifiedDanoneAt == null
                ? "Belum Verifikasi"
                : currentRow.assign.verifiedDanoneAt.toString(),
            style: TextStyle(
              color: currentRow.assign.verifiedDanoneAt == null
                  ? Colors.red
                  : Colors.black,
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              role == "Supervisor"
                  ? currentRow.assign.checkedSupervisorAt != null
                      ? const Tooltip(
                        message: "Sudah verifikasi",
                        child: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                      )
                      : Tooltip(
                        message: currentRow.status == "Finish" ||
                                      currentRow.status == "Not Finish" ? "Klik untuk verifikasi" : "Belum dapat verifikasi",
                        child: IconButton(
                            onPressed: () {
                              if (currentRow.status == "Finish" ||
                                  currentRow.status == "Not Finish") {
                                dialog("Verifikasi", "Apakah anda yakin ingin verifikasi data ini?", "Ya", "Tidak", () { 
                                  updateBySupervisor(currentRow.assignId);
                                });
                              }
                            },
                            icon: Icon(
                              currentRow.status == "Finish" ||
                                      currentRow.status == "Not Finish"
                                  ? Icons.check_box
                                  : Icons.info_outline,
                              color: currentRow.status == "Finish" ||
                                      currentRow.status == "Not Finish"
                                  ? Colors.green
                                  : Colors.grey,
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                      )
                  : const SizedBox()
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => filteredData.length;

  @override
  int get selectedRowCount => 0;
}
