import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/task_assignment_model.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/services/Auth/auth_service.dart';
import 'package:flutter_mobile_csms/app/services/CleaningAssignment/cleaning_supervisor_service.dart';
import 'package:flutter_mobile_csms/app/utils/format_date.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum SortOrder { ascending, descending, none }

class DataTableAssignment extends DataTableSource {
  final List<TaskAssignmentModel> data = [];

  List<TaskAssignmentModel> get filteredData {
    if (searchText.isEmpty && status.isEmpty && lokasi.isEmpty) {
      return data;
    } else {
      List<TaskAssignmentModel> tempData = List.from(data);
      if (searchText.isNotEmpty) {
        tempData = tempData
            .where((row) =>
                row.codeCS!.toLowerCase().contains(searchText) ||
                row.assignBy!.name!.toLowerCase().contains(searchText) ||
                row.area!.name!.toLowerCase().contains(searchText) ||
                row.location!.name!.toLowerCase().contains(searchText))
            .toList();
      }
      if (status.isNotEmpty) {
        if (status == "supervisor") {
          tempData =
              tempData.where((row) => row.checkedSupervisorAt == null).toList();
        } else if (status == "danone") {
          tempData =
              tempData.where((row) => row.verifiedDanoneAt == null).toList();
        } else if (status == "selesai") {
          tempData = tempData.where((row) => row.status! == true).toList();
        } else if (status == "noselesai") {
          tempData = tempData.where((row) => row.status! == false).toList();
        } else {
          tempData = tempData;
        }
      }
      if (lokasi.isNotEmpty) {
        if (lokasi != "clear") {
          tempData = tempData
              .where(
                  (row) => row.location!.name!.toLowerCase().contains(lokasi))
              .toList();
        } else {
          tempData = tempData;
        }
      }
      return tempData;
    }
  }

  String status = '';
  String lokasi = '';
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
    role = value.data != null ? value.data['data']['role']['role_name'] : '';
    notifyListeners();
  }

  void updatePaginate(int total, int perPage, int currentPage) {
    this.total = total;
    this.perPage = perPage;
    this.currentPage = currentPage;
    notifyListeners();
  }

  void updateData(List<TaskAssignmentModel> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  void updateDataFromController(List<TaskAssignmentModel> tasks) {
    final newData = tasks.map((item) {
      return TaskAssignmentModel(
        id: item.id,
        assignBy: item.assignBy,
        codeCS: item.codeCS,
        area: item.area,
        location: item.location,
        tasks: item.tasks,
        tasksDetail: item.tasksDetail,
        status: item.status,
        supervisorId: item.supervisorId,
        checkedSupervisorAt: item.checkedSupervisorAt,
        verifiedDanoneAt: item.verifiedDanoneAt,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt,
      );
    }).toList();

    updateData(newData);
  }

  void updateBySupervisor(int id) async {
    final response = await CleaningSupervisorService().updateBySupervisor(id);

    if (response.statusCode == 200) {
      Get.back();
      snackBar("Success", response.data['message'], SnackPosition.TOP, 10,
          Colors.green, Colors.white);
    } else {
      Get.back();
      snackBar("Error", response.data['message'], SnackPosition.TOP, 10,
          Colors.red, Colors.white);
    }

    notifyListeners();
  }

  void sort<T>(
    Comparable<T> Function(TaskAssignmentModel) getField,
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

  void setFilter(String text) {
    searchText = text.toLowerCase();
    notifyListeners();
  }

  void setStatus(String text) {
    status = text.toLowerCase();
    notifyListeners();
  }

  void setLokasi(String text) {
    lokasi = text.toLowerCase();
    notifyListeners();
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
          Text(currentRow.codeCS.toString()),
        ),
        DataCell(
          Text(
            currentRow.assignBy!.name.toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.location!.name.toString(),
          ),
        ),
        DataCell(
          Text(
            currentRow.area!.name.toString(),
          ),
        ),
        DataCell(SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (currentRow.tasks ?? [])
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text("- $e"),
                  ),
                )
                .toList(),
          ),
        )),
        DataCell(SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (currentRow.tasksDetail ?? [])
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text("- ${e.cleaner!.name}"),
                  ),
                )
                .toList(),
          ),
        )),
        DataCell(
          Text(
            currentRow.status! ? "Selesai" : "Belum Selesai",
          ),
        ),
        DataCell(
          Text(
            formatDate(currentRow.createdAt),
          ),
        ),
        DataCell(
          Text(
            currentRow.checkedSupervisorAt == null
                ? "Belum Verifikasi"
                : formatDate(currentRow.checkedSupervisorAt),
            style: TextStyle(
              color: currentRow.checkedSupervisorAt == null
                  ? Colors.red
                  : Colors.black,
            ),
          ),
        ),
        DataCell(
          Text(
            currentRow.verifiedDanoneAt == null
                ? "Belum Verifikasi"
                : formatDate(currentRow.verifiedDanoneAt),
            style: TextStyle(
              color: currentRow.verifiedDanoneAt == null
                  ? Colors.red
                  : Colors.black,
            ),
          ),
        ),
        DataCell(GestureDetector(
          onTap: () => Get.toNamed(Routes.CLEANING_ASSIGNMENT_DETAIL,
              arguments: {"id": currentRow.id}),
          child: const CircleAvatar(
            child: Icon(
              Icons.remove_red_eye_outlined,
            ),
          ),
        )),
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
