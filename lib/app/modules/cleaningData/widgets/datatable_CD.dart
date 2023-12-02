import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/cleaningData/controllers/cleaning_data_controller.dart';

PaginatedDataTable datatableCD(CleaningDataController controller) {
  return PaginatedDataTable(
    columns: [
      DataColumn(
        label: const Row(
          children: [
            Text('No'),
            Icon(Icons.sort),
          ],
        ),
        onSort: (columnIndex, ascending) {
          controller.source.sortById(ascending);
          controller.update();
        },
      ),
      const DataColumn(label: Center(child: Text("Cleaner"))),
      const DataColumn(label: Center(child: Text("Leader"))),
      const DataColumn(label: Center(child: Text("Location"))),
      const DataColumn(label: Center(child: Text("Area"))),
      const DataColumn(label: Center(child: Text("Rincian Tugas"))),
      const DataColumn(label: Center(child: Text("Status"))),
      const DataColumn(label: Center(child: Text("Alasan"))),
      const DataColumn(label: Center(child: Text("Catatan"))),
      const DataColumn(label: Center(child: Text("Gambar Sebelum"))),
      const DataColumn(label: Center(child: Text("Gambar Proses"))),
      const DataColumn(label: Center(child: Text("Gambar Sesudah"))),
      const DataColumn(label: Center(child: Text("Tanggal Dibuat"))),
      const DataColumn(label: Center(child: Text("Tanggal Diperbarui"))),
      const DataColumn(label: Center(child: Text("Action"))),
    ],
    source: controller.source,
    columnSpacing: 100,
    horizontalMargin: 60,
    dataRowMinHeight: 50,
    dataRowMaxHeight: 70,
    rowsPerPage: 10,
  );
}
