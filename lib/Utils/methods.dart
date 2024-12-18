import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

String capitalizeFirstLetterOfEachWord(String input) {
  List<String> words = input.split(' ');
  List<String> capitalizedWords = words.map((word) {
    if (word.isEmpty) {
      return word; // Return empty string as is
    }
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).toList();
  return capitalizedWords.join(' ');
}

String formatDate(DateTime date) {
  List<String> months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  String month = months[date.month.toInt() - 1];
  String year = date.year.toString();

  return '$month, $year';
}

String countryCodeToCurrencySymbol(code) {
  if (code == "IN") {
    return "₹";
  } else if (code == "US") {
    return "\$";
  } else if (code == "GB") {
    return "£";
  } else if (code == "AU") {
    return "\$";
  } else if (code == "CA") {
    return "\$";
  } else {
    return "\$";
  }
}

String countryCodeToDailingCode(code) {
  if (code == "IN") {
    return "+91";
  } else if (code == "US") {
    return "+1";
  } else if (code == "GB") {
    return "+44";
  } else if (code == "AU") {
    return "+61";
  } else if (code == "CA") {
    return "+1";
  } else {
    return "";
  }
}

String countryCodeToCurrency(String code) {
  if (code == "IN") {
    return "INR";
  } else if (code == "US") {
    return "USD";
  } else if (code == "GB") {
    return "GBP";
  } else if (code == "AU") {
    return "AUD";
  } else if (code == "CA") {
    return "CAD";
  } else {
    return "USD";
  }
}

void shareTextAndImage(
    BuildContext context, String text, String assetPath) async {
  try {
    // Load image from assets
    final byteData = await rootBundle.load(assetPath);

    // Get temporary directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/shared_image.png');

    // Write image to temporary file
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Share text and image
    Share.shareXFiles([XFile(file.path)], text: text);
  } catch (e) {
    print('Error sharing image and text: $e');
  }
}
