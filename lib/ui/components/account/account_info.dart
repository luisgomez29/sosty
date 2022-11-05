import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sosty/domain/models/user/user.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/general/content_section.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  Container _getProfileImage(context) {
    return user.profilePictureUrl == null
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
                  user.profilePictureUrl!,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Styles.paddingContent,
            ),
            child: Column(
              children: [
                _getProfileImage(context),
                Text(
                  "${user.profileDetails[0].firstName} ${user.profileDetails[0].lastName}",
                  style: Styles.headline3,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  user.email,
                  style: Styles.bodyText1,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        ContentSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Celular",
                style: Styles.bodyText1Bold,
              ),
              Text(
                user.profileDetails[0].contactCellphone,
                style: Styles.bodyText1,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Ubicación",
                style: Styles.bodyText1Bold,
              ),
              Text(
                "${user.profileDetails[0].city ?? ""} - ${user.profileDetails[0].state ?? ""}",
                style: Styles.bodyText1,
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
