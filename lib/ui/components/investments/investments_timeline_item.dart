import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class InvestmentsTimelineItem extends StatelessWidget {
  const InvestmentsTimelineItem({
    Key? key,
    required this.title,
    required this.date,
    required this.description,
    this.files,
  }) : super(key: key);

  final String title;
  final String date;
  final String description;
  final List<String>? files;

  SizedBox _getFileView() {
    return SizedBox(
      height: 75,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.file_present,
            ),
            iconSize: 24,
            style: IconButton.styleFrom(
              foregroundColor: Colors.deepOrangeAccent,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://sosty.blob.core.windows.net/sosty-public-files/20220823112104.jpeg",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.bodyText1Bold,
          ),
          Text(
            date,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: Styles.bodyText2,
          ),
          _getFileView(),
        ],
      ),
    );
  }
}
