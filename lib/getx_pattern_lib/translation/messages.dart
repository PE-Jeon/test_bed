import 'package:get/get.dart';

class Messages extends Translations {

  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'Hello World',
    },
    'ko_KR': {
      'hello': '안녕하세요.',
    }
  };
}