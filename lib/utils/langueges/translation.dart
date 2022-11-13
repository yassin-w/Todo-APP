import 'package:get/get.dart';
import 'package:todo_app/utils/langueges/ar.dart';
import 'package:todo_app/utils/langueges/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
