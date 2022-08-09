import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(String inpUrl) async {
  Uri uri = Uri.parse(inpUrl);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
