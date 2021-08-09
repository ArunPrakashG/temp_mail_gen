import 'dart:convert';

class MailMessage {
  MailMessage({
    this.id,
    this.from,
    this.subject,
    this.date,
    this.attachments,
    this.body,
    this.textBody,
    this.htmlBody,
  });

  final int? id;
  final String? from;
  final String? subject;
  final DateTime? date;
  final List<Attachment>? attachments;
  final String? body;
  final String? textBody;
  final String? htmlBody;

  factory MailMessage.fromJson(String str) => MailMessage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MailMessage.fromMap(Map<String, dynamic> json) => MailMessage(
        id: json['id'],
        from: json['from'],
        subject: json['subject'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        attachments: json['attachments'] == null ? null : List<Attachment>.from(json['attachments'].map((x) => Attachment.fromMap(x))),
        body: json['body'],
        textBody: json['textBody'],
        htmlBody: json['htmlBody'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'from': from,
        'subject': subject,
        'date': date == null ? null : date!.toIso8601String(),
        'attachments': attachments == null ? null : List<dynamic>.from(attachments!.map((x) => x.toMap())),
        'body': body,
        'textBody': textBody,
        'htmlBody': htmlBody,
      };
}

class Attachment {
  Attachment({
    this.filename,
    this.contentType,
    this.size,
  });

  final String? filename;
  final String? contentType;
  final int? size;

  factory Attachment.fromJson(String str) => Attachment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attachment.fromMap(Map<String, dynamic> json) => Attachment(
        filename: json['filename'],
        contentType: json['contentType'],
        size: json['size'],
      );

  Map<String, dynamic> toMap() => {
        'filename': filename,
        'contentType': contentType,
        'size': size,
      };
}
