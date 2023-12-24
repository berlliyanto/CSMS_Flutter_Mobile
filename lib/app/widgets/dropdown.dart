import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

Widget dropdown<T>(
    Key key,
    List<T> data,
    String label,
    String hint,
    String Function(T) displayLabel,
    String Function(T) displayValue,
    void Function(List<ValueItem>) selectedOption) {
  return MultiSelectDropDown(
    key: key,
    hint: hint,
    focusNode: FocusScopeNode(
      traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop
    ),
    showClearIcon: true,
    onOptionSelected: selectedOption,
    searchEnabled: true,
    options: data
        .map((e) => ValueItem(
              label: displayLabel(e),
              value: displayValue(e),
            ))
        .toList(),
    selectionType: SelectionType.single,
    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
    dropdownHeight: 350,
    optionTextStyle: const TextStyle(fontSize: 16),
    selectedOptionIcon: const Icon(Icons.check_circle),
  );
}

Widget dropdownAsync<T>(
    Key key,
    Future<List<T>> data,
    String label,
    String hint,
    String Function(T) displayLabel,
    String Function(T) displayValue,
    void Function(List<ValueItem>) selectedOption) {
  return FutureBuilder<List<T>>(
    future: data,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        return dropdown<T>(key, snapshot.data!, label, hint, displayLabel,
            displayValue, selectedOption);
      } else {
        return const Text('No data');
      }
    },
  );
}

// Multiple selection Dropdown

Widget dropdownMultiSelection<T>(
    Key key,
    List<T> data,
    String label,
    String hint,
    String Function(T) displayLabel,
    String Function(T) displayValue,
    void Function(List<ValueItem>) selectedOption) {
  return MultiSelectDropDown(
    key: key,
    showClearIcon: true,
    onOptionSelected: selectedOption,
    searchEnabled: true,
    options: data
        .map((e) => ValueItem(
              label: displayLabel(e),
              value: displayValue(e),
            ))
        .toList(),
    selectionType: SelectionType.multi,
    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
    dropdownHeight: 350,
    optionTextStyle: const TextStyle(fontSize: 16),
    selectedOptionIcon: const Icon(Icons.check_circle),
  );
}

Widget dropdownMultiSelectionAsync<T>(
    Key key,
    Future<List<T>> data,
    String label,
    String hint,
    String Function(T) displayLabel,
    String Function(T) displayValue,
    void Function(List<ValueItem>) selectedOption) {
  return FutureBuilder<List<T>>(
    future: data,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        return dropdownMultiSelection<T>(key, snapshot.data!, label, hint,
            displayLabel, displayValue, selectedOption);
      } else {
        return const Text('No data');
      }
    },
  );
}
