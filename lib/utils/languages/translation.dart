import 'package:get/get.dart';
import 'package:todo_app/utils/languages/language_maps/ar.dart';
import 'package:todo_app/utils/languages/language_maps/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
