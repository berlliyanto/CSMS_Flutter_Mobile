
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FilterByDateProps{
  String tipe;
  DateTime? startDate;
  DateTime? endDate;
  String formattedStartDate;
  String formattedEndDate;
  void Function(String?) onChangeDropdown;
  void Function() onFilterStartDate;
  void Function() onFilterEndDate;

  FilterByDateProps({
    required this.tipe,
    required this.startDate,
    required this.endDate,
    required this.formattedStartDate,
    required this.formattedEndDate,
    required this.onChangeDropdown,
    required this.onFilterStartDate,
    required this.onFilterEndDate,
  });
}

Widget filterByDate(FilterByDateProps props) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black54, width: 1),
        ),
        child: DropdownButton<String>(
          underline: Container(),
          itemHeight: 50,
          borderRadius: BorderRadius.circular(10),
          elevation: 0,
          hint: Text(
            props.tipe.isEmpty
                ? "Pilih Tipe"
                : props.tipe,
          ),
          onChanged: props.onChangeDropdown,
          items: const [
            DropdownMenuItem(
              value: "Harian",
              child: Text("Harian"),
            ),
            DropdownMenuItem(
              value: "Bulanan",
              child: Text("Bulanan"),
            ),
            DropdownMenuItem(
              value: "Tahunan",
              child: Text("Tahunan"),
            ),
          ],
        ),
      ),
      const Gap(5),
      OutlinedButton(
        onPressed: props.onFilterStartDate,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 10)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(
                  color: Colors.blue,
                )))),
        child: props.startDate != null
            ? Text(props.formattedStartDate)
            : const Icon(
                Icons.date_range_outlined,
                size: 14,
              ),
      ),
      const Gap(5),
      const Text("-"),
      const Gap(5),
      OutlinedButton(
        onPressed: props.onFilterEndDate,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 10)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(
                  color: Colors.blue,
                )))),
        child: props.endDate != null
            ? Text(props.formattedEndDate)
            : const Icon(
                Icons.date_range_outlined,
                size: 14,
              ),
      ),
    ],
  );
}
