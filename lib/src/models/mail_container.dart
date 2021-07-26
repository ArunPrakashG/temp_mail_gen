import 'dart:convert';

class MailContainer {
  MailContainer({
    this.id,
    this.from,
    this.subject,
    this.date,
  });

  final int id;
  final String from;
  final String subject;
  final DateTime date;

  factory MailContainer.fromJson(String str) => MailContainer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MailContainer.fromMap(Map<String, dynamic> json) => MailContainer(
        id: json['id'],
        from: json['from'],
        subject: json['subject'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'from': from,
        'subject': subject,
        'date': date == null ? null : date.toIso8601String(),
      };
}
