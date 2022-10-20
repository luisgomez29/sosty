import 'package:flutter/material.dart';
import 'package:sosty/ui/components/general/section_title.dart';

class LoadDataError extends StatelessWidget {
  const LoadDataError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SectionTitle(
      title: "Error al cargar datos",
    );
  }
}
