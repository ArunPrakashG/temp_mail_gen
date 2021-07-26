import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'models/mail_container.dart';
import 'models/mail_message.dart';

class TempMailClient {
  static const String oneSecondMailBaseUrl = 'https://www.1secmail.com/api/v1/';

  Future<List<String>> getDomains() async {
    final response = await http.get(Uri.parse(oneSecondMailBaseUrl + '?action=getDomainList'));

    if (response.statusCode != 200) {
      return null;
    }

    return (jsonDecode(response.body) as Iterable<dynamic>).map<String>((e) => e as String).toList();
  }

  Future<List<String>> getEmails([int count = 1]) async {
    final response = await http.get(Uri.parse(oneSecondMailBaseUrl + '?action=genRandomMailbox&count=$count'));

    if (response.statusCode != 200) {
      return null;
    }

    return (jsonDecode(response.body) as Iterable<dynamic>).map<String>((e) => e as String).toList();
  }

  Future<List<MailContainer>> getMails(String mailId) async {
    if (mailId == null || mailId.isEmpty) {
      return null;
    }

    final split = mailId.split('@');
    final domain = split[1];
    final login = split[0];

    final response = await http.get(Uri.parse(oneSecondMailBaseUrl + '?action=getMessages&login=$login&domain=$domain'));

    if (response.statusCode != 200) {
      return null;
    }

    return (jsonDecode(response.body) as Iterable<dynamic>).map<MailContainer>((e) => MailContainer.fromMap(e)).toList();
  }

  Future<MailMessage> getSingleMail(String mailId, int messageId) async {
    if (mailId == null || mailId.isEmpty || messageId < 0) {
      return null;
    }

    final split = mailId.split('@');
    final domain = split[1];
    final login = split[0];
    final response = await http.get(Uri.parse(oneSecondMailBaseUrl + '?action=readMessage&login=$login&domain=$domain&id=$messageId'));

    if (response.statusCode != 200) {
      return null;
    }

    return MailMessage.fromJson(response.body);
  }

  Future<Uint8List> getAttachment(String mailId, int messageId, String attachmentName) async {
    if (mailId == null || mailId.isEmpty || messageId < 0 || attachmentName == null || attachmentName.isEmpty) {
      return null;
    }

    final split = mailId.split('@');
    final domain = split[1];
    final login = split[0];

    final response =
        await http.get(Uri.parse(oneSecondMailBaseUrl + '?action=download&login=$login&domain=$domain&id=$messageId&file=$attachmentName'));

    if (response.statusCode != 200) {
      return null;
    }

    return response.bodyBytes;
  }
}
