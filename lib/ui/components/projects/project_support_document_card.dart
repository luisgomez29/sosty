import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class ProjectSupportDocumentCard extends StatelessWidget {
  const ProjectSupportDocumentCard({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipOval(
              child: Material(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.file_open_outlined,
                    size: 42,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   title,
                    style: Styles.bodyText1Bold,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    "Descargar",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
