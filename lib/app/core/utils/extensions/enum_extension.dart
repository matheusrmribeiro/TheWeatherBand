import 'package:flutter/foundation.dart';

extension EnumExtension on Enum {

  String get toText => describeEnum(this);

}