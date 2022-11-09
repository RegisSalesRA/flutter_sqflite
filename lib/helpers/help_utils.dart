import 'package:flutter/material.dart';

void closeKeyboard(context){
  FocusScope.of(context).unfocus();
}