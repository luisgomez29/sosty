import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherHelper {
  LauncherHelper._();

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

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

  static Future<void> launchEmail(String mail,
      {Map<String, String>? params}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail,
      query: params != null ? encodeQueryParameters(params) : null,
    );
    launchUrl(emailLaunchUri);
  }

  static Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchInWebViewOrVC(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(),
    )) {
      throw 'Could not launch $url';
    }
  }
}
