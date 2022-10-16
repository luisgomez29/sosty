import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/general/content_section.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ContentSection.padding,
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            margin: const EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 6,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageUrl,
                ),
              ),
            ),
          ),
          Text(
            name,
            style: Styles.headline3,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            email,
            style: Styles.bodyText1,
          ),
        ],
      ),
    );
  }
}
