// ignore_for_file: file_names

import 'package:get_storage/get_storage.dart';

class LanguageStorage {
  /// Write
  void saveLanguageToDisk(String langusage) async {
    await GetStorage().write('lang', langusage);
  }

  /// Read
  Future<String> get languageSelected async {
    return await GetStorage().read('lang') ?? 'en';
  }
}
