import 'dart:async';

import 'package:temp_mail_gen/temp_mail_gen.dart';

void main() async {
  final client = TempMailClient();
  final emails = await (client.getEmails(2) as FutureOr<List<String>>);
  emails.forEach((element) => print(element));
}
