import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class NativeActionMethods {
  static const platform = MethodChannel('com.example.directcall/call');

  static Future<void> makePhoneCall(String phoneNumber) async {
    try {
      await platform.invokeMethod('callNumber', {"phoneNumber": phoneNumber});
    } on PlatformException catch (e) {
      debugPrint("Failed to make call: '${e.message}'.");
      MessageShowhelper.showSnackbar(snackBarContent: "Failed to make call");
    }
  }

  static openMessageApp({required String phoneNumber}) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      MessageShowhelper.showSnackbar(snackBarContent: "Could not launch SMS");
    }
  }
}
