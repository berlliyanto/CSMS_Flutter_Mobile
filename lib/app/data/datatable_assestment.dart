import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/assestment_model.dart';
import 'package:get/get.dart';

enum SortOrder { ascending, descending, none }

class DataTableAssestment extends DataTableSource {
  final List<CalculateAssessmentModel> data = [];

  List<CalculateAssessmentModel> get filteredData {
    if (searchText.isEmpty && cleaner.isEmpty) {
      return data;
    } else {
      List<CalculateAssessmentModel> tempData = List.from(data);
      if(searchText.isNotEmpty){
        return tempData
          .where(
            (row) =>
                row.leader['name']
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                row.location['location_name']
                    .toString()
                    .toLowerCase()
                    .contains(searchText) ||
                row.cleaner['name']
                    .toString()
                    .toLowerCase()
                    .contains(searchText),
          )
          .toList();
      }
      if(cleaner.isNotEmpty){
        return tempData.where((element) => element.cleaner['name'] == cleaner).toList();
      }
      return tempData;
    }
  }

  String searchText = '';
  String cleaner = '';

  Map<String, SortOrder> sortColumn = {
    'no': SortOrder.none,
    'leader': SortOrder.none,
    'cleaner': SortOrder.none,
    'location': SortOrder.none,
  };

  void updateData(List<CalculateAssessmentModel> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  void updateDataFromController(
      List<CalculateAssessmentModel> calculateAssessment) {
    final newData = calculateAssessment.map((item) {
      return CalculateAssessmentModel(
        id: item.id,
        leader: item.leader,
        cleaner: item.cleaner,
        location: item.location,
        perilaku: item.perilaku,
        sikap: item.sikap,
        penampilan: item.penampilan,
        tanggungJawab: item.tanggungJawab,
        kompetensi: item.kompetensi,
        total: item.total,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt,
      );
    }).toList();

    updateData(newData);
  }

  void sort<T>(
    Comparable<T> Function(CalculateAssessmentModel) getField,
    String columnName,
    int columnIndex,
    bool sortAscending,
  ) {
    sortColumn.updateAll((key, value) => SortOrder.none);

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

  void setCleaner(String text) {
    cleaner = text.toLowerCase();
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
        DataCell(Center(
            child: Text((filteredData.indexOf(currentRow) + 1).toString()))),
        DataCell(Center(child: Text(currentRow.leader['name'].toString()))),
        DataCell(Center(child: Text(currentRow.cleaner['name'].toString()))),
        DataCell(Center(
            child: Text(currentRow.location['location_name'].toString()))),
        DataCell(Center(child: Text(currentRow.perilaku.toString()))),
        DataCell(Center(child: Text(currentRow.sikap.toString()))),
        DataCell(Center(child: Text(currentRow.penampilan.toString()))),
        DataCell(Center(child: Text(currentRow.tanggungJawab.toString()))),
        DataCell(Center(child: Text(currentRow.kompetensi.toString()))),
        DataCell(Center(child: Text(currentRow.total.toString()))),
        DataCell(Center(child: Text(currentRow.createdAt.toString()))),
        DataCell(Center(child: Text(currentRow.updatedAt.toString()))),
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
