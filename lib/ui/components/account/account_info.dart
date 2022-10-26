import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    Key? key,
    this.imageUrl,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String? imageUrl;
  final String name;
  final String email;

  Container _getProfileImage(context) {
    return imageUrl == null
        ? Container(
            height: 150,
            width: 150,
            margin: const EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 6,
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 100,
            ),
          )
        : Container(
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
                image: CachedNetworkImageProvider(
                  imageUrl!,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Styles.paddingContent,
        ),
        child: Column(
          children: [
            _getProfileImage(context),
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
      ),
    );
  }
}
