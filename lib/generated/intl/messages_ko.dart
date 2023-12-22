// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "happynewyear": MessageLookupByLibrary.simpleMessage("새해 복 많이 받으세요"),
        "info": MessageLookupByLibrary.simpleMessage(
            "이 앱은 지역에 따라 언어가 다르게 보입니다. 저를 눌러보세요."),
        "merrychristmas": MessageLookupByLibrary.simpleMessage("메리 크리스마스"),
        "tooltip": MessageLookupByLibrary.simpleMessage("언어를 바꾸려면 여기를 누르세요")
      };
}
