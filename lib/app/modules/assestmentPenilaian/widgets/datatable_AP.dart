import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/assestmentPenilaian/controllers/assestment_penilaian_controller.dart';
import 'package:gap/gap.dart';

Widget datatableAP(AssestmentPenilaianController controller) {
  return Column(
    children: [
      TextField(
        onChanged: (text) {
          controller.source.setFilter(text);
          controller.update();
        },
        decoration: InputDecoration(
          labelText: 'Cari',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      const Gap(10),
      PaginatedDataTable(
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
          const DataColumn(label: Text("Leader")),
          const DataColumn(label: Text("Cleaner")),
          const DataColumn(label: Text("Location")),
          const DataColumn(label: Text("Perilaku (%)")),
          const DataColumn(label: Text("Sikap (%)")),
          const DataColumn(label: Text("Penampilan (%)")),
          const DataColumn(label: Text("Tanggung Jawab (%)")),
          const DataColumn(label: Text("Kompetensi (%)")),
          const DataColumn(label: Text("Total Score (%)")),
          const DataColumn(label: Text("Tanggal Dibuat")),
          const DataColumn(label: Text("Tanggal Diperbarui")),
        ],
        source: controller.source,
        columnSpacing: 100,
        horizontalMargin: 60,
        rowsPerPage: 10,
      ),
    ],
  );
}
