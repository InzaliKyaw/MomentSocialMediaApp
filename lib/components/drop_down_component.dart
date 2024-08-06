import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> dropDownItem;

   CustomDropDown({super.key, required this.dropDownItem});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String selectedItem = "";
  @override
  void initState() {
    selectedItem = widget.dropDownItem.first;
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}