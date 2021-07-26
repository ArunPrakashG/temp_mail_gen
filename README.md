# temp_mail_gen

Unoffical wrapper to get emails from 1secmail api.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:temp_mail_gen/temp_mail_gen.dart';

main() {
  final client = TempMailClient();
  final emails = await client.getEmails(2);
  emails.forEach((element) => print(element));
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
