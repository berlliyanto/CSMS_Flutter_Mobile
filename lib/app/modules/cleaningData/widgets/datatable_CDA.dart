import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningData/controllers/cleaning_data_controller.dart';

PaginatedDataTable datatableCDA(CleaningDataController controller) {
  return PaginatedDataTable(
    columns:  [
      const DataColumn(label: Text('No')),
      DataColumn(label: const Row(
        children: [
          Text("Kode Tugas "),
          Icon(Icons.sort),
        ],
      ), 
      onSort: (columnIndex, ascending) {
        controller.sourceAssignment.sort((row) => row.codeCS!, 'code_cs', columnIndex, ascending);
      },),
      const DataColumn(label: Center(child: Text("Leader"))),
      const DataColumn(label: Center(child: Text("Location"))),
      const DataColumn(label: Center(child: Text("Area"))),
      const DataColumn(label: Center(child: Text("Rincian Tugas"))),
      const DataColumn(label: Center(child: Text("Cleaner"))),
      const DataColumn(label: Center(child: Text("Tanggal Dibuat"))),
      const DataColumn(label: Center(child: Text("Verifikasi oleh Supervisor"))),
      const DataColumn(label: Center(child: Text("Verifikasi oleh Danone"))),
      const DataColumn(label: Center(child: Text("Action"))),
    ],
    source: controller.sourceAssignment,
    columnSpacing: 100,
    horizontalMargin: 60,
    dataRowMinHeight: 50,
    dataRowMaxHeight: 70,
    rowsPerPage: 10,
  );
}
