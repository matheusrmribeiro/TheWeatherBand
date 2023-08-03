import 'package:flutter/material.dart';

dynamic ifNotNull({dynamic value, required VoidCallback action}) {
  if (value != null)
    return action.call();
  else
    return null;
}