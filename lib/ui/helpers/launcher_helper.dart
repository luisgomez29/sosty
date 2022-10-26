import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherHelper {
  LauncherHelper._();

  static Future<void> launchWhatsapp(
    BuildContext context,
    String phone,
    String text,
  ) async {
    var androidUrl = "whatsapp://send?phone=$phone&text=$text";
    // var iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";
    try {
      await launchUrl(Uri.parse(androidUrl));
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp no esta instalada en el dispositivo"),
        ),
      );
    }
  }
}
