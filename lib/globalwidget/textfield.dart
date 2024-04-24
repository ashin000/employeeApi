import 'package:flutter/material.dart';

class Fieldd extends StatelessWidget {
  final String? labeltext;
  final Widget? prefixicon;
  final TextEditingController? controller;

  const Fieldd({super.key, this.labeltext, this.prefixicon, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            label: Text(labeltext ?? ""),
            prefixIcon: prefixicon,
            border: OutlineInputBorder()),
        controller: controller,
      ),
    );
  }
}
