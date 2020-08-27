import 'package:flutter/material.dart';
import 'package:ravelinestores/models/section.dart';

class SectionHeader extends StatelessWidget {
  final Section section;
  SectionHeader(this.section);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name ?? 'Clicado ',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
